
library(tidyverse)
library(astsa)
library(xts)

# -------------------------------------------------------------------------

filter = stats::filter
lag = stats::lag

# johnson and johnson

astsa::jj 

pdf("plots/jj_qeps.pdf", width = 12, height = 6)   # open PDF device
tsplot(jj, col=4, ylab = "USD", type = "o", main = "JJ QEPS")
dev.off()     

pdf("plots/jj-log.pdf", width = 12, height = 6)
tsplot(jj, col=4, ylab = "USD", type = "o", log = "y")
dev.off()

# temp

pdf("plots/temp.pdf", width = 12, height = 6)
tsplot(cbind(gtemp_land, gtemp_ocean), spaghetti=TRUE,
       col=astsa.col(c(4,2),.7), pch=c(20,18), type="o", ylab="\u00B0C",
       main="Global Surface Temperature Anomalies", addLegend=TRUE,
       location="topleft", legend=c("Land Surface","Sea Surface"))
dev.off()

# speech

pdf("plots/aah.pdf", width = 12, height = 6)
tsplot(speech, col=4)
arrows(658, 3850, 766, 3850, code=3, angle=90, length=.05, col=6)
text(712, 4100, "pitch period", cex=.75)
dev.off()

# djia

pdf("plots/djia.pdf", width = 12, height = 6)
djia_return = diff(log(djia$Close))
par(mfrow=2:1)
plot(djia$Close, col=4, main="DJIA Close")
plot(djia_return, col=4, main="DJIA Returns")
dev.off()

# fish

pdf("plots/soi.pdf", height = 12, width = 6)
par(mfrow = c(2, 1))
tsplot(soi, ylab="", main="Southern Oscillation Index", col=4)
text(1970, .91, "COOL", col=5, font=4)
text(1970, -.91, "WARM", col=6, font=4)
tsplot(rec, ylab="", main="Recruitment", col=4)
dev.off()

# lynx-hare

pdf("plots/lynx_hare.pdf", height = 12, width = 6)
tsplot(cbind(Hare, Lynx), col=c(2,4), type="o", pch=c(0,2), ylab="Number",
       spaghetti=TRUE, addLegend=TRUE)
mtext("(\u00D7 1000)", side=2, adj=1, line=1.5, cex=.8)
dev.off()

# fMRI

pdf("plots/fMRI.pdf", height = 12, width = 6)
par(mfrow=c(3,1))
x = ts(fmri1[,4:9], start=0, freq=32) # data
u = ts(rep(c(rep(.6,16), rep(-.6,16)), 4), start=0, freq=32) # stimulus signal
names = c("Cortex","Thalamus","Cerebellum")
for (i in 1:3){
  j = 2*i-1
  tsplot(x[,j:(j+1)], ylab="BOLD", xlab="", main=names[i], col=5:6,
         ylim=c(-.6,.6), lwd=2, xaxt="n", spaghetti=TRUE)
  axis(seq(0,256,64), side=1, at=0:4)
  lines(u, type="s", col=gray(.3))
}
mtext("seconds", side=1, line=1.75, cex=.9)
dev.off()

# quakes

pdf("plots/quakes.pdf", height = 12, width = 6)
tsplot(cbind(EQ5,EXP6), ylab=c("Earthquake", "Explosion"), col=4)
dev.off()

