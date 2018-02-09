library(ETAS)
library(maps)

dat<-read.table("cluster1.csv", header=T, sep=",")

attach(dat)

sis<-data.frame(date,time,long,lat,mag)
sis.cat<-catalog(sis,time.begin="1906-01-01", study.start="1970-01-01",study.end="2018-01-01",
                 lat.range=c(-2.11,1.23), long.range=c(-81.57,-79.36),mag.threshold=4.5)
print(sis.cat)
plot(sis.cat)

##fitting the ETAS model
##setting initial parameter values
param0<-c(0.46,0.23,0.022,2.8,1.12,0.012,2.4,0.35)
ecuador.fit<-etas(sis.cat,param0=param0)
## una vez ajustado se obtiene los valores de paramo
## param0<-c(mu, A, c, alpha,p, D, q, gamma)
param0<-c(0.94,0.369,0.022,0.989,1.179,0.0329, 2.199,0.053)
ecuador.fit2<-etas(sis.cat,param0=param0)

## rates
### estimating the clustering probabilities
pr<-probs(ecuador.fit2)
rates(ecuador.fit2, plot.it=TRUE)
plot(sis.cat$longlat.coord[,1:2],cex=2*(1-pr$prob))