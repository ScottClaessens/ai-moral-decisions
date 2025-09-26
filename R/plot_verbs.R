# function to plot difference between verbs from model 1
plot_verbs <- function(fit1) {
  # get posterior samples
  post <- posterior_samples(fit1)
  # convert to long tibble
  d <-
    tibble(
      id = 1:length(post$b_verbAdvise),
      Advise = inv_logit_scaled(post$b_verbAdvise),
      Decide = inv_logit_scaled(post$b_verbDecide)
    ) |>
    mutate(Difference = Advise - Decide) |>
    pivot_longer(cols = Advise:Difference)
  # plot
  p <-
    ggplot(
      data = filter(d, name != "Difference"),
      mapping = aes(
        x = value,
        y = name,
        fill = name
      )
    ) +
    stat_slabinterval() +
    scale_x_continuous(limits = c(0, 1)) +
    labs(
      x = "Probability",
      y = "Verb",
      title = paste(
        "Probability of choosing that AI should",
        "decide/advise on moral decisions",
        sep = "\n"
      ),
      subtitle = "Model estimates with 66% and 95% credible intervals"
    ) +
    theme_classic() +
    theme(legend.position = "none")
  # save
  ggsave(
    filename = "plots/verbs.pdf",
    plot = p,
    height = 3,
    width = 5
  )
  return(p)
}
