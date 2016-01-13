#include <stdio.h>
#include <stdlib.h>

// Iterative Implementation
unsigned long fib_iterative(long n){
    unsigned long i=0, a=0, b=1;
    for(i=0 ; i<n ; i++){
        unsigned long tmp = a+b;
        a = b;
        b=tmp;
    }
    return a;
}

// Direct Recursive Implementation
unsigned long fib_recursive(long n){
    if(n == 0)
        return 0;
    if(n == 1)
        return 1;
    return fib_recursive(n-1) + fib_recursive(n-2);
}

// Dynamic programming implementation
unsigned long fib_dyn(long n, unsigned long * mem){
    // Did we alreade calculate this instance?
    if(mem[n] != -1)
        return mem[n];

    //basecase, we don't save these
    if(n == 0)
        return 0;
    if(n == 1)
        return 1;

    //recursive case
    mem[n] = fib_dyn(n-1, mem) + fib_dyn(n-2, mem);
    return mem[n];
}

// We use this function to _not_ bloat the global scope with an allocation
unsigned long fib_dynamic(long n){
    unsigned long * mem;
    mem = (unsigned long *) malloc(n+1);

    //initialize the memory
    int i=0;
    for(i=0 ; i<=n ; i++)
        mem[i] = -1;

    return fib_dyn(n, mem);
}

int main(int argc, char ** argv){
    printf("fib_iterative(10) = %lu \n", fib_iterative(10));
    printf("fib_dynamic(10) = %lu \n", fib_dynamic(10));
    
    // very slow
    //printf("fib_recursive(10) = %lu \n", fib_recursive(10));
    return 0;
}
