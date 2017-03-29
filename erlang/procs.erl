% ITESM CEM, March 21, 2017.
% Erlang Source File
% Activity: Práctica #6: Erlang concurrente
% Authors: 
%          A01167870 Joel Narváez Valdivieso
%          A01373631 Andrea Margarita Pérez Barrera

-module(procs).
-compile(export_all).

% ----------------------------------------------------------------------------------
% 1. Factorial
factorial(N) ->
	P = spawn(fun aux/0),
	P ! {fact, N, self()},
	receive
		Result -> Result
	end.

aux() ->
	receive
		{fact, N, Pid} -> Pid ! fact_fun(N)
	end.

fact_fun(0) -> 1;
fact_fun(N) when N > 0 -> N * fact_fun(N - 1).

% ----------------------------------------------------------------------------------
% 2. Fibo_proc
fibo_proc() ->
	spawn(fun () -> fibo_loop([1, 0]) end).

fibo_loop(Nums) ->
	receive
		{recent, Pid} ->
			Pid ! hd(Nums),
			fibo_loop(Nums);
		{span, Pid} -> 
			Pid ! length(Nums),
			fibo_loop(Nums);
		{_, Pid} -> 
			Pid ! killed
		after 1000 ->
			[A, B | T] = Nums,
			fibo_loop([A + B, A, B | T])
	end.

fibo_send(Pid, Mssg) ->
	case is_process_alive(Pid) of
		true ->
			Pid ! {Mssg, self()},	
			receive
				X -> X
			end;
		false -> killed
	end.

% ----------------------------------------------------------------------------------
% 3. Double
double(N) ->
	P1 = spawn(fun() -> prg(1, N) end),
	P2 = spawn(fun() -> prg(1, N) end),
	io:format("Created~p~n", [P1]),
	io:format("Created~p~n", [P2]),
  P1 ! P2.

prg(I, N) when I >= N ->
	receive
		Pid -> io:format("~p received message ~p/~p~n", [self(), I, N]),
					 io:format("~p finished~n", [self()]),
			     Pid ! self()
	end;
prg(I, N) ->
	receive
		Pid -> io:format("~p received message ~p/~p~n", [self(), I, N]),
			     Pid ! self(),
					 prg(I+1, N)
	end.

% ----------------------------------------------------------------------------------
% 4. Ring
ring(P, N) -> 
	C = self(),
	io:format("Current process is ~p~n", [C]),
	Pd = spawn(fun() -> pring(P - 1, N, 1, C) end),
	io:format("Created ~p~n", [Pd]),
	receive
		R -> R ! Pd,
				 Pd ! C 
	end.

pring(P, N, _I, Pid) when P > 0 ->
	Pidn = spawn(fun() -> pring(P - 1, N, N+1, Pid) end),
	io:format("Created ~p~n", [Pidn]),
	receive
		Pd -> io:format("~p received ~p/~p from ~p~n", [self(), 1, N, Pd]),
				  Pidn ! self(),
					pring(0, N, 2, Pidn)
	end;
pring(_P, N, I, Pid) when N > I ->
	receive
		Pd -> io:format("~p received ~p/~p from ~p~n", [self(), I, N, Pd]),
					Pid ! self(),
					pring(0, N, I+1, Pid)
	end;
pring(_P, N, I, Pid) when N == I ->
	receive	
		Pd -> io:format("~p received ~p/~p from ~p~n", [self(), I, N, Pd]),
					io:format("~p finished~n", [self()]),
					Pid ! self()
	end;
pring(_P, N, _I, Pid) -> 
	Pid ! self(),
	receive
		Pids -> pring(0, N, 1, Pids)
	end.

% ----------------------------------------------------------------------------------
% 5. Star

star(P, N) ->
	Main = self(),
	io:format("Current process ~p~n", [self()]),
	Center = spawn(fun() -> center(P, N, 0, Main, P * 2, []) end),
	io:format("Created ~p (center) ~n", [Center]),
	receive
		done -> %io:format("All done~n"),
		        Center ! self()
	end.

center(P, N, _I, Main, End, All) when P > 0 ->
	Center = self(),
	Pd = spawn(fun () -> pstar(Center, N, 1) end),
	io:format("Created ~p~n", [Pd]),
	center(P-1, N, N+1, Main, End, All ++ [Pd]);
center(P, N, I, Main, End, All) when I == 0 ->
	H = lists:nth(I+1, All),
	%io:format("Process to send: ~p~n",[H]),
	receive
		Pid -> io:format("~p received ~p/~p from ~p~n", [self(), I, N, Pid]),
	         H ! message,
					 center(P, N, 1, Main, End, All)
	end;
center(P, N, I, Main, End, All) when I < N -> 
	H = lists:nth(I+1, All),
	%io:format("Process to send: ~p~n",[H]),
	receive
		{Times, Pid} -> io:format("~p received ~p/~p from ~p~n", [self(), Times, N, Pid]),
		                H ! message,
									  center(P, N, Times, Main, End, All)
	end;
center(P, N, _I, Main, End, All) -> 
	Main ! done,
	center(P, N, 0, Main, End, All).

pstar(Center, N, I) when N > I ->
	%io:format("Hello ~p~n", [Center]),
	receive
		message -> io:format("~p received ~p/~p from ~p~n", [self(), I, N, Center]),
							 Center ! {I, self()},
							 pstar(Center, N, I+1)
	end;
pstar(Center, N, I) ->
	receive
		message -> io:format("~p receivedd ~p/~p from ~p~n", [self(), I, N, Center]),
				       io:format("~p finished~n", [self()])
	end.

% cd("c:/Users/usuario/Documents/ISC/8voSemestre/Programación_Multinúcleo/erlang").