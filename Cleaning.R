library(dplyr)
library(readr)
library(stringr)

df <- read_csv("US_Vehicle_Accident_Data.csv")

parse_crashes <- function(x) {
  if (is.na(x)) return(NA)
  x <- tolower(x)
  x <- str_replace_all(x, ",", "")
  if (str_detect(x, "million")) {
    num <- as.numeric(str_extract(x, "\\d+\\.?\\d*"))
    return(num * 1e6)
  } else if (str_detect(x, "^\\d+$") | str_detect(x, "^\\d+\\.\\d+$")) {
    return(as.numeric(x))
  } else {
    return(NA)
  }
}

parse_fatalities <- function(x) {
  if (is.na(x)) return(NA)
  x <- str_replace_all(x, ",", "")
  if (str_detect(x, "^\\d+$")) {
    return(as.numeric(x))
  } else {
    return(NA)
  }
}

df_clean <- df %>%
  mutate(
    `Crashes (approx.)` = sapply(`Crashes (approx.)`, parse_crashes),
    Fatalities = sapply(Fatalities, parse_fatalities)
  ) %>%
  filter(!`Year / Period` %in% c("Deer Collisions", "2019 Costs", "Annual (all years)"))

df_2023 <- df_clean %>% filter(str_detect(`Year / Period`, "2023"))

write_csv(df_clean, "cleaned_accident_data.csv")
write_csv(df_2023, "accident_2023_only.csv")

print("Cleaning complete. Files saved as cleaned_accident_data.csv and accident_2023_only.csv")
