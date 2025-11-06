library(tidyverse)
set.seed(4060)

# exercise 2


# a)

phi <- 0.543
n   <- 100
burn <- 200

W <- rnorm(n + burn)
X <- numeric(n + burn)
X[1] <- rnorm(1, sd = 1 / sqrt(1 - phi^2))

for (t in 2:(n + burn)) {
  X[t] <- phi * X[t - 1] + W[t]
}

X <- X[(burn + 1):(burn + n)]

df_X <- tibble(
  time = 1:n,
  X = X
)

p <- ggplot(df_X, aes(time, X)) +
  geom_line() +
  theme_bw() +
  labs(title = "AR(1) with phi = 0.543 and sigma = 1")

ggsave("plots/ar1_phi543.pdf", p, width = 12, height = 6)

df_X


# b)

loglik <- function(phi, X) {
  n <- length(X)
  term1 <- 0.5 * log(1 - phi^2)
  term2 <- -0.5 * (1 - phi^2) * X[1]^2
  term3 <- -0.5 * sum((X[2:n] - phi * X[1:(n-1)])^2)
  term1 + term2 + term3
}

score <- function(phi, X) {
  n <- length(X)
  part1 <- -phi / (1 - phi^2)
  part2 <- X[1]^2 * phi
  part3 <- sum((X[2:n] - phi * X[1:(n-1)]) * X[1:(n-1)])
  part1 + part2 + part3
}

Jn <- function(phi, X) {
  n <- length(X)
  s2 <- sum(X[1:(n-1)]^2)
  part1 <- -(1 + phi^2) / (1 - phi^2)^2
  part2 <- -sum(X[1]^2)
  part3 <- -s2
  -(1/n) * (part1 + part2 + part3)
}

loglik(phi, X)
score(phi, X)
Jn(phi, X)


# c) 

meansq <- cumsum(X^2) / (1:n)
tail(meansq, 5)


# e) 

f_ar1 <- function(w, phi) {
  (1/(2*pi)) / (1 + phi^2 - 2*phi*cos(2*pi*w))
}

whittle <- function(phi, x){
  n <- length(x)
  j <- 1:floor((n-1)/2)
  w <- j/n
  dx <- fft(x) / sqrt(n)
  Iw <- Mod(dx[j+1])^2
  sum(log(f_ar1(w,phi)) + Iw / f_ar1(w,phi))
}

# f) 

phis <- seq(-0.95, 0.95, by=0.01)
vals <- sapply(phis, whittle, x=X)
plot(phis, -vals, type="l")
ggsave("plots/whittle_curve.pdf", width=10, height=4)

# g) 

sim_compare <- function(n, R=300, phi=0.543){
  rmse <- function(est) sqrt(mean((est - phi)^2))
  
  ml <- wh <- numeric(R)
  for(r in 1:R){
    W <- rnorm(n+200)
    Z <- numeric(n+200)
    Z[1] <- rnorm(1, sd = 1/sqrt(1-phi^2))
    for(t in 2:(n+200)) Z[t] <- phi*Z[t-1]+W[t]
    x <- Z[(200+1):(200+n)]
    
    ml[r] <- optimize(function(a) -loglik(a, x), c(-0.99, 0.99))$minimum
    wh[r] <- optimize(function(a) whittle(a, x), c(-0.99, 0.99))$minimum
  }
  c(RMSE_ML = rmse(ml), RMSE_Whittle = rmse(wh))
}

sim_compare(100)
sim_compare(500)
sim_compare(1000)

# h) 

curv <- function(phi) {
  j <- 1:floor((n-1)/2)
  w <- j/n
  sum( (phi - cos(2*pi*w))^2 * f_ar1(w,phi)^2 )
}
curv(phi)


