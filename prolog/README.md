# Prolog Fibonacci Implementation
A [blog post](https://madsbuch.com/100-days-of-fibonacci-day-4-prolog/) with
some elaboration.

## Running
Start the swipl interpreter reading the initial propositions:

        $ swipl fib.pl

the direct recursive implementation is evoked as

        ?- fib_direct(10, X).
        X = 55 .

Use the wrapper for the implementation based in peano naturals

        ?- fib_peano_wrapper_get_res(10, R).
        R = 55 .

And retrieving the argument for a given Fibonacci number

        ?- fib_peano_wrapper_get_arg(A, 55).
        A = 10 .

