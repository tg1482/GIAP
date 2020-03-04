#######################
# Tanmay Gupta
# Data Analyst - April 11, 2019
# Research Project - Mattia Gilmartin
#######################
# Loading Packages
library(pacman)
p_load(tidyverse, ggplot2, pander, knitr, scales, readxl, kableExtra, rmarkdown, knitcitations, imputeTS, lubridate)
#######################
# Getting Data
#######################
# Fall 2017
fall2017 <- read_excel("Data/Complete Raw Data CMC.xlsx")
arost <- read_excel("Data/Master List of Variables.xlsx", sheet = "Participating - full rosters")

fall2017 <- fall2017 %>% 
  mutate(StartDate = as_date(StartDate),
         EndDate = as_date(EndDate))

fall2017 <- arost %>% 
  select(`Hospital ID`, `Hospital Name (Cleaned, Revised to Match)`) %>% 
  mutate(`Hospital ID` = round(as.numeric(`Hospital ID`),4)) %>% 
  unique() %>% 
  na.omit() %>% 
  left_join(fall2017 %>% mutate(`Hospital ID` = round(as.numeric(`Hospital ID`),4)), ., by = "Hospital ID")

colnames(fall2017)[length(colnames(fall2017))]<-"Hospital.Name"
colnames(fall2017)[227:229] <- c("Hospital.ID", "Unit.ID", "Participant.ID")

# Anonymous Respondents

anon_resp <- fall2017 %>% 
  filter(is.na(Participant.ID)) %>% 
  mutate(ResponseId, latitude = LocationLatitude, longitude = LocationLongitude) %>%
  select(ResponseId, IPAddress, latitude, longitude)

anon_resp <- anon_resp %>% 
  filter(!is.na(latitude)) %>% 
  select(-ResponseId) %>% 
  unique() %>%
  mutate(PLACE = case_when(latitude > 42 & latitude < 46 ~ "Phoenix, AZ",
                           latitude > 38 & latitude < 39 ~ "Washington, DC",
                           latitude > 33 & latitude < 34 ~ "Phoenix, AZ",
                           latitude > 40 & latitude < 41 ~ "New York, NY",
                           latitude > 41 & latitude < 42 ~ "Cleveland, OH")) %>%
  select(-latitude, -longitude) %>% 
  {left_join(x = anon_resp, y = ., by = "IPAddress") %>%
      unique() %>%
      mutate(PLACE = case_when(!is.na(PLACE) ~ PLACE,
                               IPAddress == "99.19.12.212" ~ "Cleveland, OH",
                               IPAddress == "99.203.0.144" ~ "Cleveland, OH",
                               IPAddress == "64.251.40.254" ~ "New York, NY")) %>% 
      select(ResponseId, PLACE)}

fall2017 <- fall2017 %>% 
  left_join(x = ., y = anon_resp, by = "ResponseId") %>% 
  mutate(Hospital.Name = ifelse(is.na(Hospital.Name), 
                                case_when(PLACE=="Phoenix, AZ" ~ "Scottsdale Thompson Peak Medical Center",
                                          PLACE == "Washington, DC" ~ "Washington DC VA",
                                          PLACE == "New York, NY" ~ "Metropolitan Hospital",
                                          PLACE == "Cleveland, OH" ~ "University Hospitals Parma"), Hospital.Name),
         Hospital.ID = ifelse(is.na(Hospital.ID), case_when(Hospital.Name == "Scottsdale Thompson Peak Medical Center" ~ 20,
                                                            Hospital.Name == "Washington DC VA" ~ 21,
                                                            Hospital.Name == "Metropolitan Hospital" ~ 22,
                                                            Hospital.Name == "University Hospitals Parma" ~ 23),Hospital.ID))

#######################
# Feb 2018
#######################
feb2018 <-  read_excel("Data/feb2018data.xlsx")

feb2018 <- feb2018 %>% 
  rename("Hospital.Name" = "facility") %>% 
  rename("Unit" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name=as.factor(Hospital.Name))

#######################
# June 2018
#######################
june2018 <- read_excel("Data/summer2018AllData.xlsx")

june2018 <- june2018 %>% 
  rename("Hospital.Name" = "facility") %>% 
  rename("Unit" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name=as.factor(Hospital.Name))

#######################
# Fall 2018
#######################
fall2018 <- read_excel("Data/Oct 2018 Data.xlsx")

fall2018 <- fall2018 %>% 
  rename("Hospital.Name" = "facilityName") %>% 
  rename("Unit" = "primaryNursingUnit") %>% 
  mutate(Hospital.Name=as.factor(Hospital.Name))

