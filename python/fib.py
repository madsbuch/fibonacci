
cache = {}
def fib(n):
    if cache.get(n, None) != None :
        return cache[n]

    if n == 0 :
        return 0
    if n == 1 :
        return 1

    cache[n] = fib(n-1) + fib(n-2)
    return cache[n]

print [fib(x) for x in range(20)]