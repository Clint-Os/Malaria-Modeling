# Discrete Malaria Model
# Equations:
# A[t] = m*(1 - g)*A[t-1] if tc <= 8
# A[t] = m*(1 - g)*A[t-1]*exp(-k*c) if tc > 8
# G[t] = mg*A[t-1] + G[t-1]*exp(-l*c) if tc <= 8
# G[t] = mg*A[t-1]*exp(-k*c) + G[t-1]*exp(-l*c) if tc > 8
# where tc = t * c

discrete_model <- function(m, g, k, l, mg, c, A0, G0, T) {
  A <- numeric(T)
  G <- numeric(T)
  A[1] <- A0
  G[1] <- G0
  
  for (t in 2:T) {
    tc <- (t-1) * c  # since t starts from 2, but tc for step t-1?
    # Actually, for A[t], it's based on t, but tc = t * c ? Wait.
    # The condition is tc <=8, but tc is not defined.
    # Assuming tc = t * c, where t is the step index.
    # But for t=1, tc=c, etc.
    # Perhaps t starts from 1, tc = t * c
    
    # To match, for the update at step t, tc = t * c
    
    tc <- t * c
    if (tc <= 8) {
      A[t] <- m * (1 - g) * A[t-1]
      G[t] <- mg * A[t-1] + G[t-1] * exp(-l * c)
    } else {
      A[t] <- m * (1 - g) * A[t-1] * exp(-k * c)
      G[t] <- mg * A[t-1] * exp(-k * c) + G[t-1] * exp(-l * c)
    }
  }
  return(list(A = A, G = G))
}

# Example usage
# params <- discrete_model(m=1.5, g=0.1, k=0.2, l=0.3, mg=0.05, c=0.1, A0=100, G0=10, T=100)
# plot(params$A, type='l', col='blue')
# lines(params$G, col='red')
