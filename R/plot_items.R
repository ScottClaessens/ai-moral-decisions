# function to plot differences between items from model 1
plot_items <- function(fit1) {
  # get fitted values for domains
  d <-
    fit1$data[, c("verb", "domain", "item")] |>
    unique() |>
    as_tibble() |>
    arrange(verb, domain, item)
  f <-
    fitted(
      object = fit1,
      newdata = d,
      re_formula = ~ (0 + verb | domain/item),
      summary = TRUE
    )
  # add to data
  d$post <- f[, "Estimate"]
  # amend long item
  d <-
    d |>
    mutate(
      item = ifelse(
        item == paste0(
          "Whether to prioritise the safety of passengers",
          " or pedestrians in a car accident"
        ),
        "Whether to prioritise passengers or pedestrians in a car accident",
        item
      )
    )
  # get order for plot
  items <-
    d |>
    filter(verb == "Advise") |>
    arrange(post) |>
    pull(item)
  # plot
  p <-
    d |>
    rename(Verb = verb) |>
    ggplot(
      mapping = aes(
        x = post,
        y = fct_relevel(item, items)
      )
    ) +
    geom_line() +
    geom_point(
      mapping = aes(
        x = post,
        colour = Verb
      )
    ) +
    scale_x_continuous(limits = c(0, 1)) +
    labs(
      x = "Probability",
      y = NULL,
      title = paste(
        "Probability of choosing that AI should decide/advise",
        "on moral decisions, split by item",
        sep = "\n"
      )
    ) +
    theme_classic() +
    theme(
      legend.position = "inside",
      legend.position.inside = c(0.8, 0.2),
      axis.text.y = element_text(size = 8)
    )
  # save
  ggsave(
    filename = "plots/items.pdf",
    plot = p,
    height = 8,
    width = 8
  )
  return(p)
}