#######################
# Analysis
#######################

#######################
# Fall 2017
#######################

# Teaching Status

datafall2017 <- fall2017 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(!is.na(Q29), Q29 != "Other") %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number))

# Nurses

nurse_fall2017 <- fall2017 %>% 
  select(Hospital.Name, Q21, Q25, Q26, Q27, Q30, Q31)  %>%
  group_by(Hospital.Name) %>% 
  mutate("Total Nurses" = n()) %>% 
  filter(Q30 != -1) %>% 
  mutate("Female Nurses (%)" = sum(Q21=="Female")/`Total Nurses`,
         "Degree Entry (% Diploma)" = sum(Q30 == 1)/`Total Nurses`,
         "Degree Entry (% Associate's)" = sum(Q30 == 2)/`Total Nurses`,
         "Degree Entry (% Baccalaureate)" = sum(Q30 == 3)/`Total Nurses`,
         "Degree Entry (% Master's)" = sum(Q30 == 4)/`Total Nurses`,
         "Degree Entry (% Doctorate)" = sum(Q30 == 5)/`Total Nurses`,
         "Highest Degree (% High School)" = sum(Q31 == 1)/`Total Nurses`,
         "Highest Degree (% Vocational Training)" = sum(Q31 == 2)/`Total Nurses`,
         "Highest Degree (% BS, BA)" = sum(Q31 == 3)/`Total Nurses`,
         "Highest Degree (% MS, MA)" = sum(Q31 == 4)/`Total Nurses`,
         "Highest Degree (% Clinical Doctorate)" = sum(Q31 == 5)/`Total Nurses`,
         "Highest Degree (% Research Doctorate)" = sum(Q31 == 6)/`Total Nurses`,
         "Part-Time (% Enrolled)" = sum(Q25 == 1)/`Total Nurses`,
         "Full-Time (% Enrolled)" = sum(Q25 == 2)/`Total Nurses`,
         "Certifications (% NP)" = sum(Q26 == 1)/`Total Nurses`,
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`) %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% View()
  
#######################
# Feb 2018
#######################

# Teaching Status

feb2018[is.na(feb2018)] <- 9

datafeb2018 <- feb2018 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(Q29 != 9) %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number)) %>% 
  ungroup() %>% 
  mutate(Q29 = case_when(Q29 == 1 ~ "Academic Medical Center",
                         Q29 == 2 ~ "Community Teaching Hospital",
                         Q29 == 3 ~ "Non-teaching Hospital",
                         Q29 == 4 ~ "Other"))
# Nurses

nurse_feb2018 <- feb2018 %>% 
  select(Hospital.Name, Q21, Q25, Q26, Q27, Q30, Q31)  %>%
  group_by(Hospital.Name) %>% 
  mutate("Total Nurses" = n()) %>% 
  filter(Q30 != -1) %>% 
  mutate("Female Nurses (%)" = sum(Q21==2)/`Total Nurses`,
         "Degree Entry (% Diploma)" = sum(Q30 == 1)/`Total Nurses`,
         "Degree Entry (% Associate's)" = sum(Q30 == 2)/`Total Nurses`,
         "Degree Entry (% Baccalaureate)" = sum(Q30 == 3)/`Total Nurses`,
         "Degree Entry (% Master's)" = sum(Q30 == 4)/`Total Nurses`,
         "Degree Entry (% Doctorate)" = sum(Q30 == 5)/`Total Nurses`,
         "Highest Degree (% High School)" = sum(Q31 == 1)/`Total Nurses`,
         "Highest Degree (% Vocational Training)" = sum(Q31 == 2)/`Total Nurses`,
         "Highest Degree (% BS, BA)" = sum(Q31 == 3)/`Total Nurses`,
         "Highest Degree (% MS, MA)" = sum(Q31 == 4)/`Total Nurses`,
         "Highest Degree (% Clinical Doctorate)" = sum(Q31 == 5)/`Total Nurses`,
         "Highest Degree (% Research Doctorate)" = sum(Q31 == 6)/`Total Nurses`,
         "Part-Time (% Enrolled)" = sum(Q25 == 1)/`Total Nurses`,
         "Full-Time (% Enrolled)" = sum(Q25 == 2)/`Total Nurses`,
         "Certifications (% NP)" = sum(Q26 == 1)/`Total Nurses`,
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`) %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% View()

#######################
# Summer 2018
#######################

# Teaching Status

june2018[is.na(june2018)] <- 9

