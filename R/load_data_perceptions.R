# function to load data_perceptions.csv
load_data_perceptions <- function(file_perceptions, data_participants) {
  read_csv(file_perceptions, show_col_types = FALSE) |>
    # keep only participants who passed attention check
    filter(id %in% data_participants$id)
}
