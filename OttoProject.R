## Step 1: Load the Tidyverse, Rvest (html), janitor (less mess)
library(tidyverse)
library(rvest)
library(janitor)
library(dplyr)

#Add dataset from Pro-football reference
pro_football <- read_html("https://www.pro-football-reference.com/years/2021/receiving.htm")

pf_tables <- pro_football %>%
  html_table(fill = TRUE)

#Clean and Filter to remove unwanted rows
nfl_season_WR <- pf_tables[[1]] %>% 
 clean_names() %>% 
 filter(tm != 'Tm') %>%
  mutate_at(c('rec'), as.numeric)

#Create dataset with only Tightends 'TE'

nfl_te=nfl_season_WR[nfl_season_WR$pos == "TE",]

#Create dataset with 28 year old players
nfl28=nfl_season_WR[nfl_season_WR$age == "28",]

#Create a dataset removing the "empty players" there are 17 to remove
nfl_season_WR[nfl_season_WR$player == "Player",]

#List oldest players in order

nfl_season_WR %>%
  arrange(desc(age)) %>%
  head(20)

#Find Oldest player
nfl_season_WR %>%
  group_by(age, player) %>%
  summarise(Oldest_age = max(age)) %>%
  arrange(desc(age))
#Oldest Player in Dataset Aaaron Rodgers

#Find Average receptions
#Reception column listed as a Character must be changed to a Numeric value
glimpse(nfl_season_WR)

nfl_season_WR %>%
  summarize(rec_avg = mean(rec, na.rm=TRUE))
#Receptions Average 22.7