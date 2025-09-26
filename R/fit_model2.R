# function to fit model 1
fit_model2 <- function(data_decisions, data_perceptions, predictor) {
  # get means of all variables for different items
  data_perceptions <-
    data_perceptions |>
    group_by(item) |>
    summarise_at(
      vars(intelligence:unfair_outcomes),
      function(x) mean(x, na.rm = TRUE) - 4 # centering
    )
  # link data sets
  data_decisions <- left_join(data_decisions, data_perceptions, by = "item")
  # construct formula
  formula <- bf(
    paste0(
      "decision ~ 0 + verb + verb:",
      predictor,
      " + (0 + verb | id) + (0 + verb | domain/item)"
    )
  )
  # fit model
  brm(
    formula = formula,
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
