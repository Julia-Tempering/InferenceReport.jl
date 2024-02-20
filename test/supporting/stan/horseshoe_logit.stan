data {
  int<lower=0> n;                  // Number of observations
  int<lower=0> d;                  // Number of predictors
  matrix[n,d] x;                   // design matrix
  array[n] int<lower=0,upper=1> y; // outputs
}

parameters {
  real<lower=0> tau;               // global shrinkage
  vector<lower=0>[d] lambda;       // local shrinkage
  real beta0;                      // intercept
  vector[d] beta;                  // slope
}

model {
  tau    ~ cauchy(0, 1);
  lambda ~ cauchy(0, 1);
  beta0  ~ student_t(3,0,1);
  beta   ~ normal(0, tau * lambda); 
  y      ~ bernoulli_logit_glm(x, beta0, beta);
}