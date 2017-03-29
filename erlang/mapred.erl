% ITESM CEM, March 28, 2017.
% Erlang Source File
% Activity: Práctica #7: MapReduce con Erlang
% Authors: 
%          A01167870 Joel Narváez Valdivieso
%          A01373631 Andrea Margarita Pérez Barrera

-module(mapred).
-compile(export_all).

% ----------------------------------------------------------------------------------
% 1. Primes

primes(S, E) ->
	List = createList(S, E),
	Dict = dict:to_list(
		plists:mapreduce(fun (X) -> isPrime(X) end, List)),
	case Dict of
    [{true, A}, {false, _B}] -> A;
    [{true, A}] -> A;
    [{false, _A}] -> []
  end.

createList(S, E) when S =< E ->
	[S | createList(S+1, E)];
createList(_S, _E) ->
[].

isPrime(N,M) when N == M -> 
  true;
isPrime(N,M) when N rem M == 0 -> 
  false;
isPrime(N,M) -> 
  isPrime(N,M+1).

isPrime(N) when N < 2 -> 
  {false, N};
isPrime(N) when N rem 1 == 0 -> 
{isPrime(N,2), N}.

% ----------------------------------------------------------------------------------
% 2. Apocalyptic

apocalyptic(S, E) ->
  List = createList(S, E),
  Dict = dict:to_list(
		plists:mapreduce(fun (X) -> aux(X) end, List)),
  case Dict of
    [{true, A}, {false, _B}] -> A;
    [{false, _A}, {true, B}] -> B;
    [{true, A}] -> A;
    [{false, _A}] -> []
  end.

pow(_B, 0) ->
  1;
pow(B, E) when E > 0 ->
  B * pow(B, E - 1).

aux(N) ->
  Number = pow(2, N),
  Snumber = integer_to_list(Number),
  Nnumber = string:str(Snumber, "666"),
  case Nnumber of 
    0 -> {false, N};
    _ -> {true, N}
  end.  

% ----------------------------------------------------------------------------------
% 4. Phil13

digits(0)-> 0;
digits(N) when N < 10 -> [N];
digits(N) when N >= 10 -> 
  digits(N div 10)++[N rem 10].

phil13(S, E) ->
  List = createList(S, E),
  Dict = dict:to_list(
		plists:mapreduce(fun (X) -> weird(X) end, List)),
  case Dict of
    [{true, A}, {false, _B}] -> A;
    [{false, _A}, {true, B}] -> B;
    [{true, A}] -> A;
    [{false, _A}] -> []
  end.

weird(N) ->
  Number = pow(2, N),
  Result = lists:sum(digits(Number)),
  if
    Result rem 13 == 0 -> {true, N};
    Result rem 13 /= 0 -> {false, N}
  end.
