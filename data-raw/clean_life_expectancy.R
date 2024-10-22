library(dplyr)
library(readr)

life_expectancy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-12-05/life_expectancy.csv')

colnames(life_expectancy)[4] <- "LifeExpectancy"

life_expectancy_clean <- life_expectancy %>% filter(!is.na(Code))

life_expectancy_clean  <- life_expectancy_clean %>%
  filter( Year > 1950)
usethis::use_data(life_expectancy_clean, overwrite = TRUE)
