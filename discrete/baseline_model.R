############################################
# PARAMETERS
############################################

m <- 6
g <- 0.15
k <- 3
l <- 1.2
c <- 1
cycles <- 25

############################################
# INITIAL CONDITIONS
############################################

A <- numeric(cycles)
G <- numeric(cycles)

A[1] <- 25
G[1] <- 0

time <- 1:cycles

############################################
# MODEL
############################################

for(t in 2:cycles){
  
  tc <- time[t]*c
  
  if(tc <= 8){
    G[t] <- m*g*A[t-1] + G[t-1]*exp(-l*c)
    A[t] <- m*(1-g)*A[t-1]
    
  } else{
    G[t] <- m*g*A[t-1]*exp(-k*c) + G[t-1]*exp(-l*c)
    A[t] <- m*(1-g)*A[t-1]*exp(-k*c)
  }
  
  if(A[t] < 1) A[t] <- 0
  if(G[t] < 1) G[t] <- 0
}

############################################
# STORE RESULTS
############################################

out <- data.frame(time, A, G)

############################################
# PLOT
############################################

par(mfrow=c(2,1))

plot(out$time, out$A,
     type="l",
     lwd=2,
     xlab="Cycle",
     ylab="Asexual parasites")

plot(out$time, out$G,
     type="l",
     col="red",
     lwd=2,
     xlab="Cycle",
     ylab="Gametocytes")