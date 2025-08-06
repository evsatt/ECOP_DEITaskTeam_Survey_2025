##Script to combine the survey results with the Decade Action data

#PACKAGES----
library(dplyr)
library(stringr)

#READ IN DATA----
# Load survey data CSV
survey_data <- read.csv("Data_ECOPDEITaskTeam/01_survey data pulled from google_form title_Strategies advancing DEI.csv")

# Load ocean decade actions CSV
ocean_decade_data <- read.csv("Data_ECOPDEITaskTeam/00_Endorsed_Ocean_Decade_Actions_to_Date_-_June_2025.csv")

View(survey_data)
View(ocean_decade_data)

#COMBINE DATA----

# Clean names for matching
survey_data$Decade_Action_Name <- str_trim(tolower(survey_data[[12]]))
ocean_decade_data$Decade_Action_Name <- str_trim(tolower(ocean_decade_data$Name.of.the.Proposal))


combined_data <- survey_data %>%
  left_join(ocean_decade_data, by = "Decade_Action_Name")

dim(combined_data)
##NOTE: need to verify this looks ready to go

#ANALYZE DATA----