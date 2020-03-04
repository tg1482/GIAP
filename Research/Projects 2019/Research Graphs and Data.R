#######################
# Tanmay Gupta
# Data Analyst - April 11, 2019
# Research Project - Mattia Gilmartin
#######################
# Loading Packages
library(pacman)
p_load(tidyverse, scales, ggplotgui, ggplot2, pander, knitr, xlsx, scales, readxl, kableExtra, rmarkdown, knitcitations, imputeTS, lubridate)
#######################
# Getting Data
#######################
# Fall 2017
#######################
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
  left_join(fall2017 %>% 
              mutate(`Hospital ID` = round(as.numeric(`Hospital ID`),4)), .,
            by = "Hospital ID")

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
####################
# Teaching Status
####################
datafall2017 <- fall2017 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(!is.na(Q29), Q29 != "Other") %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number)) %>% 
  select(-Number) %>% 
  aggregate(Q29~Hospital.Name, ., list)
####################
# Nurses
####################
nurse_fall2017 <- fall2017 %>% 
  select(Hospital.Name, Q21, Q25, Q26, Q27, Q30, Q31)  %>%
  group_by(Hospital.Name) %>% 
  mutate("Total Nurses" = n()) %>% 
  mutate("Female Nurses (%)" = sum(Q21=="Female", na.rm = T)/`Total Nurses`,
         "Degree Entry (% Diploma)" = sum(Q30 == "Diploma", na.rm = T)/`Total Nurses`,
         "Degree Entry (% Associate's)" = sum(Q30 == "Associate Degree", na.rm = T)/`Total Nurses`,
         "Degree Entry (% Baccalaureate)" = sum(Q30 == "Baccalaureate Degree", na.rm = T)/`Total Nurses`,
         "Degree Entry (% Master's)" = sum(Q30 == "Master Degree", na.rm = T)/`Total Nurses`,
         "Degree Entry (% Doctorate)" = sum(Q30 == "Doctorate", na.rm = T)/`Total Nurses`,
         "Highest Degree (% High School)" = sum(Q31 == "High School Diploma or GED Nursing Assistant", na.rm = T)/`Total Nurses`,
         "Highest Degree (% Vocational Training)" = sum(Q31 == "Vocational Training (LPN/LVN)", na.rm = T)/`Total Nurses`,
         "Highest Degree (% BS, BA)" = sum(Q31 == "BS, BA", na.rm = T)/`Total Nurses`,
         "Highest Degree (% MS, MA)" = sum(Q31 == "MS, MA", na.rm = T)/`Total Nurses`,
         "Highest Degree (% Clinical Doctorate)" = 0/`Total Nurses`,
         "Highest Degree (% Research Doctorate)" = sum(Q31 == "PhD, EdD,SciD,DNSc", na.rm = T)/`Total Nurses`,
         "Part-Time (% Enrolled)" = sum(Q25 == "Yes, Part-time", na.rm = T)/`Total Nurses`,
         "Full-Time (% Enrolled)" = sum(Q25 == "Yes, Full-time", na.rm = T)/`Total Nurses`,
         "Certifications (% NP)" = sum(Q26 == "Yes", na.rm = T)/`Total Nurses`,
         "Certifications (% Gerontological Nursing)" = sum(Q27 == "Yes", na.rm = T)/`Total Nurses`,
         "Cohort" = "Fall 2017") %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% 
  full_join(datafall2017, by = "Hospital.Name") %>% 
  rename("Hospital.Type" = "Q29")

#######################
# Feb 2018
#######################
####################
# Teaching Status
####################
feb2018[is.na(feb2018)] <- 9

datafeb2018 <- feb2018 %>% 
  select(Hospital.Name, Q29) %>% 
  filter(Q29 != 9, Q20 != 4) %>% 
  group_by(Hospital.Name, Q29) %>% 
  summarize(Number = n()) %>% 
  ungroup() %>% 
  group_by(Hospital.Name) %>% 
  filter(Number == max(Number)) %>% 
  ungroup() %>% 
  mutate(Q29 = case_when(Q29 == 1 ~ "Academic Medical Center",
                         Q29 == 2 ~ "Community Teaching Hospital",
                         Q29 == 3 ~ "Non-teaching Hospital",
                         Q29 == 4 ~ "Other")) %>% 
  select(-Number) %>% 
  aggregate(Q29~Hospital.Name, ., list)
####################
# Nurses
####################
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
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`,
         "Cohort" = "Feb 2018") %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% 
  full_join(datafeb2018, by = "Hospital.Name") %>% 
  rename("Hospital.Type" = "Q29")

#######################
# Summer 2018
#######################
####################
# Teaching Status
####################
june2018[is.na(june2018)] <- 9

datajune2018 <- june2018 %>% 
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
                         Q29 == 4 ~ "Other")) %>% 
  select(-Number) %>% 
  aggregate(Q29~Hospital.Name, ., list)
####################
# Nurses
####################
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
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`,
         "Cohort" = "June 2018") %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% 
  full_join(datajune2018, by = "Hospital.Name") %>% 
  rename("Hospital.Type" = "Q29")

#######################
# Fall 2018
#######################
####################
# Teaching Status
####################
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
                         Q29 == 4 ~ "Other")) %>% 
  select(-Number) %>% 
  aggregate(Q29~Hospital.Name, ., list)
####################
# Nurses
####################
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
         "Certifications (% Gerontological Nursing)" = sum(Q27 == 1)/`Total Nurses`,
         "Cohort" = "Oct 2018") %>% 
  select(-Q21, -Q25, -Q26, -Q27, -Q30, -Q31) %>% 
  distinct() %>% 
  full_join(datafall2018, by = "Hospital.Name") %>% 
  rename("Hospital.Type" = "Q29")

####################
# Merging All Data
####################
research_data <- rbind(nurse_fall2017, nurse_feb2018, nurse_june2018, nurse_fall2018)
####################
## Graph 1
####################
research_data %>% 
  group_by(Cohort) %>% 
  summarize(Hospitals = n()) %>% 
  ggplot(aes(x = Cohort, y = Hospitals)) +
  geom_bar(stat='identity', fill = "sky blue", col = "sky blue") +
  scale_y_discrete() +
  geom_text(aes(label=Hospitals),
            vjust=1.5,
            position=position_dodge(width=0.9),
            show.legend=F,
            color="maroon") +
  labs(y = "", x = "") +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
    )
