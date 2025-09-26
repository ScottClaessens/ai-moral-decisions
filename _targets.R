library(targets)
library(tarchetypes)

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
  # fit and plot model 1
  tar_target(fit1, fit_model1(data_decisions)),
  tar_target(plot_verb, plot_verbs(fit1)),
  tar_target(plot_domain, plot_domains(fit1)),
  tar_target(plot_item, plot_items(fit1)),
  # print session info for reproducibility
  tar_target(
    sessionInfo,
    writeLines(capture.output(sessionInfo()), "sessionInfo.txt")
  )
)
