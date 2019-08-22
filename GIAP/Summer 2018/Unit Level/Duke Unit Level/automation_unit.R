library(pacman)
p_load(tidyverse, ggplot2, pander, knitr, scales, readxl, kableExtra, rmarkdown, knitcitations, imputeTS, lubridate)
######################

######################
# Loading Survey Data and Correct Knowledge Questions
giap <- read_excel("summer2018AllData.xlsx")
######################

######################
# Changing Variable Names and Structure
giap <- giap %>% 
  rename("Hospital.Name" = "facility") %>% 
  rename("Unit.Name" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name=as.factor(Hospital.Name))

# Creating a list of Unique Hospital Names
Hospital.Names <- unique(giap$Hospital.Name) %>% na.omit()

# Creating date objects
giap <- giap %>% 
  mutate(startDate = mdy_hms(startDate),
         finishDate = mdy_hms(finishDate))
######################

######################
# Creating a trim function, incase necessary. Trims the white space at the beginning and the end of a word
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
######################

######################
# Fucntion to Change NA to 0
na_to_zero <- function(val){
  zero <- ifelse(is.na(val), 0, val)
  return(zero)
}
######################

######################
# Not in Function
'%!in%' <- function(x,y)!('%in%'(x,y))
######################

unit.names <- unique(giap$Unit.Name)
hospital_name <- "HonorHealth Scottsdale Shea Medical Center"

giap <- giap %>% 
  filter(Hospital.Name == hospital_name) %>% 
  select(-Hospital.Name) %>%  
  mutate(Unit.Name = as.factor(Unit.Name))

hospital_names <- unique(giap$`Unit.Name`)[!is.na(unique(giap$`Unit.Name`))]

cohort <- "Summer 2018"

for(name in unit.names){
  render("Scottsdale Shea Medical Center.Rmd", 
         output_file = paste0("Scottsdale Shea Medical Center Results/", name, ".html"))
}