####################
## Graph 2
####################
research_data %>% 
  group_by(Cohort) %>% 
  summarize(Hospitals = n()) %>% 
  ggplot(aes(x="", y=Hospitals, fill=Cohort)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  #scale_fill_manual(values=c("#AE6180", "#A3A9AC", "#FFC842", "#6BAB8A")) +
  scale_fill_brewer(palette="Blues") +
  theme(axis.text.x=element_blank()) +
  geom_text(aes(label=Hospitals),
            show.legend=F,
            color="maroon")+
  theme_minimal()
#################### 
## Graph 3 - Final
####################
research_data %>% 
  group_by(Cohort) %>% 
  summarize(Hospitals = n()) %>%
  ggplot(aes("", Hospitals, fill = Cohort)) +
  geom_bar(width = 1, size = 1, color = "white", stat = "identity") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(Hospitals))), 
            position = position_stack(vjust = 0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) +
  guides(fill = guide_legend(reverse = TRUE)) +
  scale_fill_manual(values = c("#AE6180", "#A3A9AC", "#FFC842", "#6BAB8A")) +
  theme_classic() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, color = "#666666"))
####################
## Graph 4 - Final
####################
research_data %>% 
  group_by(Cohort) %>% 
  summarize("High School" = mean(`Highest Degree (% High School)`),
            "Vocational Training" = mean(`Highest Degree (% Vocational Training)`),
            "BS, BA" = mean(`Highest Degree (% BS, BA)`),
            "MS, MA" = mean(`Highest Degree (% MS, MA)`),
            "Clinical Doctorate" = mean(`Highest Degree (% Clinical Doctorate)`),
            "Research Doctorate" = mean(`Highest Degree (% Research Doctorate)`)) %>% 
  gather(key = "Degree", value = "Percent", -Cohort) %>% 
  mutate(Degree = factor(Degree, levels = c("BS, BA", "High School", "Vocational Training", "MS, MA", "Clinical Doctorate", "Research Doctorate"),
                         labels = c("BS, BA","High School", "Vocational", "MS, MA", "Clinical", "Research")),
         Cohort = factor(Cohort, levels = c("Fall 2017", "Feb 2018", "June 2018", "Oct 2018"),
                         labels = c("Fall 2017", "Feb 2018", "June 2018", "Oct 2018"))) %>% 
  arrange(desc(Percent)) %>% 
  ggplot(aes(x = Cohort, y = Percent)) +
  geom_point() +
  facet_grid( . ~ Degree, scales = "fixed") +
  labs(x = ' ', y = 'Percent') +
  scale_y_continuous(labels = scales::percent) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
    panel.grid.major = element_blank()
  )
  

#####################
## Knowledge Data Processing for Graph
#####################

## Fall 2017

#####################
# Falls
#####################

Falls <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_7, Q5_8, Q5_14, Q5_21, Q5_24, Q5_25, Q5_26, Q5_33, Q20_31, Q20_32) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q5_21") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q5_21") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q5_21") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q5_21") & Response == "Agree" ~ 0,
                                  Item %in% c("Q5_21") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_7" ~ "Bed alarms",
                          Item == "Q5_8" ~ "Chair alarms",
                          Item == "Q5_14" ~ "Anti-slip socks",
                          Item == "Q5_21" ~ "Sitters",
                          Item == "Q5_24" ~ "Adjustable low height beds",
                          Item == "Q5_25" ~ "Hourly rounding",
                          Item == "Q5_26" ~ "Toileting schedule",
                          Item == "Q5_33" ~ "Sensory perception aids",
                          Item == "Q20_31" ~ "Assess fall risk",
                          Item == "Q20_32" ~ "Assess fear of falling")) %>%
  group_by(Hospital.ID) %>%
  mutate(Falls_H = mean(Response_Num))

Falls_all <- Falls %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(4*10)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Falls")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Falls")

#####################
# Restraints
#####################

Restraints <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_1, Q20_40, Q20_42, Q20_48) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q5_1","Q20_40") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q5_1","Q20_40") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q5_1","Q20_40") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q5_1","Q20_40") & Response == "Agree" ~ 0,
                                  Item %in% c("Q5_1","Q20_40") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_1" ~ "Mechanical restraints",
                          Item == "Q20_40" ~ "Confused patients are safer when restrained",
                          Item == "Q20_42" ~ "Alternatives to restraints",
                          Item == "Q20_48" ~ "Nerve injuries")) %>%
  group_by(Hospital.ID) %>%
  mutate(Restraints_H = mean(Response_Num))

Restraints_all <- Restraints %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(4*4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Restraints")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Restraints") %>% 
  rbind(kg_score_fall17,.)

#####################
# Skin
#####################

Skin <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_6, Q20_37, Q20_38, Q20_43, Q20_44, Q20_46, Q20_47) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q20_46") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q20_46") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q20_46") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q20_46") & Response == "Agree" ~ 0,
                                  Item %in% c("Q20_46") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_6" ~ "PI prevention treatments",
                          Item == "Q20_37" ~ "Heels",
                          Item == "Q20_38" ~ "PI and osteomyelitis",
                          Item == "Q20_43" ~ "Assess PI",
                          Item == "Q20_44" ~ "Most PIs are preventable",
                          Item == "Q20_46" ~ "Massaging bony prominences",
                          Item == "Q20_47" ~ "Daily skin assessments")) %>%
  group_by(Hospital.ID) %>%
  mutate(Skin_H = mean(Response_Num)) 

Skin_all <- Skin %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(7*4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Skin")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Skin") %>% 
  rbind(kg_score_fall17,.)

#####################
# Incontinence
#####################

Incontinence <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_3, Q5_4, Q5_5, Q20_7, Q20_8, Q20_9, Q20_12, Q20_13, Q20_14) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q20_7","Q20_8", "Q20_14") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q20_7","Q20_8", "Q20_14") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q20_7","Q20_8", "Q20_14") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q20_7","Q20_8", "Q20_14") & Response == "Agree" ~ 0,
                                  Item %in% c("Q20_7","Q20_8", "Q20_14") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_3" ~ "Incontinence pads",
                          Item == "Q5_4" ~ "Adult diapers",
                          Item == "Q5_5" ~ "Urinary catheters",
                          Item == "Q20_7" ~ "Incontinence is normal in aging",
                          Item == "Q20_8" ~ "Kegels",
                          Item == "Q20_9" ~ "Assess incontinence",
                          Item == "Q20_12" ~ "Constipation",
                          Item == "Q20_13" ~ "Avoiding indwelling catheters",
                          Item == "Q20_14" ~ "Diapers at night")) %>%
  group_by(Hospital.ID) %>%
  mutate(Incontinence_H = mean(Response_Num))

