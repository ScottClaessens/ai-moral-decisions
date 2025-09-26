# function to plot differences between domains from model 1
plot_domains <- function(fit1) {
  # get fitted values for domains
  d <- 
    expand_grid(
      domain = unique(fit1$data$domain),
      verb = c("Advise", "Decide")
    )
  f <-
    fitted(
      object = fit1,
      newdata = d,
      re_formula = ~ (0 + verb | domain),
      summary = FALSE
    )
  # add to data
  d$post <- lapply(seq_len(ncol(f)), function(i) f[,i])
  # get order for plot
  domains <-
    d |>
    rowwise() |>
    mutate(post = median(post)) |>
    filter(verb == "Advise") |>
    arrange(post) |>
    pull(domain)
  # plot
  p <-
    d |>
    rename(Verb = verb) |>
    unnest(post) |>
    ggplot(
      mapping = aes(
        x = post,
        y = fct_relevel(domain, domains),
        colour = Verb
      )
    ) +
    tidybayes::stat_pointinterval(position = position_dodge(width = -0.3)) +
    scale_x_continuous(limits = c(0, 1)) +
    labs(
      x = "Probability",
      y = "Domain",
      title = paste(
        "Probability of choosing that AI should decide/advise",
        "on moral decisions, split by domain",
        sep = "\n"
      ),
      subtitle = "Model estimates with 66% and 95% credible intervals"
    ) +
    theme_classic() +
    theme(
      legend.position = "inside",
      legend.position.inside = c(0.9, 0.4)
    )
  # save
  ggsave(
    filename = "plots/domains.pdf",
    plot = p,
    height = 4.5,
    width = 6.5
  )
  return(p)
}
