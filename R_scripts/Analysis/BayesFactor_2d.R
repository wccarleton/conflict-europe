#univariate cases
#Grid for kernal density estimation with KernSmooth
#The grid will be seq(-5,5,0.1)
OneDgrid_size <- 1001
OneDgrid_lims <- c(-5,5)

x <- samples[,1]
y <- samples[,2]
#KernSmooth posterior
B_density_posterior <- bkde2D(cbind(x,y),
                        gridsize = c(OneDgrid_size,OneDgrid_size),
                        range.x = list(OneDgrid_lims,OneDgrid_lims),
                        bandwidth = c(0.1,0.1))
#KernSmooth prior
x_rand <- rnorm(n=1000000,mean=0,sd=1)
y_rand <- rnorm(n=1000000,mean=0,sd=1)
B_density_prior <- bkde2D(cbind(x_rand,y_rand),
                     gridsize = c(OneDgrid_size,OneDgrid_size),
                     range.x = list(OneDgrid_lims,OneDgrid_lims),
                     bandwidth = c(0.1,0.1))

#extract the density value at 0.000
Post_0 <- B_density_posterior$fhat[which(B_density_posterior$x1 == 0), which(B_density_posterior$x2 == 0)]
Prior_0 <- B_density_prior$fhat[which(B_density_prior$x1 == 0), which(B_density_prior$x2 == 0)]

SDRatio <- round(Post_0 / Prior_0,3)

#source("../R_scripts/Plotting/plot_BF_2d.R")
