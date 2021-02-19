#nimbleIndicator <- function(T,D){
#   return(sum(T >= D))
#}

#indicator <- nimbleRcall(function(T = double(0), D = double(0)){}, Rfun = 'nimbleIndicator',
#                        returnType = double(0))

nimbleIndicator <- nimbleFunction(
   run = function(time = double(0), D = double(0)){
   indicator <- sum(time >= D)
      returnType(double(0))
      return(indicator)
   })

nimbleXMatrix <- nimbleFunction(
   run = function(X = double(1), Delta = double(0), Time = double(0), K = double(0)){
      newmatrix <- matrix(c(X,rep(0,Delta),rep(1,Time-Delta)),ncol=K)
      returnType(double(2))
      return(newmatrix)
   }
)

nimbleIndVector <- nimbleFunction(
   run = function(Time = double(0), Delta = double(0)){
      indvector <- c(rep(0,Delta),rep(1,Time-Delta))
      returnType(double(1))
      return(indvector)
   }
)
