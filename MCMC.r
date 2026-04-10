install.packages("rstan")
library(rstan)
#Loading the data
x_df <- read.csv("X.csv", header = FALSE)
x_df <- x_df[-1, ]
x_df <- x_df[, -1]
dim(x_df)
x <- as.matrix(x_df)
mode(x) <- "numeric"

y_df <- read.csv("Y.csv", header = FALSE)
y_df <- y_df[-1, ]
y <- y_df[, 2]
y <- as.integer(y)

sum(is.na(x))
sum(is.na(y))

#Define the model to be used in STAN
stan_model_code <- "
data {
    int<lower=0> n;
    int<lower=0> d;
    matrix[n, d] x;
    int<lower=0,upper=1> y[n];
}
parameters {
    vector[d] w;
    real b;
}
model {
    // priors
    w ~ normal(0,1);
    b ~ normal(0,1);
    // likelihood
    y ~ bernoulli_logit(x * w + b);
}
"
#Feeding our data to the stan model defined above.

stan_data <- list(
  n = nrow(x),
  d = ncol(x),
  x = x,
  y = y
)

#Running the MCMC chain
fit <- stan(
  model_code = stan_model_code,
  data = stan_data,
  iter = 2000,
  warmup = 500,
  chains = 4
)

#Printing the data
print(fit)

#Now, visualize
install.packages("bayesplot")
library(bayesplot)
windows() # I am using VS code, this enables me to look at the plots
mcmc_trace(as.array(fit), pars = c("b", "w[1]", "w[2]"))
mcmc_dens(as.array(fit), pars = c("b", "w[1]", "w[2]"))

#Export to python to carry out the predictions as the model has been trained
posterior_1 <- as.data.frame(fit)
head(posterior_1)
write.csv(posterior_1, "posterior_samples_1.csv", row.names = FALSE)

#Stan includes log posteriors as well, for curiosity, I wanna plot this
windows()
traceplot(fit, pars = "lp__")


#Loading X1.csv and repeating the same process. 

x1_df <- read.csv("X1.csv", header = FALSE)
x1_df <- x1_df[-1, ]
x1_df <- x1_df[, -1]
dim(x1_df)
x1 <- as.matrix(x1_df)
mode(x1) <- "numeric"

sum(is.na(x1))

stan_data <- list(
  n = nrow(x1),
  d = ncol(x1),
  x = x1,
  y = y
)

fit <- stan(
  model_code = stan_model_code,
  data = stan_data,
  iter = 2000,
  warmup = 500,
  chains = 4
)

windows()
mcmc_trace(as.array(fit), pars = c("b", "w[1]", "w[2]"))
mcmc_dens(as.array(fit), pars = c("b", "w[1]", "w[2]"))
