-module(ejem1).
-compile(export_all).

pow(_B, 0) -> 1;
pow(B, E) when E > 0 -> 
B * pow(B, E - 1).

dup([]) ->
[];
dup([H|T]) ->
[H, H| dup(T)].

add1([]) ->
[];
add1([H|T]) ->
    [H + 1 | T + 1].