library(tidyverse)
library(astsa)

# -------------------------------------------------------------------------
# Create PDF
pdf("plots/spectral.pdf", height = 12, width = 6)

t <- seq(-10, 10, 0.01)
A <- 1
phi <- 0.33
omega <- 1/10
x <- A * cos(2*pi*omega*t + phi)

par(mfrow=c(1,1))
plot(t, x, type="l", lwd=2)

tobs <- seq(min(t), max(t), 1)
xobs <- x[match(tobs, t)]   # safer than x[t %in% tobs]

points(tobs, xobs, col="magenta", pch=1)
abline(h =  A, col="cornflowerblue", lwd=2)
abline(h = -A, col="cornflowerblue", lwd=2)

dev.off()

# -------------------------------------------------------------------------
# Optional: Create EPS separately
postscript("plots/spectral_plot1.eps", height = 12, width = 6)

par(mfrow=c(1,1))
plot(t, x, type="l", lwd=2)
points(tobs, xobs, col="magenta", pch=1)
abline(h =  A, col="cornflowerblue", lwd=2)
abline(h = -A, col="cornflowerblue", lwd=2)

dev.off()
