options(tidyverse.quiet = TRUE)
library(targets)
library(tarchetypes)
library(tidyverse)

tar_option_set(packages = c("brms", "patchwork", "tidybayes", "tidyverse"))
tar_source()

list(
  # identify data files
  tar_target(file_participants, "data/data_participants.csv", format = "file"),
  tar_target(file_decisions, "data/data_decisions.csv", format = "file"),
  tar_target(file_perceptions, "data/data_perceptions.csv", format = "file"),
  # load data
  tar_target(data_participants, load_data_participants(file_participants)),
  tar_target(data_decisions, load_data_decisions(file_decisions,
                                                 data_participants)),
  tar_target(data_perceptions, load_data_perceptions(file_perceptions,
                                                     data_participants)),
  # plot feedback on game
  tar_target(plot_feedback, plot_game_feedback(data_participants)),
  # plot correlations between perceptions of different moral decisions
  tar_target(plot_cors, plot_perceptions_cors(data_perceptions)),
  # fit and plot model 1
  tar_target(fit1, fit_model1(data_decisions)),
  tar_target(plot_verb, plot_verbs(fit1)),
  tar_target(plot_domain, plot_domains(fit1)),
  tar_target(plot_item, plot_items(fit1)),
  # fit and plot model 2
  tar_map(
    values = tibble(
      predictor = c("intelligence", "empathy", "quickly", "transparently",
                    "difficult", "good_outcomes", "harm", "unfair_outcomes")
    ),
    tar_target(fit2, fit_model2(data_decisions, data_perceptions, predictor)),
    tar_target(plot_predictor, plot_predictors(fit2, predictor))
  ),
  # print session info for reproducibility
  tar_target(
    sessionInfo,
    writeLines(capture.output(sessionInfo()), "sessionInfo.txt")
  )
)
