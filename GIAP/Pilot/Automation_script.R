library(pacman)
p_load(tidyverse, ggplot2, pander, knitr, scales, data.table, lubridate, readxl, kableExtra, rmarkdown, knitcitations)

giap <- read_excel("Complete Raw Data CMC.xlsx")
arost <- read_excel("Master List of Variables.xlsx", sheet = "Participating - full rosters")

giap <- giap %>% 
  mutate(StartDate = as_date(StartDate),
         EndDate = as_date(EndDate))

giap <- arost %>% 
  select(`Hospital ID`, `Hospital Name (Cleaned, Revised to Match)`) %>% 
  mutate(`Hospital ID` = round(as.numeric(`Hospital ID`),4)) %>% 
  unique() %>% 
  na.omit() %>% 
  left_join(giap %>% mutate(`Hospital ID` = round(as.numeric(`Hospital ID`),4)), ., by = "Hospital ID")

colnames(giap)[length(colnames(giap))]<-"Hospital.Name"
colnames(giap)[227:229] <- c("Hospital.ID", "Unit.ID", "Participant.ID")

# Anonymous Respondents

anon_resp <- giap %>% 
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

giap <- giap %>% 
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


hospital.names <- unique(giap$Hospital.Name) %>% na.omit()

knowledge <- read.csv("knowledge_answers.csv")
knowledge$select <- c(1,2)
knowledge <- knowledge %>% filter(select == 1) %>% select(-select)

knowledge$Code<- gsub(pattern = "-", replacement = "_", 
                      gsub(pattern = " ", replacement = "", 
                           gsub(pattern = " –", replacement = "", 
                                substr(knowledge$Question, 11,16))))

knowledge$Answers <- strsplit(as.character(knowledge$Answer), "/")

knowledge <- knowledge %>% select(Code, Type, Answers)


trim <- function (x) gsub("^\\s+|\\s+$", "", x)

response_to_num <- function(x){
  response <- c()
  for(i in 1:length(x)){
    x[i] <- trim(x[i])
    response[i] <- case_when(x[i] == "Strongly Disagree" ~ 0,
                             x[i] == "Disagree" ~ 1,
                             x[i] == "Neither Agree nor Disagree" ~ 2,
                             x[i] == "Agree" ~ 3,
                             x[i] == "Strongly Agree" ~ 4)
  }
  
  return(response)
}

for(i in 1:nrow(knowledge)){
  knowledge[[3]][[i]] <- response_to_num(knowledge[[3]][[i]]) %>% list()
}

check_score <- function(row){
  temp <- row %>% 
    t() %>% 
    data.frame() %>% 
    setNames("Response") %>% 
    mutate(Response = ifelse(is.na(Response), 10, Response),
           Code = rownames(.)) %>% 
    left_join(knowledge, by = ("Code")) %>% 
    setNames(c("Response", "Code", "Type", "Answers")) %>% 
    rowwise() %>% 
    mutate(Points = ifelse(Response %in% (Answers %>% unlist), 1, 0))
  
  return(sum(temp$Points)/length(temp$Points))
}

for(name in hospital.names){
  render("GIAP Individual Report.Rmd",
         output_file=paste0("C:/Users/tg1482/Desktop/GIAP/results/", name, ".html"))
}
