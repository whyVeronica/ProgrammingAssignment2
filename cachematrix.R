#These functions cache the inverse of a matrix.

#This function creates a special "matrix" object that can cache its inverse.
#The calculated inverse matrix will be stored in global environment using "<<-".
makeCacheMatrix <- function(x = matrix()) {
  
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  get <- function() x
  
  setinverse <- function(x) {
    inv <- matrix()
    for (m in seq_along(nrow(x))){
      for (n in seq_along(ncol(x))){
        inv[m,n] <<- x[-m,-n]
      }
    }
  }
  
  getinverse <- function() inv
  
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)

}

#This function computes the inverse of the special "matrix" returned by makeCacheMatrix above.
#If the inverse has already been calculated (and the matrix has not changed), 
#then the cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  inv <- x$getinverse()
  
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  
  data <- x$get()
  inv <- setinverse(data, ...)
  x$setinverse(inv)
  inv
}