Incontinence_all <- Incontinence %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(9*4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Incontinence")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Incontinence") %>% 
  rbind(kg_score_fall17,.)

#####################
# Pain
#####################

Pain <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_9, Q5_23, Q20_15, Q20_17, Q20_18) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q20_15") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q20_15") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q20_15") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q20_15") & Response == "Agree" ~ 0,
                                  Item %in% c("Q20_15") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_9" ~ "Pain medications",
                          Item == "Q5_23" ~ "Tricyclic antidepressants for neuropathic pain",
                          Item == "Q20_15" ~ "Pain is normal in aging",
                          Item == "Q20_17" ~ "Safe and effective treatment",
                          Item == "Q20_18" ~ "Assess pain")) %>%
  group_by(Hospital.ID) %>%
  mutate(Pain_H = mean(Response_Num))

Pain_all <- Pain %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(4*5)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Pain")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Pain") %>% 
  rbind(kg_score_fall17,.)

#####################
# Delirium
#####################

Delirium <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q20_19, Q20_20, Q20_52, Q20_55, Q20_58) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  filter(!is.na(Response)) %>%
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q20_19", "Q20_52") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q20_19", "Q20_52") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q20_19", "Q20_52") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q20_19", "Q20_52") & Response == "Agree" ~ 0,
                                  Item %in% c("Q20_19", "Q20_52") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q20_19" ~ "Delirium is normal in aging",
                          Item == "Q20_20" ~ "Assess delirium",
                          Item == "Q20_52" ~ "Hyperactive delirium poor prognosis",
                          Item == "Q20_55" ~ "Acute mental status change\ncommon sign of acute illness",
                          Item == "Q20_58" ~ "Screen for delirium")) %>%
  group_by(Hospital.ID) %>%
  mutate(Delirium_H = mean(Response_Num))

Delirium_all <- Delirium %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(4*5)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Delirium")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Delirium") %>% 
  rbind(kg_score_fall17,.)

#####################
# Dementia
#####################

Dementia <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_20, Q20_22, Q20_26, Q20_29) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q20_22") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q20_22") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q20_22") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q20_22") & Response == "Agree" ~ 0,
                                  Item %in% c("Q20_22") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_20" ~ "Tactile and auditory stimulation",
                          Item == "Q20_22" ~ "Dementia and depression",
                          Item == "Q20_26" ~ "Assess behavioral symptoms",
                          Item == "Q20_29" ~ "Non-pharmacologic treatments")) %>%
  group_by(Hospital.ID) %>%
  mutate(Dementia_H = mean(Response_Num))

Dementia_all <- Dementia %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(4*4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Dementia")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Dementia") %>% 
  rbind(kg_score_fall17,.)

#####################
## Nutrition
#####################

Nutrition <- fall2017 %>%
  filter(!is.na(Hospital.ID)) %>%
  select(Hospital.ID, Unit.ID, ResponseId, 
         Q5_11, Q5_13, Q5_19, Q20_33, Q20_51) %>%
  gather(Item, Response, -Hospital.ID, -Unit.ID, -ResponseId) %>% 
  mutate(Response = case_when(Response %in% c("1. Strongly Disgree","1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")),
         Response_Num = case_when(Item %in% c("Q5_13", "Q20_51") & Response == "Strongly Disagree" ~ 4,
                                  Item %in% c("Q5_13", "Q20_51") & Response == "Disagree" ~ 3,
                                  Item %in% c("Q5_13", "Q20_51") & Response == "Neither Agree nor Disagree" ~ 0,
                                  Item %in% c("Q5_13", "Q20_51") & Response == "Agree" ~ 0,
                                  Item %in% c("Q5_13", "Q20_51") & Response == "Strongly Agree" ~ 0,
                                  Response == "Strongly Disagree" ~ 0,
                                  Response == "Disagree" ~ 0,
                                  Response == "Neither Agree nor Disagree" ~ 0,
                                  Response == "Agree" ~ 3,
                                  Response == "Strongly Agree" ~ 4,
                                  is.na(Response) ~ 0),
         Item = case_when(Item == "Q5_11" ~ "Oral/Mouth care",
                          Item == "Q5_13" ~ "Tube and enteral feedings",
                          Item == "Q5_19" ~ "Hand over hand feeding",
                          Item == "Q20_33" ~ "Assess nutritional status",
                          Item == "Q20_51" ~ "Skin turgor and hydration")) %>%
  group_by(Hospital.ID) %>%
  mutate(Nutrition_H = mean(Response_Num))

Nutrition_all <- Nutrition %>%
  group_by(Hospital.ID, ResponseId) %>%
  summarize(Score = sum(Response_Num)/(5*4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>% 
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Nutrition")

kg_score_fall17 <- mean_temp %>% 
  mutate("Category" = "Nutrition") %>% 
  rbind(kg_score_fall17,.)


#####################

## Feb 2018

#####################
# Falls
#####################

Falls <- feb2018 %>% 
  select(Hospital.Name, CASEID, Q20C_10, Q20C_11, Q20C_12) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Falls_H = mean(Score)/4) %>% 
  ungroup()

Falls_all <- Falls %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Falls")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Falls")

####################
#Restraints
####################

Restraints <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_24, Q20K_26, Q20K_31) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_24") & Response == 1 ~ 4,
                           Item %in% c("Q20K_24") & Response == 2 ~ 3,
                           Item %in% c("Q20K_24") & Response == 3 ~ 0,
                           Item %in% c("Q20K_24") & Response == 4 ~ 0,
                           Item %in% c("Q20K_24") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Restraints_H = mean(Score)) %>% 
  ungroup()

Restraints_all <- Restraints %>% 
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Restraints")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Restraints") %>% 
  rbind(kg_score_feb2018, .)

####################
# Skin
####################

