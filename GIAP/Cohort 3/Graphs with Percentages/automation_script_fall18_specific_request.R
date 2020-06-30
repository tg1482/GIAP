######################
# Tanmay Gupta
# Data Analyst - Feb 15, 2019
# tg1482@nyu.edu
######################
# Loading Packages
library(pacman)
p_load(tidyverse, ggplot2, pander, knitr, scales, readxl, kableExtra, rmarkdown, knitcitations, imputeTS, lubridate)
######################

######################
# Loading Survey Data and Correct Knowledge Questions
giap <- read_excel("Oct 2018/Oct 2018 Data.xlsx")
######################

######################
# Changing Variable Names and Structure
giap <- giap %>% 
  rename("Hospital.Name" = "facilityName") %>% 
  rename("Unit" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name=as.factor(Hospital.Name))

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

#for(name in hospital.names){
# render("GIAP Fall 2018 Cohort Individual Report.Rmd",
#         output_file=paste0("C:/Users/tg1482/Desktop/GIAP/Oct 2018/results/", name, ".html"))
#}
######################

name <- "Kootenai Health"
render("Hospital Specific Report.Rmd",
                output_file=paste0("C:/Users/tg1482/Desktop/GIAP/Oct 2018/results-1/", name, ".html"))