# Make conjoint surveys using the cbcTools package

# Install packages
install.packages("fastDummies")
install.packages("remotes")
remotes::install_github("jhelvy/cbcTools")
install.packages("readr")

# Load libraries
library(cbcTools)
library(fastDummies)
library(here)
library(readr)

# Define profiles with attributes and levels
profiles <- cbc_profiles(
  price       = c(3, 5, 7), # 
  trip_time = c(20, 25, 30),   # 
  wait_time   = c(5, 7, 9),      # 
  shared_ride  = c("yes", "no"),
  human_present = c("yes", "no")
)

# Make a full-factorial design of experiment 
design <- cbc_design(
  profiles = profiles,
  n_resp   = 300, # Number of respondents
  n_alts   = 5,    # Number of alternatives per question
  n_q      = 8     # Number of questions per respondent
)

head(design) # preview

# Make a labeled design with "powertrain" as the label
design_labeled <- cbc_design(
  profiles = profiles,
  n_resp   = 1000, # Number of respondents
  n_alts   = 5,    # Number of alternatives per question
  n_q      = 8,    # Number of questions per respondent
  label = 'human_present'
)

head(design_labeled) # preview

# Make a survey with a "no choice" option
design_nochoice <- cbc_design(
  profiles = profiles,
  n_resp   = 1000, # Number of respondents
  n_alts   = 3,    # Number of alternatives per question
  n_q      = 8,    # Number of questions per respondent
  no_choice = TRUE
)

head(design_nochoice) # preview

# Save design
write_csv(design, here('choice_questions.csv'))