Skin <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20C_17, Q20K_27, Q20K_30, Q20K_21, Q20K_22, Q20K_29) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_29") & Response == 1 ~ 4,
                           Item %in% c("Q20K_29") & Response == 2 ~ 3,
                           Item %in% c("Q20K_29") & Response == 3 ~ 0,
                           Item %in% c("Q20K_29") & Response == 4 ~ 0,
                           Item %in% c("Q20K_29") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Skin_H = mean(Score)) %>% 
  ungroup()

Skin_all <- Skin %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*6)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Skin")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Skin") %>% 
  rbind(kg_score_feb2018, .)

####################
# Incontinence
####################

Incontinence <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_6, Q20K_7, Q20C_3, Q20K_10, Q20K_11, Q20K_12) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_7","Q20K_6", "Q20K_12") & Response == 1 ~ 4,
                           Item %in% c("Q20K_7","Q20K_6", "Q20K_12") & Response == 2 ~ 3,
                           Item %in% c("Q20K_7","Q20K_6", "Q20K_12") & Response == 3 ~ 0,
                           Item %in% c("Q20K_7","Q20K_6", "Q20K_12") & Response == 4 ~ 0,
                           Item %in% c("Q20K_7","Q20K_6", "Q20K_12") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Incontinence_H = mean(Score)) %>% 
  ungroup()

Incontinence_all <- Incontinence %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*6)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Incontinence")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Incontinence") %>% 
  rbind(kg_score_feb2018, .)

####################
# Pain
####################

Pain <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_13, Q20K_15, Q20C_1) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_13") & Response == 1 ~ 4,
                           Item %in% c("Q20K_13") & Response == 2 ~ 3,
                           Item %in% c("Q20K_13") & Response == 3 ~ 0,
                           Item %in% c("Q20K_13") & Response == 4 ~ 0,
                           Item %in% c("Q20K_13") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Pain_H = mean(Score)) %>% 
  ungroup()

Pain_all <- Pain %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Pain")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Pain") %>% 
  rbind(kg_score_feb2018, .)

####################
# Delirium
####################

Delirium <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_16, Q20C_2, Q20K_35, Q20K_38, Q20C_20) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_16", "Q20K_35") & Response == 1 ~ 4,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 2 ~ 3,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 3 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 4 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Delirium_H = mean(Score)) %>% 
  ungroup()

Delirium_all <- Delirium %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*5)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Delirium")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Delirium") %>% 
  rbind(kg_score_feb2018, .)

####################
# Dementia
####################

Dementia <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_18, Q20C_7, Q20C_9) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_18") & Response == 1 ~ 4,
                           Item %in% c("Q20K_18") & Response == 2 ~ 3,
                           Item %in% c("Q20K_18") & Response == 3 ~ 0,
                           Item %in% c("Q20K_18") & Response == 4 ~ 0,
                           Item %in% c("Q20K_18") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Dementia_H = mean(Score)) %>% 
  ungroup()

Dementia_all <- Dementia %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Dementia")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Dementia") %>% 
  rbind(kg_score_feb2018, .)

####################
# Nutrition
####################

Nutrition <- feb2018 %>%
  select(Hospital.Name, CASEID, 
         Q20C_13, Q20K_34) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_34") & Response == 1 ~ 4,
                           Item %in% c("Q20K_34") & Response == 2 ~ 3,
                           Item %in% c("Q20K_34") & Response == 3 ~ 0,
                           Item %in% c("Q20K_34") & Response == 4 ~ 0,
                           Item %in% c("Q20K_34") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Nutrition_H = mean(Score)) %>% 
  ungroup()

Nutrition_all <- Nutrition %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*2)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Nutrition")

kg_score_feb2018 <- mean_temp %>% 
  mutate("Category" = "Nutrition") %>% 
  rbind(kg_score_feb2018, .)

#####################

## June 2018

####################
# Restraints
####################

Restraints <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_24, Q20K_26, Q20K_31) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_24") & Response == 1 ~ 4,
                           Item %in% c("Q20K_24") & Response == 2 ~ 3,
                           Item %in% c("Q20K_24") & Response == 3 ~ 0,
                           Item %in% c("Q20K_24") & Response == 4 ~ 0,
                           Item %in% c("Q20K_24") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Restraints_H = mean(Score)) %>% 
  ungroup()

Restraints_all <- Restraints %>% 
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Restraints")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Restraints")

####################
# Skin
####################

Skin <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_27, Q20K_30, Q20K_21, Q20K_22, Q20K_29) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_29") & Response == 1 ~ 4,
                           Item %in% c("Q20K_29") & Response == 2 ~ 3,
                           Item %in% c("Q20K_29") & Response == 3 ~ 0,
                           Item %in% c("Q20K_29") & Response == 4 ~ 0,
                           Item %in% c("Q20K_29") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Skin_H = mean(Score)) %>% 
  ungroup()

Skin_all <- Skin %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*5)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Skin")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Skin") %>% 
  rbind(kg_score_jun2018, .)

####################
# Incontinence
####################

Incontinence <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_6, Q20K_10, Q20K_12) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_6","Q20K_12") & Response == 1 ~ 4,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 2 ~ 3,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 3 ~ 0,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 4 ~ 0,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Incontinence_H = mean(Score)) %>% 
  ungroup()

Incontinence_all <- Incontinence %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Incontinence")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Incontinence") %>% 
  rbind(kg_score_jun2018, .)

####################
# Pain
####################

Pain <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_13, Q20K_15) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_13") & Response == 1 ~ 4,
                           Item %in% c("Q20K_13") & Response == 2 ~ 3,
                           Item %in% c("Q20K_13") & Response == 3 ~ 0,
                           Item %in% c("Q20K_13") & Response == 4 ~ 0,
                           Item %in% c("Q20K_13") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Pain_H = mean(Score)) %>% 
  ungroup()

Pain_all <- Pain %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*2)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Pain")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Pain") %>% 
  rbind(kg_score_jun2018, .)

####################
# Delirium
####################

Delirium <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_16, Q20K_35, Q20K_38) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_16", "Q20K_35") & Response == 1 ~ 4,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 2 ~ 3,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 3 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 4 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Delirium_H = mean(Score)) %>% 
  ungroup()

Delirium_all <- Delirium %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Delirium")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Delirium") %>% 
  rbind(kg_score_jun2018, .)

