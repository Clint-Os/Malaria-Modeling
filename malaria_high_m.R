#########################################################
# Continuous Model of Malaria Infections
#########################################################

# This is the starting script to the malaria module

# Produces dynamics of infections using the continuous model
# Plots output

#######################
# FUNCTION DEFINITIONS
#######################

###
# cont.model(t,y,para) 
# Use:    Function to calculate time derivatives of asexual (A) and gametocyte (G) densities 
# Input:
#     t: time 
#     y: vector of current values of variables A and G
#     para: parameters 	g: gametocyte investment, fraction of parasites that become gametocytes
#			r: rate at which asexuals rupture to produce offspring
#			m: number of offspring produced by each asexual
#			k: rate at which asexuals are killed by immune response
#			l: death rate of gametocytes
# Output:
#    der: vector of derivatives at time t

cont.model<-function(t,y,para) {

with(as.list(c(para,y)),{ # this command allows us to refer directly to the variables and parameters

if(t<8) { # immunity begins on day 8 of infection
  	dA<-r*m*(1-g)*A-r*A
  	} else {
  	dA<-r*m*(1-g)*A-r*A-k*A
  	} 
dG<-r*m*g*A-l*G
der<-c(dA,dG)
list(der)
}) # end of 'with'
}  # end of function definition


###
# dynamics(g,init.y,end.time,interval,cont.model,para)
# Use: Function to integrate asexual and gametocyte differential equations
# Once A or G falls below 1 they are considered to be zero (to prevent negative values)
# Input:
#	g: gametocyte investment
#	init.y: vector of asexual and gametocyte densities for first time point in sequence 
#	end.time: last time for which densities are to be calculated
# 	interval: time interval between densities
#	cont.model: function specifying differential equations
#	para: parameters	r: rate at which asexuals rupture to produce offspring
#				m: number of offspring produced by each asexual
#				k: rate at which asexuals are killed by immune response
#				l: death rate of gametocytes
# Output:
# 	A: vector of asexual densities at requested times
#	G: vector of gametocyte densities at requested times
# 	time: vector of times

dynamics<-function(g,init.y,end.time,interval,cont.model,para) {
para<-c(g=g,para) # adds g to list of parameters, specifying it separately like this allows it to be changed easily
times<-seq(0,end.time,by=interval) # produces sequence of times for which densities will be estimated
results<-lsoda(init.y,times,cont.model,para)
# to set values <1 to 0 using index matrix
results[,c("A","G")][results[,c("A","G")]<1]<-0

as.data.frame(results)	
}

#################################################
# MAIN PROGRAM
#################################################

### Load R library for solving odes
library(deSolve)

### Define parameters, initial values and times for estimating parasite densities
para<-c(r=0.25,m=8,k=3,l=1.2)
end.time<-25
interval<-0.2
init.y<-c(A=25,G=0)

### get output for continuous model
out<-dynamics(g=0.15,init.y,end.time,interval,cont.model,para)

### plot results
#pdf("fig3.pdf")
par(mar=c(5,6,3,2)+0.1,cex=1.3) # sets margins so there is room for y-axis label
                                # and increases font and symbol size
plot(out$time,out$A,xlab="time in days",ylab="",type="n") # type="n" sets up the axes
                                                          # without plotting the function
lines(out$time,out$A,lw=2) # type="l" draws a line rather than points
mtext(expression(paste("Parasites per ",mu,"l")),side=2,line=4,cex=1.3) # to write y-axis label with Greek letter
lines(out$time,out$G,col="red",lw=2) # to add gametocyte data onto graph
par(cex=1.2)
legend(end.time*0.5,max(out$A)*0.7, legend=c("asexuals","gametocytes"), col=c("black","red"),lw=2)
#dev.off()