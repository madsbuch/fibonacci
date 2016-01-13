 object Fib {

    // Direct recursive implementation
    def fib_direct(n: Int):Int = n match {
        case 0 => 0
        case 1 => 1
        case _ => fib_direct(n-1) + fib_direct(n-2)
    }

    // Accumulated implementation
    def fib_accumulated(n: Int, a: Int, b: Int) : Int = n match{
        case 0 => a
        case _ => fib_accumulated(n-1, a+b, a)
    }

    // Defining fib_acc to be fib_accumulated partially applied
    def fib_acc(n: Int) = fib_accumulated(n, 0, 1)

    // Fibonacci in Contiuation Passing Style
    def fib_cps (n: Int, k: (Int => Int)) : Int = n match{
    	case 0 => k(0)
    	case 1 => k(1)
    	case _ => fib_cps(n-1, (a: Int) =>
    		fib_cps(n-2, (b: Int) =>
    			k(a+b)))
    }

    def fib_cont(n: Int) = fib_cps(n, ((x: Int) => x))

    def main(args: Array[String]) : Unit = {
   	    println(fib_cont(10))
    }
 }