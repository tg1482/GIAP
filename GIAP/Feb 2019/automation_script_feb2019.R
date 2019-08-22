######################
# Tanmay Gupta
# Data Analyst - Feb 15, 2019
# tg1482@nyu.edu
######################
# Loading Packages
library(pacman)
p_load(tidyverse, ggplot2, pander, knitr, scales, readxl, kableExtra, rmarkdown, knitcitations, 
       imputeTS, lubridate, haven)
######################

######################
# Loading Survey Data and Correct Knowledge Questions
giap <- read_sav("Feb 2019/Feb 2019 Data.sav")
######################

######################
# Changing Variable Names and Structure

giap$facilityName[giap$facilityName == "Baptist Medical Center Jacksonville"] <- "Baptist Medical Center South"

giap <- giap %>% 
  rename("Hospital.Name" = "facilityName") %>% 
  rename("Hospital.ID" = "facilityID") %>% 
  rename("Unit" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name = as.factor(Hospital.Name),
         Unit = as.factor(Unit))

# Creating a list of Unique Hospital Names
hospital.names <- unique(giap$Hospital.Name) %>% na.omit()

# Creating date objects
giap <- giap %>% 
  mutate(startDate = mdy_hms(startDate),
         finishDate = mdy_hms(finishDate))
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

######################
# Automating report generation across all hospitals

cohort <- "February 2019"

for(name in hospital.names){
  render("Feb 2019/GIAP Individual Report.Rmd", 
         output_file = paste0("Feb 2019/results/", name, ".html"))
}
######################