####################
# Dementia
####################

Dementia <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_18) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_18") & Response == 1 ~ 4,
                           Item %in% c("Q20K_18") & Response == 2 ~ 3,
                           Item %in% c("Q20K_18") & Response == 3 ~ 0,
                           Item %in% c("Q20K_18") & Response == 4 ~ 0,
                           Item %in% c("Q20K_18") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Dementia_H = mean(Score)) %>% 
  ungroup()

Dementia_all <- Dementia %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Dementia")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Dementia") %>% 
  rbind(kg_score_jun2018, .)

####################
# Nutrition
####################

Nutrition <- june2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_34) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_34") & Response == 1 ~ 4,
                           Item %in% c("Q20K_34") & Response == 2 ~ 3,
                           Item %in% c("Q20K_34") & Response == 3 ~ 0,
                           Item %in% c("Q20K_34") & Response == 4 ~ 0,
                           Item %in% c("Q20K_34") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Nutrition_H = mean(Score)) %>% 
  ungroup()

Nutrition_all <- Nutrition %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Nutrition")

kg_score_jun2018 <- mean_temp %>% 
  mutate("Category" = "Nutrition") %>% 
  rbind(kg_score_jun2018, .)

#####################
## Fall 2018
fall2018 <- fall2018 %>% mutate(CASEID = 1:nrow(fall2018))
####################
#Restraints
####################

Restraints <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_24, Q20K_26, Q20K_31) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_24") & Response == 1 ~ 4,
                           Item %in% c("Q20K_24") & Response == 2 ~ 3,
                           Item %in% c("Q20K_24") & Response == 3 ~ 0,
                           Item %in% c("Q20K_24") & Response == 4 ~ 0,
                           Item %in% c("Q20K_24") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Restraints_H = mean(Score)) %>% 
  ungroup()

Restraints_all <- Restraints %>% 
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Restraints")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Restraints")

####################
# Skin
####################

Skin <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_27, Q20K_30, Q20K_21, Q20K_22, Q20K_29) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_29") & Response == 1 ~ 4,
                           Item %in% c("Q20K_29") & Response == 2 ~ 3,
                           Item %in% c("Q20K_29") & Response == 3 ~ 0,
                           Item %in% c("Q20K_29") & Response == 4 ~ 0,
                           Item %in% c("Q20K_29") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Skin_H = mean(Score)) %>% 
  ungroup()

Skin_all <- Skin %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*5)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Skin")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Skin") %>% 
  rbind(kg_score_fall18, .)

####################
# Incontinence
####################

Incontinence <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_6, Q20K_10, Q20K_12) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_6","Q20K_12") & Response == 1 ~ 4,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 2 ~ 3,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 3 ~ 0,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 4 ~ 0,
                           Item %in% c("Q20K_6","Q20K_12") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Incontinence_H = mean(Score)) %>% 
  ungroup()

Incontinence_all <- Incontinence %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Incontinence")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Incontinence") %>% 
  rbind(kg_score_fall18, .)

####################
# Pain
####################

Pain <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_13, Q20K_15) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_13") & Response == 1 ~ 4,
                           Item %in% c("Q20K_13") & Response == 2 ~ 3,
                           Item %in% c("Q20K_13") & Response == 3 ~ 0,
                           Item %in% c("Q20K_13") & Response == 4 ~ 0,
                           Item %in% c("Q20K_13") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Pain_H = mean(Score)) %>% 
  ungroup()

Pain_all <- Pain %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*2)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Pain")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Pain") %>% 
  rbind(kg_score_fall18, .)

####################
# Delirium
####################

Delirium <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_16, Q20K_35, Q20K_38) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_16", "Q20K_35") & Response == 1 ~ 4,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 2 ~ 3,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 3 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 4 ~ 0,
                           Item %in% c("Q20K_16", "Q20K_35") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Delirium_H = mean(Score)) %>% 
  ungroup()

Delirium_all <- Delirium %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4*3)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Delirium")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Delirium") %>% 
  rbind(kg_score_fall18, .)

####################
# Dementia
####################

Dementia <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_18) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_18") & Response == 1 ~ 4,
                           Item %in% c("Q20K_18") & Response == 2 ~ 3,
                           Item %in% c("Q20K_18") & Response == 3 ~ 0,
                           Item %in% c("Q20K_18") & Response == 4 ~ 0,
                           Item %in% c("Q20K_18") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Dementia_H = mean(Score)) %>% 
  ungroup()

Dementia_all <- Dementia %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Dementia")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Dementia") %>% 
  rbind(kg_score_fall18, .)

####################
# Nutrition
####################

Nutrition <- fall2018 %>%
  select(Hospital.Name, CASEID, 
         Q20K_34) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  mutate(Score = case_when(Item %in% c("Q20K_34") & Response == 1 ~ 4,
                           Item %in% c("Q20K_34") & Response == 2 ~ 3,
                           Item %in% c("Q20K_34") & Response == 3 ~ 0,
                           Item %in% c("Q20K_34") & Response == 4 ~ 0,
                           Item %in% c("Q20K_34") & Response == 5 ~ 0,
                           Response == 1 ~ 0,
                           Response == 2 ~ 0,
                           Response == 3 ~ 0,
                           Response == 4 ~ 3,
                           Response == 5 ~ 4,
                           Response == 9 ~ 0,
                           is.na(Response) ~ 0)) %>%
  group_by(Hospital.Name) %>%
  mutate(Nutrition_H = mean(Score)) %>% 
  ungroup()

Nutrition_all <- Nutrition %>%
  group_by(CASEID) %>% 
  summarize(Score = sum(Score)/(4)) %>% 
  mutate(Grade = case_when(Score < .50 ~ "Poor",
                           Score >= .50 & Score < .70 ~ "Fair",
                           Score >= .70 & Score < .90 ~ "Good",
                           Score >= .90 ~ "Very Good"),
         Grade = ordered(Grade, levels = c("Poor","Fair","Good","Very Good"))) %>% 
  ungroup() %>%
  {. ->> mean_temp} %>% 
  count(Grade) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Question = "Nutrition")

kg_score_fall18 <- mean_temp %>% 
  mutate("Category" = "Nutrition") %>% 
  rbind(kg_score_fall18, .)

