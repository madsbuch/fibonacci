# Play with Fibonacci in Haskell
Along with a blog post on 
[basic fibonacci](https://madsbuch.com/100-days-of-fibonacci-day-0-haskell/)
and one on
[type level programming](https://madsbuch.com/100-days-of-fibonacci-day-9-haskell-types/).

## Fib.hs
The `Fib.hs` file contains value level implementations of the
Fibonacci function.

It can be evaluated and run in the REPL:

```
$ ghci Fib.hs 
...
*Main> fibAcc 10
55
```

## FibType.hs
Type level implementations of the Fibonacci function and play with dependent
types.

Evaluation:

```
$ ghci FibType.hs -XDataKinds
...
*FibType> :kind! Fibonacci (S (S (S (S (S (S (S Z)))))))
Fibonacci (S (S (S (S (S (S (S Z))))))) :: Nat
= 'S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S ('S 'Z))))))))))))
```