datajune2018 <- june2018 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(Q29 != 9) %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number)) %>% 
  ungroup() %>% 
  mutate(Q29 = case_when(Q29 == 1 ~ "Academic Medical Center",
                         Q29 == 2 ~ "Community Teaching Hospital",
                         Q29 == 3 ~ "Non-teaching Hospital",
                         Q29 == 4 ~ "Other"))

# Nurses

nurse_june2018 <- june2018 %>% 
  select(Hospital.Name, Q21, Q25, Q26, Q27, Q30, Q31)  %>%
  group_by(Hospital.Name) %>% 
  mutate("Total Nurses" = n()) %>% 
  filter(Q30 != -1) %>% 
  mutate("Female Nurses (%)" = sum(Q21==2)/`Total Nurses`,
         "Degree Entry (% Diploma)" = sum(Q30 == 1)/`Total Nurses`,
         "Degree Entry (% Associate's)" = sum(Q30 == 2)/`Total Nurses`,
         "Degree Entry (% Baccalaureate)" = sum(Q30 == 3)/`Total Nurses`,
         "Degree Entry (% Master's)" = sum(Q30 == 4)/`Total Nurses`,
         "Degree Entry (% Doctorate)" = sum(Q30 == 5)/`Total Nurses`,
         "Highest Degree (% High School)" = sum(Q31 == 1)/`Total Nurses`,
         "Highest Degree (% Vocational Training)" = sum(Q31 == 2)/`Total Nurses`,
         "Highest Degree (% BS, BA)" = sum(Q31 == 3)/`Total Nurses`,
         "Highest Degree (% MS, MA)" = sum(Q31 == 4)/`Total Nurses`,
         "Highest Degree (% Clinical Doctorate)" = sum(Q31 == 5)/`Total Nurses`,
         "Highest Degree (% Research Doctorate)" = sum(Q31 == 6)/`Total Nurses`,
         "Part-Time (% Enrolled)" = sum(Q25 == 1)/`Total Nurses`,
         "Full-Time (% Enrolled)" = sum(Q25 == 2)/`Total Nurses`,
         "Certifications (% NP)" = sum(Q26 == 1)/`Total Nurses`,
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`) %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% View()

#######################
# Fall 2018
#######################

# Teaching Status

fall2018[is.na(fall2018)] <- 9

datafall2018 <- fall2018 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(Q29 != 9, Q29 != 4) %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number)) %>% 
  ungroup() %>% 
  mutate(Q29 = case_when(Q29 == 1 ~ "Academic Medical Center",
                         Q29 == 2 ~ "Community Teaching Hospital",
                         Q29 == 3 ~ "Non-teaching Hospital",
                         Q29 == 4 ~ "Other"))

# Nurses

nurse_fall2018 <- fall2018 %>% 
  select(Hospital.Name, Q21, Q25, Q26, Q27, Q30, Q31)  %>%
  group_by(Hospital.Name) %>% 
  mutate("Total Nurses" = n()) %>% 
  filter(Q30 != -1) %>% 
  mutate("Female Nurses (%)" = sum(Q21==2)/`Total Nurses`,
         "Degree Entry (% Diploma)" = sum(Q30 == 1)/`Total Nurses`,
         "Degree Entry (% Associate's)" = sum(Q30 == 2)/`Total Nurses`,
         "Degree Entry (% Baccalaureate)" = sum(Q30 == 3)/`Total Nurses`,
         "Degree Entry (% Master's)" = sum(Q30 == 4)/`Total Nurses`,
         "Degree Entry (% Doctorate)" = sum(Q30 == 5)/`Total Nurses`,
         "Highest Degree (% High School)" = sum(Q31 == 1)/`Total Nurses`,
         "Highest Degree (% Vocational Training)" = sum(Q31 == 2)/`Total Nurses`,
         "Highest Degree (% BS, BA)" = sum(Q31 == 3)/`Total Nurses`,
         "Highest Degree (% MS, MA)" = sum(Q31 == 4)/`Total Nurses`,
         "Highest Degree (% Clinical Doctorate)" = sum(Q31 == 5)/`Total Nurses`,
         "Highest Degree (% Research Doctorate)" = sum(Q31 == 6)/`Total Nurses`,
         "Part-Time (% Enrolled)" = sum(Q25 == 1)/`Total Nurses`,
         "Full-Time (% Enrolled)" = sum(Q25 == 2)/`Total Nurses`,
         "Certifications (% NP)" = sum(Q26 == 1)/`Total Nurses`,
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`) %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct()
  
  


