public interface IFibonacci
{
    long Fib(int n);
}


public class FibDriver
{
    public static void Main()
    {
        // This is the configuration.
        IFibonacci fibObject = new RecursiveFib();
        
        // Run tests
        FibTester.RunAll();

        // Run the program
        System.Console.WriteLine(CalculateFib(fibObject, 10));
    }

    public static long CalculateFib(IFibonacci fibSolver, int n){
        return fibSolver.Fib(n);
    }
}

public class FibTester
{
    public static void RunAll(){
        TestImplementation(new RecursiveFib());
        TestImplementation(new RecursiveAccumulatedFib());
        TestImplementation(new IterativeFib());
    }

    public static void TestImplementation(IFibonacci fibSolver){
        long res10 = fibSolver.Fib(10);
        long res5  = fibSolver.Fib(5);

        if(res10 != 55)
            System.Console.WriteLine("Error - " + res10);
        else
            System.Console.WriteLine("Success!");

        if(res5 != 5)
            System.Console.WriteLine("Error - " + res5);
        else
            System.Console.WriteLine("Success!");
    }
}

public class RecursiveFib : IFibonacci
{
    public long Fib(int n)
    {
        if(n == 0)
            return 0;
        if(n == 1)
            return 1;
        return Fib(n-1) + Fib(n-2);
    }
}


public class RecursiveAccumulatedFib : IFibonacci
{
    public long Fib(int n){
        return accFib(0, 1, n);
    }

    private long accFib(long a, long b, int n){
        if(n == 0)
            return a;
        return accFib(a+b, a, n-1);
    }
}

public class IterativeFib : IFibonacci
{
    public long Fib(int n){
        long a=0;
        long b=1;
        for(int i=0 ; i<n ; i++){
            long tmp = a+b;
            b = a;
            a = tmp;
        }
        return a;
    }
}