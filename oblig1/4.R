
library(tidyverse)
library(readr)

eur_link <- "https://data.norges-bank.no/api/data/EXR/B.EUR.NOK.SP?format=csv&bom=include&apisrc=nbi&startPeriod=2024-10-21&locale=no"
eur <- read_csv2(eur_link, locale = locale(decimal_mark=","), show_col_types = FALSE) %>% arrange(TIME_PERIOD)

xx <- eur %>% pull(OBS_VALUE)
n  <- length(xx)


# a)
df <- tibble(date=eur$TIME_PERIOD, x=xx)
ggplot(df,aes(date,x))+geom_line()+theme_bw()
ggsave("plots/a.pdf",width=10,height=4)
phi <- sum(xx[-n]*xx[-1])/sum(xx[-n]^2)
s2 <- mean((xx[-1]-phi*xx[-n])^2)
se <- sqrt(s2/sum(xx[-n]^2))
phi; phi+c(-1,1)*qnorm(.975)*se

# b)
set.seed(4060)
Tobs <- n*(phi-1)
sim <- function(M=4000,m=2000){
  Z<-matrix(rnorm(M*m,0,1/sqrt(m)),M);B<-t(apply(Z,1,cumsum))
  int<-rowMeans(B^2);T<-0.5*(rchisq(M,1)-1)/int;T}
Tsim <- sim()
mean(abs(Tsim)>=abs(Tobs))

# c)
dx <- diff(xx); s2dx <- var(dx)
simW <- rnorm(length(dx),sd=sqrt(s2dx))
tibble(date=df$date[-1],dx,simW) %>%
  pivot_longer(-date) %>%
  ggplot(aes(date,value,color=name))+geom_line()+theme_bw()
ggsave("plots/c.pdf",width=10,height=4)

# d) e)
ll <- function(p){
  l0<-exp(p[1]);c<-exp(p[2]);k<-l0/c;r<-1/c
  sum(-(k+.5)*log(1/c+.5*dx^2))+(-length(dx)/2)*log(2*pi)-length(dx)*(l0/c)*log(c)+
    length(dx)*(lgamma(k+.5)-lgamma(k))}
o<-optim(c(0,log(.2)),function(p)-ll(p))
l0<-exp(o$par[1]);c<-exp(o$par[2]);k<-l0/c;r<-1/c
lam<-rgamma(length(dx),k,r);sdv<-1/sqrt(lam)
simdx<-rnorm(length(dx),sd=sdv)
tibble(date=df$date[-1],dx,simdx) %>%
  pivot_longer(-date) %>%
  ggplot(aes(date,value,color=name))+geom_line()+theme_bw()
ggsave("plots/e.pdf",width=10,height=4)

# f)
h<-60
rwf<-xx[(n-h):(n-1)]
pred_rw<-xx[(n-h):(n-1)]
pred_ar<-map_dbl((n-h+1):n,function(t) as.numeric(predict(arima(xx[1:(t-1)],c(0,1,1)),1)$pred))
act<-xx[(n-h+1):n]
sqrt(mean((act-pred_rw)^2)); sqrt(mean((act-pred_ar)^2))
