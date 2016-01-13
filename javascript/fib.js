'use strict';
var eventEmitter = require('events');
var emitter = new eventEmitter.EventEmitter();

// Direct Recursion
function fib_direct(n){
	if(n == 0)
		return 0;
	if(n == 1)
		return 1;
	return fib_direct(n-1) + fib_direct(n-2);
}

/*
	Event driven programming
 */

// listen on the event
emitter.on("fib" ,function(e){
	// Only write result when n is 10
	if(e.n == 10)
		process.stdout.write("\n" + e.fibn + "\n");
	else
		process.stdout.write(".")
});

// create stream. We need a bottom-up linear calculator for the
// problem. We use the iterative solution
function startStream(){
	var a=0;
	var b=1;
	var i=1;

	//We never stop the stream
	while(true){
		var tmp = a+b;
		b=a;
		a=tmp

		// emit
		emitter.emit('fib', {"fibn" : a, "n":i});
		i++;
	}
}

// call the start stream
startStream();