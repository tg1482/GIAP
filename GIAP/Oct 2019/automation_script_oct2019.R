######################
# Tanmay Gupta
# Data Analyst - Apr 16, 2020
# tg1482@nyu.edu
######################
# Loading Packages
pacman::p_load(ggplot2, knitr, scales, kableExtra, rmarkdown, knitcitations, dplyr, tidyr, haven)
######################

######################
# Loading Survey Data and Correct Knowledge Questions
giap <- read_sav("Oct 2019/Oct 2019 Data.sav")
######################

######################
# Changing Variable Names and Structure

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

two_to_zero <- function(val){
  zero <- ifelse(val == 2, 0, val)
  return(zero)
}
######################

######################
# Not in Function
'%!in%' <- function(x,y)!('%in%'(x,y))
######################

######################
# Automating report generation across all hospitals

cohort <- "October 2019"
num_hospitals <- length(unique(giap$Hospital.ID))
eligible_nurses <- 308
responded_nurses <- nrow(giap)


for(name in hospital.names){
  render("Oct 2019/GIAP Individual Report.Rmd", 
         output_file = paste0("Oct 2019/results/", name, ".html"))
}
######################

# render("Fall 2019/GIAP Individual Report.Rmd", 
#        output_file = paste0("Fall 2019/results/", name, ".html"))
