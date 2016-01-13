import java.math.BigInteger;
import java.util.Hashtable;

class Fib {

    public static void main(String args[]){
        if( args.length != 1){
            System.out.println("Please provide a number as the only argument.");
            return;
        }

        int n = Integer.parseInt(args[0]);
        System.out.println(fibDynamic(n));
    }

    /**
     * Iterative implementation using BigInteger for computing large results
     *
     * @param n
     * @return fib(n)
     */
    private static BigInteger fib(long n){
        BigInteger a = new BigInteger("0");
        BigInteger b = new BigInteger("1");

        for (long i=0 ; i<n ;i++){
            BigInteger tmp = a.add(b);
            a = b;
            b = tmp;
        }

        return a;
    }

    /**
     * Recursive implementation of the fibonacci function
     *
     * @param n
     * @return fib(n)
     */
    private static BigInteger fibRec(long n){
        if(n == 0)
            return new BigInteger("0");
        if(n == 1)
            return new BigInteger("1");
        return fibRec(n-1).add(fibRec(n-2));
    }

    /**
     * Driver for the dynamic implementation of Fibonacci
     */
    private static BigInteger fibDynamic(int n){
        Hashtable<Integer, BigInteger> mem = new Hashtable<Integer, BigInteger>(n+1);
        return fibDynamic(n, mem);
    }

    /**
     * Memoization implementation of the Fibonacci function using hash table
     * as container for memory entries
     */
    private static BigInteger fibDynamic(int n, Hashtable<Integer, BigInteger> mem){
        // Check if we have the result
        if(mem.containsKey(new Integer(n)))
            return mem.get(new Integer(n));

        // Base cases
        if(n == 0)
            return new BigInteger("0");
        if(n == 1)
            return new BigInteger("1");

        // calculate and memoize Fibonacci
        mem.put(new Integer(n), fibDynamic(n-1, mem).add(fibDynamic(n-2, mem)));
        return mem.get(n);
    }
}
