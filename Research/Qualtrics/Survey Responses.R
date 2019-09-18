pacman::p_load(tidyverse, dplyr, ggplot2)

coord_data <- read_csv("Qualtrics/Coordinator Survey_Raw Data.csv")
mem_data <- read_csv("Qualtrics/Membership Renewal Survey_Raw Data.csv")

coord_data <- coord_data[-c(1,2),]
mem_data <- mem_data[-c(1,2),]

nas <- c('na', 'n/a', 'NA', 'N/A', 'N/a', 'no', 'none', 'NO', 'NONE')
yes_no <- c("Yes", "No")

useful_data <- function(entry){
  
  len <- ifelse(is.na(entry), 0, nchar(entry))
  is_upper <- entry == toupper(entry)
  is_repeated <- grepl("([a-z])\\1{2,}", entry, perl = T) | grepl("([A-Z])\\1{3,}", entry, perl = T)
  is_na <- entry %in% nas | is.na(entry)
  is_yes_no <- entry %in% yes_no
  
  if(!is_repeated & (len >= 3 | is_yes_no | is_upper) & !is_na){
    return(entry)
  } else{
    return(NA) 
  }

}

useful_data("zzz Hospital")

coord_data %>% 
  rowwise() %>% 
  mutate_at(vars(colnames(coord_data)[18:ncol(coord_data)]), useful_data) %>% 
  View()

