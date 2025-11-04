library(tidyverse)
set.seed(4060)

# exercise 2

# a)

phi <- 0.543
n   <- 100
burn <- 200

# simulate AR(1) with burn-in
W <- rnorm(n + burn)
X <- numeric(n + burn)
X[1] <- rnorm(1, sd = 1 / sqrt(1 - phi^2))

for (t in 2:(n + burn)) {
  X[t] <- phi * X[t - 1] + W[t]
}

# remove burn-in to get stationary sample
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
