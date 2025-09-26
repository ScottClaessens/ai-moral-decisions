# function to effects of predictors in model 2
plot_predictors <- function(fit2, predictor) {
  # get raw data for plot
  d <-
    fit2$data |>
    group_by(verb, item) |>
    summarise(
      prop = mean(decision == "Yes"),
      predictor = mean(!!sym(predictor), na.rm = TRUE),
      .groups = "drop"
    )
  # get model predictions
  newdata <-
    expand_grid(
      verb = c("Advise", "Decide"),
      predictor = seq(-3, 3, length.out = 100)
    ) |>
    rename(!!predictor := predictor)
  f <- 
    fitted(
      object = fit2,
      newdata = newdata,
      re_formula = NA
    )
  newdata <- bind_cols(newdata, f)
  # list of questions for plot label
  questions <- c(
    "intelligence"    = "Does making this decision require intelligence?",
    "empathy"         = "Does making this decision require empathy?",
    "quickly"         = "Does this decision need to be made quickly?",
    "transparently"   = "Does this decision need to be made transparently?",
    "difficult"       = "Is this a difficult decision to make?",
    "good_outcomes"   = "Could this decision produce good outcomes?",
    "harm"            = "Could this decision cause harm?",
    "unfair_outcomes" = "Could this decision lead to unfair outcomes?"
  )
  # plot
  p <-
    ggplot() +
    geom_point(
      data = d,
      mapping = aes(
        x = predictor,
        y = prop,
        colour = verb
      )
    ) +
    geom_ribbon(
      data = newdata,
      mapping = aes(
        x = !!sym(predictor),
        ymin = Q2.5,
        ymax = Q97.5,
        fill = verb
      ),
      alpha = 0.2
    ) +
    geom_line(
      data = newdata,
      mapping = aes(
        x = !!sym(predictor),
        y = Estimate,
        colour = verb
      )
    ) +
    facet_grid(. ~ verb) +
    scale_x_continuous(
      name = questions[predictor],
      breaks = -3:3,
      labels = function(x) as.integer(x + 4)
    ) +
    ylab("Proportion stating that AI\nshould make moral decision") +
    theme_classic() +
    theme(legend.position = "none")
  # save
  ggsave(
    filename = paste0("plots/predictors/", predictor, ".pdf"),
    plot = p,
    height = 3.5,
    width = 6.5
  )
  return(p)
}
