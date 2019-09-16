pacman::p_load(tidyverse, dplyr, ggplot2)

coord_data <- read_csv("Qualtrics/Coordinator Survey_Raw Data.csv")
mem_data <- read_csv("Qualtrics/Membership Renewal Survey_Raw Data.csv")

coord_data <- coord_data[-c(1,2),]
mem_data <- mem_data[-c(1,2),]

coord_data %>% View()

nas <- c('na', 'n/a', 'NA', 'N/A', 'N/a', 'no')

useful_data <- function(entry){
  
  len <- nchar(entry)
  xs <- grep("x{2,}", entry, perl = T, value = F)
  in_na <- entry %in% nas & is.na(entry)
  
  if(xs != 1 & len > 4 & !in_na){
    return(entry)
  } else{
    return(NA) 
  }

}

entry <- "fsdfsd"

coord_data %>% colnames()

coord_data <- coord_data %>% 
  mutate_at(vars("Q7_1"), useful_data)

View(coord_data)

useful_data("xdse")

le <- "gldsfs"
nchar("gldsfs")
