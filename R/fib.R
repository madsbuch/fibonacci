# Create a list  of the first n fibonacci numbers
fibList <- function(n){
  theList <- numeric(n)
  theList[1] <- 1
  theList[2] <- 1
  for (i in 3:n) {
    theList[i] <- theList[i-1] + theList[i-2]
  }
  return(theList);
}

# Calling the function
fibList(10)
fibList(20)
fibList(100)

png("fib.png", 600, 400)

drawFib2D <- function(n){
  plot(c(1:n), fibList(n))
}

drawFib2D(200)


drawFib3D <- function(n){
  a1 = fibList(n)
  a2 = fibList(n*2):(n/2)*2
  a2 = fibList(n*2):(n/3)*3
  plot(c(1:n), fibList(n), fibList(n))
}

#----------- Playing around with eksponentials
expList <- function(n){
  theList <- numeric(n)
  
  for (i in 1:n) {
    theList[i] <- 2^i
  }
  return(theList);
}

png("exp.png", 600, 400)

drawExp2D <- function(n){
  plot(c(1:n), fibList(n))
}

drawExp2D(200)
