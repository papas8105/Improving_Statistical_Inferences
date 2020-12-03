#to get emoticons for each test, set wait to 1 and showfaces to 1. 
#When running large number of simulations, se wait to 0 and showfaces to 0.
options(scipen=20) #disable scientific notation for numbers
waitx<-0.5 #To see a small wait between individual trials, set a wait time to e.g., 0.5 
showfaces<-1 #Set to 0 if you do not want the faces, set to 1 if you want to see the faces

nSims <- 100 #number of simulated experiments (for large numbers, set wait to 0 and showfaces to 0)
n<-50 #sample size in each group -->50 default

#set up some variables
p<-numeric(nSims) 

for(i in 1:nSims){ #for each simulated experiment
  x<-rnorm(n = n, mean = 100, sd = 15) #produce N simulated participants
  y<-rnorm(n = n, mean = 106, sd = 15) #produce N simulated participants
  z<-t.test(x,y) #perform the t-test
  p[i]<-z$p.value #get the p-value and store it
  if(z$p.value < 0.001  & showfaces==1){cat(":D     p =",z$p.value,"\n\n")}  
  if(0.001 <= z$p.value & z$p.value < 0.01  & showfaces==1){cat(":)     p =",z$p.value,"\n\n")}
  if(0.01 <= z$p.value & z$p.value < 0.05  & showfaces==1){cat("(^.^)  p =",z$p.value,"\n\n")}
  if(0.05 <= z$p.value & z$p.value < 0.10  & showfaces==1){cat("(._.)  p =",z$p.value,"\n\n")}
  if(z$p.value>0.10  & showfaces==1){cat(":(     p =",z$p.value,"\n\n")}
  Sys.sleep(waitx)
}

#now plot histograms of p-values, t-values, d, observed power
hist(p, main="Histogram of p-values", xlab=("Observed p-value"),col='red', breaks = 20)

#? Daniel Lakens, 2016. 
# This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0
# International License. https://creativecommons.org/licenses/by-nc-sa/4.0/
# Q4
# >power.t.test(delta=0.2,sig.level = 0.05,power=0.95,sd=1,type='two.sample',alternative = 'two.sided')$n
# ans -----> 651

# Q5
# >power.t.test(delta=0.7,sig.level = 0.05,power=0.9,sd=1,type='two.sample',alternative = 'two.sided')$n
# ans -----> 44

# Q6
# d <- 0.7*(1-3/(4*42-9))
# >power.t.test(delta=d,sig.level = 0.05,power=0.9,sd=1,type='two.sample',alternative = 'two.sided')$n

# Q7
# >power.t.test(delta=0.37,sig.level = 0.05,power=0.9,sd=1,type='two.sample',alternative = 'two.sided')$n

# Q8 omega^2 = (F-1)/(F + (dferror+1)/dfeffect)
# >22.89/(23.89 + 133/2)

#Q9 
#>library(pwr)
# > pwr.f2.test(u=2,v=132,f2 = 0.577,power=0.9)