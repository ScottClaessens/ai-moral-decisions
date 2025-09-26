# function to load data_decisions.csv
load_data_decisions <- function(file_decisions, data_participants) {
  read_csv(file_decisions, show_col_types = FALSE) |>
    # keep only participants who passed attention check
    filter(id %in% data_participants$id)
}
