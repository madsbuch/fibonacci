
% Implementation using direct recursion.
fib_direct(0, 0).
fib_direct(1, 1).
fib_direct(N, R) :-
	X1 is N-1,
	X2 is N-2,
	fib_direct(X1, A),
	fib_direct(X2, B),
	R is A + B.

% Definiition of the Peano numbers
nat(0).
nat(s(_)).

% Readable nats
nat_to_int(0, 0).
nat_to_int(s(N), R) :-
	nat_to_int(N, R1),
	R is R1 + 1.

int_to_nat(0, 0).
int_to_nat(X, s(R)) :-
	X1 is X-1,
	int_to_nat(X1, R).

% Definition of addition ( add(A, B, Result ))
add(0, B, B).
add(s(A), B, R) :- add(A, s(B), R).

fib_peano(0, 0).
fib_peano(s(0), s(0)).
fib_peano(s(s(N)), R) :-
	fib_peano(N, A),
	fib_peano(s(N), B),
	add(A, B, R).

% Wrapper functions dealing with all the conversions
fib_peano_wrapper_get_res(A, B) :-
	int_to_nat(A, X),
	fib_peano(X, Y),
	nat_to_int(Y, B).
fib_peano_wrapper_get_arg(A, B) :-
	int_to_nat(B, Y),
	fib_peano(X, Y),
	nat_to_int(X, A).