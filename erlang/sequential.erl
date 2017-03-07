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
% 1. But_last
but_last([_N]) ->
[];
but_last([H | T]) ->
[H | but_last(T)].

% ----------------------------------------------------------------------------------
% 2. Merge
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
% 3. Insert
% El shell a veces interpreta las listas de enteros como string
% shell:strings(false). para evitarlo [http://erlang.org/faq/problems.html 9.3]
insert(A, []) ->
[A | []];
insert(A, [H | T]) when A < H ->
[A, H | T];
insert(A, [H | T]) ->
[H | insert(A, T)].

% ----------------------------------------------------------------------------------
% 4. Sort
sort([]) ->
[];
sort([H | T]) ->
insert(H, sort(T)).

% ----------------------------------------------------------------------------------
% 5. Binary
binary(0) -> [];
binary(N) ->
lists:append([binary(N div 2), [N rem 2]]).

% ----------------------------------------------------------------------------------
% 6. Binary Coded Decimal
% shell:strings(true).
bcd(0) -> ["0000"];
bcd(N) -> lists:append("00", "11").

% ----------------------------------------------------------------------------------
% 7. Prime Factors
prime_factors(1) -> [];
prime_factors(N) when N rem N - 1 == 0 ->
prime_factors(N - 1).

% ----------------------------------------------------------------------------------
% 8. Compress
compress([]) -> [];
compress([H | T]) when T == [] ->
[H];
compress([H | [H1 | T]]) when H == H1 ->
compress([H1 | T]);
compress([H | [H1 | T]]) when H /= H1 ->
[H | compress([H1 | T])].

% ----------------------------------------------------------------------------------
% 9. Encode

% ----------------------------------------------------------------------------------
% 10. Decode