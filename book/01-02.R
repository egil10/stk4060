
library(tidyverse)
library(astsa)
library(xts)

filter = stats::filter
lag = stats::lag

# -------------------------------------------------------------------------

# ma

pdf("plots/mva.pdf", height = 12, width = 6)
w = rnorm(250) # 250 N(0,1) variates
v = filter(w, sides=2, filter=rep(1/3,3)) # moving average
par(mfrow=2:1)
tsplot(w, main="white noise", col=4, gg=TRUE)
tsplot(v, ylim=c(-3,3), main="moving average", col=4, gg=TRUE)
dev.off()

# recursive

pdf("plots/recur.pdf", height = 12, width = 6)
w = rnorm(300) # 50 extra to avoid startup problems
x = filter(w, filter=c(1.5,-.75), method="recursive")[-(1:50)]
tsplot(x, main="autoregression", col=4, gg=TRUE)
dev.off()

# rd w drift

pdf("plots/rwd.pdf", height = 12, width = 6)
par(mfrow = c(1, 1))
set.seed(154) # so you can reproduce the results
w = rnorm(200); x = cumsum(w) # two commands in one line
wd = w +.2; xd = cumsum(wd)
tsplot(xd, ylim=c(-5,55), main="random walk", ylab="", col=4, gg=TRUE)
lines(x, col=6); clip(0, 200, 0, 50)
abline(h=0, a=0, b=.2, col=8, lty=5)
dev.off()

# hawaii!

pdf("plots/hawaii.pdf", height = 12, width = 6)
par(mfrow = c(4,1))
x = window(hor, start=2002)
out = stl(x, s.window=15)$time.series
tsplot(x, main="Hawaiian Occupancy Rate", ylab="% rooms", col=8, type="c")
text(x, labels=1:4, col=c(3,4,2,6), cex=1.25)
tsplot(out[,1], main="Seasonal", ylab="% rooms", col=8, type="c")
text(out[,1], labels=1:4, col=c(3,4,2,6), cex=1.25)
tsplot(out[,2], main="Trend", ylab="% rooms", col=8, type="c")
text(out[,2], labels=1:4, col=c(3,4,2,6), cex=1.25)
tsplot(out[,3], main="Noise", ylab="% rooms", col=8, type="c")
text(out[,3], labels=1:4, col=c(3,4,2,6), cex=1.25)
dev.off()

