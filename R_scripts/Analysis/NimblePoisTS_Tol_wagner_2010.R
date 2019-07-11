poisTSCode <- nimbleCode({
   if(K > 1){
      A[1:K,1:K] <- inverse(diag(x=rep(2,K)))
      multimu[1:K] <- rep(0,K)
      B[1:K] ~ dmnorm(mean=multimu[1:K], prec=A[1:K,1:K])
      mu[1] <- inprod(X[1,1:K], B[1:K])
   }else{
      B ~ dnorm(mean=0,sd=2)
      mu[1] <- X[1]*B
   }
   sigma ~ dexp(0.7)
   lambda0 ~ dnorm(mean=0,sd=2)
   rho ~ dnorm(mean=0,sd=2)
   lambda[1] ~ dnorm(rho * lambda0,sd=sigma)
   for (j in 2:T){
      if(K > 1){
         mu[j] <- inprod(X[j,1:K], B[1:K])
      }else{
         mu[j] <- X[j] * B
      }
      lambda[j] ~ dnorm(rho * lambda[j-1],sd=sigma)
   }
   for (j in 1:T){
      Y[j] ~ dpois(exp(mu[j]+lambda[j]))
   }
})
timespan <- "1000_1980"
modelnum <- "Luterbacher2016"
index <- which(EuroClimCon$Year >= 1005 & EuroClimCon$Year <= 1980)
Y <- EuroClimCon$Conflicts[index]
T <- length(Y)
#XBase <- rep(x=1,times=T)
T_Provided <- EuroClimCon[index,3] - mean(EuroClimCon[index,3])
P_Provided <- EuroClimCon[index,4] - mean(EuroClimCon[index,4])
T_Mann2003 <- EuroClimCon[index,5] - mean(EuroClimCon[index,5])
T_Luterbacher2016 <- EuroClimCon$T_Luterbacher2016[index] - mean(EuroClimCon$T_Luterbacher2016[index])
T_Buntgen2011 <- EuroClimCon$T_Buntgen2011_JJA[index] - mean(EuroClimCon$T_Buntgen2011_JJA[index])
T_Glaser2009 <- EuroClimCon$T_Glaser2009[index] - mean(EuroClimCon$T_Glaser2009[index])
X <- cbind(rep(1,T),T_Luterbacher2016)#(T_Provided, P_Provided)
K <- ncol(X)

poisTSData <- list(Y=Y,
                  X=X)

poisTSConsts <- list(T=T,
                     K=K)

poisTSInits <- list(lambda0=0,
                     sigma=1,
                     rho=0,
                     B=rep(0,K))

poisTSModel <- nimbleModel(code=poisTSCode,
                        data=poisTSData,
                        inits=poisTSInits,
                        constants=poisTSConsts)

#compile nimble model to C++ code—much faster runtime
C_poisTSModel <- compileNimble(poisTSModel, showCompilerOutput = FALSE)

#configure the MCMC
poisTSModel_conf <- configureMCMC(poisTSModel,thin=99)

#select the variables that we want to monitor in the MCMC chain
#poisTSModel_conf$addMonitors(c("mu"))

#build MCMC
poisTSModelMCMC <- buildMCMC(poisTSModel_conf,enableWAIC=T)

#compile MCMC to C++—much faster
C_poisTSModelMCMC <- compileNimble(poisTSModelMCMC,project=poisTSModel)

#number of MCMC iterations
niter <- 20000000
niter90 <- niter * 0.9

#set seed for replicability
set.seed(1)

#call the C++ compiled MCMC model
C_poisTSModelMCMC$run(niter)

#save the MCMC chain (monitored variables) as a matrix
samples <- as.matrix(C_poisTSModelMCMC$mvSamples)
save(samples,file=paste("../Results/MCMC_Chains/whole/","mcmc_",modelnum,".RData",sep=""))
#print(C_poisTSModelMCMC$calculateWAIC(nburnin=100000))
#cols <- grep("log",colnames(samples))
#print(prod(colMeans(exp(samples[100000:200000,cols]))))
#print(mean(samples[100000:200000,1]))
#print(mean(samples[100000:200000,2]))

#diags
ncol_samples <- ncol(samples)
coda_mcmc <- mcmc(samples[1000:niter,grep("B|rho|sigma|lambda",colnames(samples))],thin=99)
mcmc_geweke <- geweke.diag(coda_mcmc)
write.csv(t(mcmc_geweke$z),file=paste("../Results/MCMC_Chains/whole/","geweke_",modelnum,".csv",sep=""))

#plots
#samples_trim <- samples[1000:niter,]#grep("B|rho|sigma|lambda0",colnames(samples))]
trim <- 1000
#source("../R_scripts/Plotting/plot_mcmc.R")
#dev.copy(png,
#         file=paste("../Results/MCMC_Chains/whole/",modelnum,".png",sep=""),
#         height=1000,
#         width=1500,
#         units="px",
#         res=150)
#dev.off()

alarm()