#####################
## Data Manipulation
####################
kg_score_fall17 <- kg_score_fall17 %>% 
  mutate("Cohort" = "Fall 2017")

kg_score_feb2018 <- kg_score_feb2018 %>% 
  mutate("Cohort" = "Feb 2018")

kg_score_jun2018 <- kg_score_jun2018 %>% 
  mutate("Cohort" = "Jun 2018")

kg_score_fall18 <- kg_score_fall18 %>% 
  mutate("Cohort" = "Fall 2018")

kg_score <- kg_score_fall17 %>% 
  select(-ResponseId) %>% 
  rename("CASEID" = "Hospital.ID") %>% 
  rbind(kg_score_feb2018, kg_score_jun2018, kg_score_fall18)

kg_score <- kg_score %>% 
  mutate(Category = as.factor(Category),
         Cohort = factor(Cohort, levels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018"),
                         labels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018")))

#####################
# Graph - 5 (Knowledge)
####################
kg_score %>% 
  ggplot(aes(x = Cohort, y = Score, colour = Category)) +
  geom_violin(adjust = 1.2) +
  geom_point(stat = 'summary', fun.y = 'mean') +
  facet_grid( Category ~ . ) +
  theme_bw() +
  scale_y_continuous(breaks = c(0.33, 0.66, 1)) +
  theme(
    legend.position = 'none',
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

####################
# Graph - 5.1 (Knowledge)
####################
cols <- c("Poor" = "#AE6180", 
          "Fair" = "#A3A9AC", 
          "Good" = "#FFC842", 
          "Very Good" = "#6BAB8A")

question_levels <- c("Falls", "Delirium", "Dementia", "Incontinence", "Nutrition", "Pain", "Restraints", "Skin")

kg_score %>% 
  group_by(Category) %>% 
  count(Grade) %>%
  ungroup() %>% 
  mutate(Percent = round(n / sum(n) * 100),
         Category = ordered(Category, levels = rev(question_levels)),
         Grade = ordered(Grade, levels = rev(c("Poor","Fair","Good","Very Good")))) %>%
  ggplot(aes(x = Category, y = Percent/100, fill = Grade)) +
  geom_bar(position = "fill", stat = "identity", width = 0.05 * 11, color = "white") +
#  geom_point(aes(x=Category, y=Mean), shape = 8, size = 1, show.legend = FALSE, stroke = 0.3) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  theme_minimal() +
  theme(legend.position = "right", 
        axis.text.x = element_text(size = 9),
        axis.text.y = element_text(size = 9)) +
  coord_flip()
####################
#
####################

####################
## Organizational Values
####################
## Fall 2017
####################
wrap_30 <- wrap_format(30)
cols <- c("Strongly Disagree" = "#474C4F",
          "Disagree" = "#AE6180",
          "Neither Agree nor Disagree" = "#A3A9AC", 
          "Agree" = "#FFC842", 
          "Strongly Agree" = "#6BAB8A")

org_fall2017 <- fall2017 %>%
  select(Q8_1, Q8_2, Q8_4, Q8_5, Q8_8, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response)) %>%
  mutate(Response = case_when(Response %in% c("1. Strongly disagree","1. Strongly Disagree") ~ "Strongly Disagree",
                              Response %in% c("2. Disagree") ~ "Disagree",
                              Response %in% c("3. Neither Agree nor Disagree","3. Neither agree nor disagree","3. Neither Agree or Disagree") ~ "Neither Agree nor Disagree",
                              Response %in% c("4. Agree") ~ "Agree",
                              Response %in% c("5. Strongly Agree","5. Strongly agree") ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")))) %>%
  mutate(Item = wrap_30(Item))

code <- c("Q8_1", "Q8_2", "Q8_4", "Q8_5", "Q8_8", "Q8_11", "Q8_12")
questions_2017 <- c("Lack of knowledge about care of older adults", 
                    "Lack of (or inadequate) written policies and procedures specific to the older adult population",
                    "Lack of specialized equipment (eg: raised toilet seats, bed alarms, mattresses or beds)",
                    "Lack of specialized services for the older adult", 
                    "Pressures to limit treatment based on insurance reimbursement", 
                    "Communication difficulties with older adults and their families",
                    "Confusion over who is the appropriate decision maker for the older adult")
legend <- data.frame(Code = code, Question = questions_2017)
legend %>% pander()
####################
## Feb 2018
####################

org_feb2018 <- feb2018 %>%
  select(Q8_1, Q8_2, Q8_4, Q8_5, Q8_8, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")))) %>%
  mutate(Item = wrap_30(Item))

####################
## June 2018
####################

org_june2018 <- june2018 %>%
  select(Q8_1, Q8_2, Q8_4, Q8_5, Q8_8, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")))) %>%
  mutate(Item = wrap_30(Item))

####################
## Fall 2018
####################

org_fall2018 <- fall2018 %>%
  select(Q8_1, Q8_2, Q8_4, Q8_5, Q8_8, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree")))) %>%
  mutate(Item = wrap_30(Item))

####################
## Data Manipulation
####################

org_fall2017 <- org_fall2017 %>% 
  mutate("Cohort" = "Fall 2017")

org_feb2018 <- org_feb2018 %>% 
  mutate("Cohort" = "Feb 2018")

org_june2018 <- org_june2018 %>% 
  mutate("Cohort" = "Jun 2018")

org_fall2018 <- org_fall2018 %>% 
  mutate("Cohort" = "Fall 2018")

org_values <- org_fall2017 %>% 
  rbind(org_feb2018, org_june2018, org_fall2018)

org_values <- org_values %>% 
  mutate(Item = factor(Item, levels = rev(c("Q8_1", "Q8_2", "Q8_4", "Q8_5", "Q8_8", "Q8_11", "Q8_12"))),
         Cohort = factor(Cohort, levels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018"),
                         labels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018")))


####################
# Graph 6 - Organizational Values
####################

org_values %>% 
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .5) +
  scale_y_continuous(labels = percent_format(), breaks = c(0.25, 0.75)) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank()) +
  coord_flip() +
  theme_bw() 

####################
## Job Satifaction
####################

####################
## Fall 2017
####################
cols <- c("Disagree" = "#AE6180",
          "Neither agree nor disagree" = "#A3A9AC", 
          "Agree" = "#FFC842", 
          "Strongly agree" = "#6BAB8A")
graph_data_score_fall17 <- fall2017 %>%
  filter(!is.na(Q32)) %>%
  rename(`Response` = Q32) %>%
  count(`Response`) %>%
  mutate(Percent = round(n / sum(n), 2),
         Item = "I am satisfied with my current job",
         Response = case_when(Response == "Strongly disagree" ~ "Disagree",
                              Response == "Disagree" ~ "Disagree",
                              Response == "Neither agree nor disagree" ~ "Neither agree nor disagree",
                              Response == "Agree" ~ "Agree",
                              Response == "Strongly agree" ~ "Strongly agree"),
         Response_N = ordered(Response, levels = rev(c("Disagree",
                                                       "Neither agree nor disagree",
                                                       "Agree",
                                                       "Strongly agree"))),
         Score = case_when(Response_N == "Strongly disagree" ~ 1,
                           Response_N == "Disagree" ~ 2,
                           Response_N == "Neither agree nor disagree" ~ 3,
                           Response_N == "Agree" ~ 4,
                           Response_N == "Strongly agree" ~ 5),
         Score = Score*n)

satis_fall17 <- aggregate(n ~ Response_N, FUN = sum, graph_data_score_fall17) %>% 
  mutate(Item = "I am satisfied with my current job")

####################
## Feb 2018
####################
graph_data_score_feb18 <- feb2018 %>%
  filter(!is.na(Q32), Q32!=9) %>%
  rename(`Response` = Q32) %>%
  count(`Response`) %>%
  mutate(Percent = round(n / sum(n), 2),
         Item = "I am satisfied with my current job",
         Response_N = case_when(Response == 5 ~ "Disagree",
                                Response == 4 ~ "Disagree",
                                Response == 3 ~ "Neither agree nor disagree",
                                Response == 2 ~ "Agree",
                                Response == 1 ~ "Strongly agree"),
         Response_N = ordered(Response_N, levels = rev(c("Disagree",
                                                         "Neither agree nor disagree",
                                                         "Agree",
                                                         "Strongly agree"))),
         Score = case_when(Response == 5 ~ 1,
                           Response == 4 ~ 2,
                           Response == 3 ~ 3,
                           Response == 2 ~ 4,
                           Response == 1 ~ 5),
         Score = Score*n)

satis_feb18 <- aggregate(n ~ Response_N, FUN = sum, graph_data_score_feb18) %>% 
  mutate(Item = "I am satisfied with my current job")
####################
## June 2018
####################
graph_data_score_jun18 <- june2018 %>%
  filter(!is.na(Q32), Q32!=9) %>%
  rename(`Response` = Q32) %>%
  count(`Response`) %>%
  mutate(Percent = round(n / sum(n), 2),
         Item = "I am satisfied with my current job",
         Response_N = case_when(Response == 5 ~ "Disagree",
                                Response == 4 ~ "Disagree",
                                Response == 3 ~ "Neither agree nor disagree",
                                Response == 2 ~ "Agree",
                                Response == 1 ~ "Strongly agree"),
         Response_N = ordered(Response_N, levels = rev(c("Disagree",
                                                         "Neither agree nor disagree",
                                                         "Agree",
                                                         "Strongly agree"))),
         Score = case_when(Response == 5 ~ 1,
                           Response == 4 ~ 2,
                           Response == 3 ~ 3,
                           Response == 2 ~ 4,
                           Response == 1 ~ 5),
         Score = Score*n)

satis_jun18 <- aggregate(n ~ Response_N, FUN = sum, graph_data_score_jun18) %>% 
  mutate(Item = "I am satisfied with my current job")
####################
## Fall 2018
####################
graph_data_score_fall18 <- fall2018 %>%
  filter(!is.na(Q32), Q32!=9) %>%
  rename(`Response` = Q32) %>%
  count(`Response`) %>%
  mutate(Percent = round(n / sum(n), 2),
         Item = "I am satisfied with my current job",
         Response_N = case_when(Response == 5 ~ "Disagree",
                                Response == 4 ~ "Disagree",
                                Response == 3 ~ "Neither agree nor disagree",
                                Response == 2 ~ "Agree",
                                Response == 1 ~ "Strongly agree"),
         Response_N = ordered(Response_N, levels = rev(c("Disagree",
                                                         "Neither agree nor disagree",
                                                         "Agree",
                                                         "Strongly agree"))),
         Score = case_when(Response == 5 ~ 1,
                           Response == 4 ~ 2,
                           Response == 3 ~ 3,
                           Response == 2 ~ 4,
                           Response == 1 ~ 5),
         Score = Score*n)

satis_fall18 <- aggregate(n ~ Response_N, FUN = sum, graph_data_score_fall18) %>% 
  mutate(Item = "I am satisfied with my current job")
####################
## Data Manipulation
####################
satis_fall17 <- satis_fall17 %>% 
  mutate("Cohort" = "Fall 2017")

graph_data_score_fall17 <- graph_data_score_fall17 %>% 
  mutate("Cohort" = "Fall 2017")

satis_feb18 <- satis_feb18 %>% 
  mutate("Cohort" = "Feb 2018")

graph_data_score_feb18 <- graph_data_score_feb18 %>% 
  mutate("Cohort" = "Feb 2018")

satis_jun18 <- satis_jun18 %>% 
  mutate("Cohort" = "Jun 2018")

graph_data_score_jun18 <- graph_data_score_jun18 %>% 
  mutate("Cohort" = "Jun 2018")

satis_fall18 <- satis_fall18 %>% 
  mutate("Cohort" = "Fall 2018")

graph_data_score_fall18 <- graph_data_score_fall18 %>% 
  mutate("Cohort" = "Fall 2018")

satis_score <- satis_fall17 %>% 
  rbind(satis_feb18, satis_jun18, satis_fall18)

graph_data_score <- graph_data_score_fall17 %>% 
  rbind(graph_data_score_feb18, graph_data_score_jun18, graph_data_score_fall18) %>% 
  select(-Response)

satis_score <- satis_score %>% 
  mutate(Item = as.factor(Item),
         Cohort = factor(Cohort, levels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018"),
                         labels = c("Fall 2017", "Feb 2018", "Jun 2018", "Fall 2018")))

####################
# Graph - Job Satisfaction
####################
satis_score %>% 
  ggplot(aes(x = Cohort, y = n, fill = Response_N)) +
  geom_bar(position = "fill", stat = "identity", width = .8, color = "white") +
  geom_point(aes(x = Cohort, y = sum(Score)/(5*(sum(n)))),
             shape = 8, size = 1.5, 
             show.legend = FALSE, 
             stroke = 0.5, 
             data = graph_data_score) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  theme_minimal() +
  theme(legend.position = "right", 
        axis.ticks.y = element_blank(), 
        panel.border = element_blank(),
        panel.grid.minor = element_blank())

####################
####################
## Implementation Data
####################
####################

####################
## Data Collection
####################
imp2015 <- read_excel("Implementation.xlsx", sheet = "2015 Cohorts")
imp2016winter <- read_excel("Implementation.xlsx", sheet = "Winter 2016 Cohort")
imp2016summer <- read_excel("Implementation.xlsx", sheet = "Summer 2016 Cohort")
imp2016fall <- read_excel("Implementation.xlsx", sheet = "Fall 2016 Cohort")
imp2017winter <- read_excel("Implementation.xlsx", sheet = "Winter 2017 Cohort")

####################
## Data Manipulation - 2015
####################
manipulate <- names(imp2015)
manipulate <- manipulate[manipulate!="ID"]
imp2015 <- imp2015 %>% 
  mutate_at(manipulate, as.factor) %>% 
  mutate(ID = as.character(ID),
         `Implementation Level` = "None",
         Cohort = as.factor(c("2015")))

####################
## Data Manipulation - 2016 Winter
####################
manipulate <- names(imp2016winter)
manipulate <- manipulate[manipulate!="ID"]
imp2016winter <- imp2016winter %>% 
  mutate_at(manipulate, as.factor) %>% 
  mutate(ID = as.character(ID),
         Cohort = as.factor(c("2016 Winter")))

####################
## Data Manipulation - 2016 Summer
####################
manipulate <- names(imp2016summer)
manipulate <- manipulate[manipulate!="ID"]
imp2016summer <- imp2016summer %>% 
  mutate_at(manipulate, as.factor) %>% 
  mutate(ID = as.character(ID),
         Cohort = as.factor(c("2016 Summer")))

####################
## Data Manipulation - 2016 Fall
####################
manipulate <- names(imp2016fall)
manipulate <- manipulate[manipulate!="ID"]
imp2016fall <- imp2016fall %>% 
  mutate_at(manipulate, as.factor) %>% 
  mutate(ID = as.character(ID),
         Cohort = as.factor(c("2016 Fall")))

####################
## Data Manipulation - 2017 Winter
####################
manipulate <- names(imp2017winter)
manipulate <- manipulate[manipulate!="ID"]
imp2017winter <- imp2017winter %>% 
  mutate_at(manipulate, as.factor) %>% 
  mutate(ID = as.character(ID),
         Cohort = as.factor(c("2017 Winter")))

####################
## Graph
####################

cols <- c("Not met" = "#A3A9AC",
          "Partially met" = "#FFC842",
          "Met" = "#6BAB8A")

imp <- imp2015 %>% 
  rbind(imp2016summer, imp2016fall, imp2016winter, imp2017winter)

imp %>%
  select(-ID, -`Implementation Level`, -Cohort) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>% 
  mutate(Item = gsub("_", " ", Item),
         Response = case_when(Response == "M" ~ "Met",
                              Response == "PM" ~ "Partially met",
                              Response == "NM" ~ "Not met"),
         Response = ordered(Response, levels = rev(c("Not met", "Partially met", "Met")))) %>% 
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .5) +
  scale_y_continuous(labels = percent_format(), breaks = c(0.25, 0.75)) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank()) +
  coord_flip() +
  theme_minimal() 

####################
## Tables
####################

imp$Cohort %>% table() %>% pander()

####################
## Implementation Demographic Data
####################
# Fall 2016
####################

imp.demo.fall2016 <- read.csv("Implementation/NICHE Program Year 1 Implementation Survey - Fall 2016 Cohort.csv")
names(imp.demo.fall2016)[names(imp.demo.fall2016)=="Duration..in.seconds."]<-"Duration.Seconds"
columns <- names(imp.demo.fall2016)
questions <- imp.demo.fall2016[1,]
imp.demo.fall2016 <- imp.demo.fall2016[-c(1,2),]

####################
## Summer 2017
####################

imp.demo.summer2017 <- read.csv("Implementation/NICHE Program Year 1 Implementation Survey - Summer 2017 Cohort.csv")
names(imp.demo.summer2017)[names(imp.demo.summer2017)=="Duration..in.seconds."]<-"Duration.Seconds"
imp.demo.summer2017 <- imp.demo.summer2017[-c(1,2),]

####################
## Summer 2017
####################

imp.demo.winter2017 <- read.csv("Implementation/NICHE Program Year 1 Implementation Survey - Winter 2017 Cohort.csv")
names(imp.demo.winter2017)[names(imp.demo.winter2017)=="Duration..in.seconds."]<-"Duration.Seconds"
imp.demo.winter2017 <- imp.demo.winter2017[-c(1,2),]

####################
## Data Manipulation
####################
# Age
####################
imp.demo <- imp.demo.fall2016 %>% rbind(imp.demo.summer2017, imp.demo.winter2017)
rownames(imp.demo) <- 1:nrow(imp.demo)
imp.demo.graph1 <- imp.demo %>% 
  mutate(Q4C = as.numeric(as.character(Q4C)),
         Age=2019-Q4C) %>% 
  filter(Age<100)

imp.demo.graph1 %>% 
  ggplot(aes(x = Age)) +
  geom_histogram(position = 'identity', alpha = 0.8, binwidth = 2, fill = "light blue") +
  geom_vline(xintercept = mean(imp.demo.graph1$Age), color = "black", linetype = 2) +
  labs(y = "Count", title = "Distribution of Age with Mean") +
  theme_minimal()

####################
# Gender
####################
  
imp.demo$Q4A %>% 
  as.character() %>% 
  table() %>% 
  as.data.frame() %>% 
  rename("Gender" = ".", "Number" = "Freq") %>% 
  mutate(Percent = round(Number/sum(Number)*100,1)) %>% 
  pander()

####################
# Gender
####################
  
  
