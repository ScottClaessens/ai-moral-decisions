# function to plot feedback on the main game
plot_game_feedback <- function(data_participants) {
  # left plot
  pA <-
    ggplot(
      data = data_participants,
      mapping = aes(x = enjoy)
    ) +
    geom_bar(fill = "#63CCCA") +
    scale_x_continuous(
      name = "How much did you enjoy\nanswering the questions?",
      breaks = 1:7
    ) +
    scale_y_continuous(
      name = "Count",
      expand = c(0, 0),
      limits = c(0, 70)
    ) +
    theme_classic()
  # right plot
  pB <-
    ggplot(
      data = data_participants,
      mapping = aes(x = length)
    ) +
    geom_bar(fill = "#42858C") +
    scale_x_continuous(
      name = "How was the\ngame length?",
      breaks = 1:5,
      limits = c(0.5, 5.5)
    ) +
    scale_y_continuous(
      name = "Count",
      expand = c(0, 0),
      limits = c(0, 160)
    ) +
    theme_classic()
  # put together
  out <- pA + pB + plot_layout(widths = c(0.7, 0.5))
  # save
  ggsave(
    filename = "plots/game_feedback.pdf",
    plot = out,
    height = 3,
    width = 6
  )
  return(out)
}
