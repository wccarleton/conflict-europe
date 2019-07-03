par(mfcol=c(clim_imf$nimf + 1,1),mar=c(1,4,1,3),oma=c(3,3,6,1),family="serif",bg=NA)
dataset <- T_Luterbacher2016_raw
dataname <- "T Luterbacher 2016"
start_year <- 1000
end_year <- 1980
index <- which(dataset$Year >= start_year & dataset$Year <= end_year)
tspan <- c(1000,2000)
clim_imf <- emd(T_Luterbacher2016_raw$Mean[index])
plot(dataset$Year[index],
      dataset$Mean[index],
      type="l",
      ylab="Raw",
      xaxt="n",
      yaxt="n",
      frame.plot=F,
      col.lab=rgb(50/255,50/255,50/255),
      xlim=tspan,
      cex.lab=1.5)
axis(side=2,
      tick=T,
      col="darkgrey",
      tck=0.05,
      col.axis=rgb(100/255,100/255,100/255))
axis(side=3,
      at=seq(tspan[1],tspan[2],100),
      tick=T,
      col="darkgrey",
      tck=0.05,
      col.axis=rgb(100/255,100/255,100/255))
##
for(j in 1:clim_imf$nimf){
   plot(dataset$Year[index],
         clim_imf$imf[,j],
         type="l",
         ylab=paste(j),
         xaxt="n",
         yaxt="n",
         frame.plot=F,
         col.lab=rgb(50/255,50/255,50/255),
         xlim=tspan,
         cex.lab=1.5)
   axis(side=2,
         tick=T,
         col="darkgrey",
         tck=0.05,
         col.axis=rgb(100/255,100/255,100/255))
}
axis(side=1,
      at=seq(tspan[1],tspan[2],100),
      tick=T,
      col="darkgrey",
      tck=0.05,
      col.axis=rgb(100/255,100/255,100/255))
##
mtext("Years CE",side=1,line=2,outer=T,col=rgb(51/255,48/255,43/255))
mtext("Years CE",side=3,line=2,outer=T,col=rgb(51/255,48/255,43/255))
mtext("IMFs",side=2,line=1,outer=T,col=rgb(51/255,48/255,43/255))
mtext(paste("Empirical Mode Decomposition\n","(",dataname,")",sep=""),side=3,line=3,outer=T,col=rgb(51/255,48/255,43/255))
##
#dev.copy(png,"../Images/IMF_T_Mann_2003.png",height=1000,width=1200,units="px",res=150)
#dev.off()
