AUTH_ID=Sys.getenv("SMS_AUTH_ID")
AUTH_TOKEN=Sys.getenv("SMS_AUTH_TOKEN")
src_num=paste(Sys.getenv("SMS_SRC"))
dst_num=paste(Sys.getenv("SMS_DST"))
message<-"MCMC complete"
url=paste("https://api.plivo.com/v1/Account/",AUTH_ID,"/Message/",sep="")
POST(url,authenticate(AUTH_ID,AUTH_TOKEN),body=list(src=src_num,dst=dst_num,text=message))
