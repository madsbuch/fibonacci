<?php
/*
Implementation of the Fibonacci function in PHP.
Initially we just create functions in global scope
*/

function fibRecursive($n){
    if($n == 0)
        return 0;
    if($n == 1)
        return 1;
    return fibRecursive($n-1) + fibRecursive($n-2);
}

/**
 * We go OOP. This is dumb...
 */
class fib {
    function __construct($n){
        $this->n = $n;
    }

    /**
     * Iterative fibonacci calculator
     * 
     * @return int returns Fibonacci of value the class was instansiated with
     */
    public function iterativeFibonacci(){
        $a=0;
        $b=1;
        for($i = 0 ; $i < $this->n ; $i++ ){
            $tmp = $a + $b;
            $a = $b;
            $b = $tmp;
        }
        return $a;
    }
}







echo fibRecursive(10) . "\n";
echo (new fib(10))->iterativeFibonacci() . "\n";



?>