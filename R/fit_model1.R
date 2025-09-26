# function to fit model 1
fit_model1 <- function(data_decisions) {
  brm(
    formula = decision ~ 0 + verb + (0 + verb | id) + (0 + verb | domain/item),
    data = data_decisions,
    family = bernoulli(),
    prior = c(
      prior(normal(0, 1), class = b),
      prior(exponential(3), class = sd),
      prior(lkj(2), class = cor)
    ),
    cores = 4,
    seed = 2113
  )
}
