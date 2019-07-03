dataobjects <- list.files("../Results/MCMC_Chains/C/")
dataobjects <- dataobjects[grep(".RData",dataobjects)]

load(paste("../Results/MCMC_Chains/C/",dataobjects[1],sep=""))
samples <- samples[10000:200000,grep("B|rho|sigma|lambda0",colnames(samples))]
geweke.diag(samples)$z
