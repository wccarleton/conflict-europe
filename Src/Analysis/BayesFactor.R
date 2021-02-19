#univariate cases
#Grid for kernal density estimation with KernSmooth
#The grid will be seq(-5,5,0.001)
OneDgrid_size <- length(seq(-5,5,0.001))
OneDgrid_lims <- c(-5,5)

x <- samples[,2]
#KernSmooth posterior
B_density_posterior <- bkde(x,
                        gridsize = OneDgrid_size,
                        range.x = OneDgrid_lims,
                        bandwidth = 0.001)
#KernSmooth prior
x_rand <-rnorm(n=1000000,mean=0,sd=100)
B_density_prior <- bkde(x_rand,
                     gridsize = OneDgrid_size,
                     range.x = OneDgrid_lims,
                     bandwidth = 0.001)

#extract the density value at 0.000
Post_0 <- B_density_posterior$y[which(B_density_posterior$x == 0)]
Prior_0 <- B_density_prior$y[which(B_density_prior$x == 0)]

SDRatio <- round(Post_0 / Prior_0,3)

source("../R_scripts/Plotting/plot_BF.R")
