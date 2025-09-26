# function to load data_participants.csv
load_data_participants <- function(file_participants) {
  read_csv(file_participants, show_col_types = FALSE) |>
    # keep only participants who passed attention check
    filter(attention == "TikTok")
}
