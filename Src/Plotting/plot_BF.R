par(family="serif",bg="white")
plot(B_density_posterior,
      type="l",
      xaxt="n",
      yaxt="n",
      frame.plot=F,
      main="Savage-Dickey Ratio\n(Model 1)",
      xlab="Parameter Value",
      ylab="Density Estimate",
      col.lab=rgb(50/255,50/255,50/255))
axis(1,
      tick=T,
      col="darkgrey",
      col.axis=rgb(100/255,100/255,100/255))
axis(2,
      tick=T,
      col="darkgrey",
      col.axis=rgb(100/255,100/255,100/255))
lines(B_density_prior,
      col="darkgrey")
abline(v=0,
      lty=3,
      lwd=2,
      col="grey")
plot_coords <- par("usr")
text(x=plot_coords[1]*0.8,
   y=plot_coords[4]*0.9,
   bquote(BF%~~%.(SDRatio)))
##
dev.copy(png,paste("../Results/MCMC_Chains/",timespan,"/SDRatio_plot_model_",modelnum,".png",sep=""),height=1000,width=1200,units="px",res=150)
dev.off()
