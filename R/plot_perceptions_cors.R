# function to plot correlation matrix of item perceptions
plot_perceptions_cors <- function(data_perceptions) {
  # get means of all variables for different items
  d <-
    data_perceptions |>
    group_by(item) |>
    summarise_at(
      vars(intelligence:unfair_outcomes),
      function(x) mean(x, na.rm = TRUE)
    )
  # get upper triangle of correlation matrix
  cor_matrix <-
    d |>
    dplyr::select(!item) |>
    cor(use = "pairwise")
  cor_matrix[lower.tri(cor_matrix)] <- NA
  diag(cor_matrix) <- NA
  # function to convert variable names
  convert_names <- function(x) {
    str_to_sentence(str_replace_all(x, "_", " "))
  }
  # wrangle data and plot
  p <-
    cor_matrix |>
    as_tibble(rownames = "x") |>
    pivot_longer(
      cols = !x,
      names_to = "y",
      values_to = "cor"
    ) |>
    drop_na() |>
    mutate(
      across(
        c(x, y),
        function(x) {
          factor(
            convert_names(x),
            levels = convert_names(rownames(cor_matrix))
          )
        }
      )
    ) |>
    ggplot(
      aes(
        x = x,
        y = fct_rev(y),
        fill = cor,
        label = format(round(cor, 2), nsmall = 2)
      )
    ) +
    geom_tile() +
    geom_text(size = 2) +
    scale_fill_gradient2(
      name = NULL,
      low = "blue",
      high = "red",
      limits = c(-1, 1)
    ) +
    labs(
      title = "Correlations for perceptions of moral decisions",
      x = NULL,
      y = NULL
    ) +
    theme_bw() +
    theme(
      panel.border = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_text(angle = 35, hjust = 1, vjust = 1),
      legend.ticks = element_blank() 
    )
  # save
  ggsave(
    filename = "plots/correlations.pdf",
    plot = p,
    height = 4,
    width = 5.3
  )
  return(p)
}
