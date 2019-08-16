poisTSCode <- nimbleCode({
   if(K > 1){
      A[1:K,1:K] <- inverse(diag(x=rep(2,K)))
      multimu[1:K] <- rep(0,K)
      B_1[1:K] ~ dmnorm(mean=multimu[1:K], prec=A[1:K,1:K])
      B_2[1:K] ~ dmnorm(mean=multimu[1:K], prec=A[1:K,1:K])
      mu[1] <- inprod(X[1,1:K], (B_1[1:K] + (B_2[1:K] * ind[1])))
   }else{
      B_1 ~ dnorm(mean=0,sd=2)
      B_2 ~ dnorm(mean=0,sd=0.5)
      mu[1] <- X[1] * (B_1 + (B_2 * ind[1]))
   }
   sigma ~ dexp(0.1)
   lambda0 ~ dnorm(mean=0,sd=2)
   rho ~ dnorm(0,sd=2)
   Delta ~ dunif(1,Time)
   ind[1:Time] <- nimbleIndVector(Time,Delta)
   lambda[1] ~ dnorm(rho * lambda0,sd=sigma)
   for (j in 2:Time){
      if(K > 1){
         mu[j] <- inprod(X[j,1:K], (B_1[1:K] + (B_2[1:K] * ind[j])))
      }else{
         mu[j] <-  X[j] * (B_1 + (B_2 * ind[j]))
      }
      lambda[j] ~ dnorm(rho * lambda[j-1],sd=sigma)
   }
   for (j in 1:Time){
      Y[j] ~ dpois(exp(mu[j] + lambda[j]))
   }
})
timespan <- "1005_1980"
modelnum <- "change_Glaser2009"
index <- which(EuroClimCon$Year >= 1005 & EuroClimCon$Year <= 1980)
Y <- EuroClimCon$Conflicts[index]
Time <- length(Y)
T_Provided <- EuroClimCon[index,3] - mean(EuroClimCon[index,3])
P_Provided <- EuroClimCon[index,4] - mean(EuroClimCon[index,4])
T_Mann2003 <- EuroClimCon[index,5] - mean(EuroClimCon[index,5])
T_Luterbacher2016 <- EuroClimCon$T_Luterbacher2016[index] - mean(EuroClimCon$T_Luterbacher2016[index])
T_Buntgen2011 <- EuroClimCon$T_Buntgen2011_JJA[index] - mean(EuroClimCon$T_Buntgen2011_JJA[index])
T_Glaser2009 <- EuroClimCon$T_Glaser2009[index] - mean(EuroClimCon$T_Glaser2009[index])
X <- T_Glaser2009#(T_Provided, P_Provided)
K <- 1#ncol(X)

poisTSData <- list(Y=Y,
                  X=X)

poisTSConsts <- list(Time=Time,
                     K=K)

poisTSInits <- list(lambda0=0,
                     sigma=1,
                     rho=0,
                     Delta=100,
                     B_1=rep(0,K),
                     B_2=rep(0,K))

poisTSModel <- nimbleModel(code=poisTSCode,
                        data=poisTSData,
                        inits=poisTSInits,
                        constants=poisTSConsts)

#compile nimble model to C++ code—much faster runtime
C_poisTSModel <- compileNimble(poisTSModel, showCompilerOutput = FALSE)

#configure the MCMC
poisTSModel_conf <- configureMCMC(poisTSModel,thin=99)
poisTSModel_conf$removeSampler(c("B_1","B_2"))
poisTSModel_conf$addSampler(target = c("B_1", "B_2"), type = "RW_block")

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

#diags
ncol_samples <- ncol(samples)
coda_mcmc <- mcmc(samples[1000:dim(samples)[1],grep("B|rho|sigma|lambda",colnames(samples))],thin=99)
mcmc_geweke <- geweke.diag(coda_mcmc)
write.csv(t(mcmc_geweke$z),file=paste("../Results/MCMC_Chains/whole/","geweke_",modelnum,".csv",sep=""))

#plots
#samples_trim <- samples[1000:dim(samples)[1],]#grep("B|rho|sigma|lambda0",colnames(samples))]
trim <- 1000
source("../R_scripts/Plotting/plot_mcmc.R")
#dev.copy(png,
#         file=paste("../Results/MCMC_Chains/whole/",modelnum,".png",sep=""),
#         height=1000,
#         width=1500,
#         units="px",
#         res=150)
#dev.off()

#alarm()
source("../R_scripts/SMS/sms.R")
