
library(tidyverse)
set.seed(4060)

# exercise 1

# a)

rho <- 0.4
n   <- 100

Sigma <- outer(1:n, 1:n, function(t, s) rho^(abs(t - s)))

L <- chol(Sigma)
Z <- rnorm(n)
X <- as.vector(t(L) %*% Z)

acov_est <- acf(X, type = "covariance", plot = FALSE, lag.max = 3)$acf

tibble(
  lag = 0:3,
  empirical_autocov = as.numeric(acov_est)
)

# b)

rho <- 0.4
n   <- 100
beta <- 0.05

Sigma <- outer(1:n, 1:n, function(t, s) rho^(abs(t - s)))

L <- chol(Sigma)
Z <- rnorm(n)
X <- as.vector(t(L) %*% Z)

t <- 1:n
Y <- beta * t + X

# theoretical autocovariance of Y: since beta*t is deterministic,
# Cov(Yt, Ys) = Cov(Xt, Xs) = rho^|t-s|

# plot Y_t
df_Y <- tibble(
  time = t,
  Y = Y
)

p1 <- ggplot(df_Y, aes(time, Y)) +
  geom_line() +
  theme_bw() +
  labs(title = "Simulated Y_t = beta*t + X_t")

ggsave("plots/Y_series.pdf", p1, width = 12, height = 6)

# empirical autocovariance
acov_Y <- acf(Y, type = "covariance", plot = FALSE, lag.max = 3)$acf

tibble(
  lag = 0:3,
  empirical_autocov_Y = as.numeric(acov_Y)
)

# c)

rho <- 0.4
n   <- 100
beta <- 0.05

Sigma <- outer(1:n, 1:n, function(t, s) rho^(abs(t - s)))
L <- chol(Sigma)
Z <- rnorm(n)
X <- as.vector(t(L) %*% Z)

t <- 1:n
mu <- beta * t
Y  <- mu + X

# empirical autocovariance of Y (lags 0–3)
acov_Y <- acf(Y, type = "covariance", plot = FALSE, lag.max = 3)$acf

# expected value of gamma_hat_Y(h) when Y_t = mu_t + X_t (X zero-mean, stationary):
# E[ gamma_hat_Y(h) ] ≈ mean_{t=1..n-h}[(mu_t - mean(mu)) (mu_{t+h} - mean(mu))] + rho^h
# for mu_t = beta*t, the first term is large and positive, dominating the estimate

mu_bar <- mean(mu)

det_term <- sapply(0:3, function(h) {
  m1 <- mu[1:(n - h)] - mu_bar
  m2 <- mu[(1 + h):n] - mu_bar
  mean(m1 * m2)
})

theory_gammaX <- rho^(0:3)
expected_acov <- det_term + theory_gammaX

tibble(
  lag = 0:3,
  empirical_autocov_Y = as.numeric(acov_Y),
  deterministic_component = det_term,
  gamma_X_theory = theory_gammaX,
  expected_gammahat_Y = expected_acov
)

# d)

rho <- 0.4
n   <- 100
beta <- 0.05

Sigma <- outer(1:n, 1:n, function(t, s) rho^(abs(t - s)))
L <- chol(Sigma)
Z <- rnorm(n)
X <- as.vector(t(L) %*% Z)

t <- 1:n
Y <- beta * t + X

# detrend: Y*_t = Y_t - beta*t
Y_star <- Y - beta * t

acov_Y_star <- acf(Y_star, type = "covariance", plot = FALSE, lag.max = 3)$acf

tibble(
  lag = 0:3,
  empirical_autocov_Ystar = as.numeric(acov_Y_star)
)
