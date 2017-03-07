% ITESM CEM, March 7, 2017.
% Erlang Source File
% Activity: Sequential Erlang
% Authors: 
%          A01167870 Joel Narváez Valdivieso
%          A01373631 Andrea Margarita Pérez Barrera
% cd("c:/Users/usuario/Documents/ISC/8voSemestre/Programación_Multinúcleo/erlang").

-module(sequential).
-compile(export_all).

% ----------------------------------------------------------------------------------
but_last([_N]) ->
[];
but_last([H | T]) ->
[H | but_last(T)].

% ----------------------------------------------------------------------------------
merge([],[]) ->
[];
merge([H1 | T1], []) ->
[H1 | merge(T1,[])];
merge([],[H2 | T2]) ->
[H2 | merge([], T2)];
merge([H1 | T1], [H2 | T2]) when H1 > H2 ->
[H2 | merge([H1 |T1],T2)];
merge([H1 | T1], [H2 | T2]) ->
[H1 | merge(T1,[H2 | T2])].

% ----------------------------------------------------------------------------------
% El shell a veces interpreta las listas de enteros como string
% shell:strings(false). para evitarlo [http://erlang.org/faq/problems.html 9.3]
insert(A, []) ->
[A | []];
insert(A, [H | T]) when A < H ->
[A, H | T];
insert(A, [H | T]) ->
[H | insert(A, T)].

% ----------------------------------------------------------------------------------
sort([]) ->
[];
sort([H | T]) ->
insert(H, sort(T)).

% ----------------------------------------------------------------------------------
binary(0) -> [];
binary(N) ->
lists:append([binary(N div 2), [N rem 2]]).

% ----------------------------------------------------------------------------------
% shell:strings(true).
bcd(0) -> ["0000"];
bcd(N) -> lists:append("00", "11").

% ----------------------------------------------------------------------------------
prime_factors(1) -> [];
prime_factors(N) when N rem N - 1 == 0 ->
prime_factors(N - 1).


