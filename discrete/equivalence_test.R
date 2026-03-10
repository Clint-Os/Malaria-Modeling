############################################
# INSERT CONTINUOUS MODEL CODE (exponential growth)
############################################

continuous_model <- function(r, A0, time){
  
  A <- A0 * exp(r * time)
  
  return(A)
}

############################################
# ERROR FUNCTION
############################################

error_function <- function(r){
  
  A_cont <- continuous_model(r, A0=25, time=out$time)
  
  sum((out$A - A_cont)^2)
}

############################################
# FIND OPTIMAL r
############################################

opt <- optimize(error_function, interval=c(0,5))

r_opt <- opt$minimum

print(r_opt) 

### visualize equivalence ###
A_cont <- continuous_model(r_opt, 25, out$time)

plot(out$time, out$A,
     type="l",
     lwd=2,
     xlab="Cycle",
     ylab="Asexual parasites")

lines(out$time, A_cont,
      col="blue",
      lwd=2)

legend("topleft",
       legend=c("Discrete model","Continuous model"),
       col=c("black","blue"),
       lwd=2)