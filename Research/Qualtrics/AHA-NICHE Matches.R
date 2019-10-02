pacman::p_load(tidyverse, dplyr, ggplot2, VIM, readxl, stringdist)

aha_data <- read_excel("RAW AHA Dataset_2019.xlsx", skip = 5)
coord_data <- read_csv("Qualtrics/Coordinator Survey_Raw Data.csv")

coord_data <- coord_data[-c(1,2),]

nas <- c('na', 'n/a', 'NA', 'N/A', 'N/a', 'no', 'none', 'NO', 'NONE', '<NA>')
yes_no <- c("Yes", "No")

useful_data <- function(entry){
  
  len <- ifelse(is.na(entry), 0, nchar(entry))
  is_number <- !is.na(as.numeric(entry))
  is_upper <- entry == toupper(entry)
  is_repeated <- grepl("([a-z])\\1{2,}", entry, perl = T) | grepl("([A-Z])\\1{3,}", entry, perl = T)
  is_na <- entry %in% nas | is.na(entry)
  is_yes_no <- entry %in% yes_no
  
  if(!is_repeated & (len >= 3 | is_yes_no | is_upper | is_number) & !is_na){
    return(entry)
  } else{
    return(NA) 
  }
  
}

coord_data <- coord_data %>% 
  rowwise() %>% 
  mutate_at(vars(colnames(coord_data)[18:ncol(coord_data)]), useful_data)

coord_data$na_count <- apply(coord_data, 1, function(x) sum(is.na(x)))

# We have now removed the non-sensical values from the dataframe and converted them to NAs

############################

aha_names <- unique(aha_data$`Hospital Name`)
coord_names <- unique(coord_data$Q3)

aha_names <- as.data.frame(aha_names)
coord_names <- as.data.frame(coord_names)
coord_names <- na.omit(coord_names)
coord_names$aha_names <- ""


for(i in 1:dim(coord_names)[1]) {
  x <- agrep(coord_names$coord_names[i], aha_names$aha_names, ignore.case=TRUE,
             value=TRUE, max.distance = 0.1, useBytes = TRUE)
  x <- paste0(x,"")   
  coord_names$aha_names[i] <- x 
  }

coord_names %>% View()

####################

aha_add <- unique(aha_data$`Address 1 (physical)`)
coord_add <- unique(coord_data$Q9_3)

aha_add <- as.data.frame(aha_add)
coord_add <- as.data.frame(coord_add)
coord_add <- na.omit(coord_add)
coord_add$aha_add <- ""


for(i in 1:dim(coord_add)[1]) {
  x <- agrep(coord_add$coord_add[i], aha_add$aha_add, ignore.case=TRUE,
             value=TRUE, max.distance = 0.01, useBytes = TRUE)
  x <- paste0(x,"")   
  coord_add$aha_add[i] <- x 
}

coord_add

######################

# Merged by Names

coord_names <- coord_names[-c(1, 5, 11, 16, 17, 28, 53, 90, 106, 120, 154, 158, 162, 169, 174, 179, 180, 196, 205, 206, 238),]
coord_names

merged_data <- merge(coord_data, coord_names, by.x=c("Q3"), by.y=c("coord_names"), all= F)

merged_data <- merged_data[merged_data$aha_names!="",]

merged_data <- merge(merged_data, aha_data, by.x = c("aha_names"), by.y=c("Hospital Name"), all = F)

merged_data_name <- merged_data %>% 
  rename("Hospital Name" = "aha_names")

#######################

# Merged by Address

#coord_add <- coord_add[-c(12, 37, 42),]
#coord_add

#merged_data <- merge(coord_data, coord_add, by.x=c("Q9_3"), by.y=c("coord_add"), all= F)

#merged_data <- merged_data[merged_data$aha_add!="",]

#merged_data <- merge(merged_data, aha_data, by.x = c("aha_add"), by.y=c("Address 1 (physical)"), all = F)

#merged_data_add <- merged_data %>% 
#  rename("Address 1 (physical)" = "aha_add")

########################

# Sanity Check

#col_name <- colnames(merged_data_name)

#for(i in 1:190){
#  if(col_name[i] %in% colnames(merged_data_add)==F){
#    print(col_name[i])
#  }
#}

#ncol(merged_data_add)

##########################

#merged_data <- rbind(merged_data_name, merged_data_add)

#merged_data <- merged_data[!duplicated(merged_data),]

##########################

merged_data <- merged_data_name %>% 
  select(na_count:`Registered Nurses FT (est.)`)

ggplotgui::ggplot_shiny(merged_data)

names(merged_data) <- make.names(colnames(merged_data))

##########################

# na_count vs licensed beds

ggplot(merged_data, aes(x = Licensed.Beds, y = na_count)) +
  geom_point() +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank()
  )


# na_count vs primary service

ggplot(merged_data, aes(x = Primary.Service, y = na_count)) +
  geom_point() +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank()
  )
