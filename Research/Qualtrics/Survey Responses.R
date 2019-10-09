pacman::p_load(tidyverse, dplyr, ggplot2, VIM)

coord_data <- read_csv("Qualtrics/Coordinator Survey_Raw Data.csv")
mem_data <- read_csv("Qualtrics/Membership Renewal Survey_Raw Data.csv")

coord_data <- coord_data[-c(1,2),]
mem_data <- mem_data[-c(1,2),]

nas <- c('na', 'n/a', 'NA', 'N/A', 'N/a', 'no', 'none', 'NO', 'NONE')
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

#####################
# Coordinator Data
#####################

coord_data <- coord_data %>% 
  rowwise() %>% 
  mutate_at(vars(colnames(coord_data)[18:ncol(coord_data)]), useful_data)

coord_data %>% 
  select_at(vars(colnames(coord_data)[18:ncol(coord_data)])) %>%
  select(-contains("TEXT")) %>% 
  aggr(., numbers = TRUE, prop = c(TRUE, FALSE))

coord_data$na_count <- apply(coord_data, 1, function(x) sum(is.na(x)))

coord_data %>% 
  mutate(Q6 = as.factor(Q6)) %>% 
  ggplot(aes(x = na_count)) + 
  geom_histogram() +
  geom_vline(aes(xintercept=mean(na_count)),
             color="blue", linetype="dashed", size=1)+
  facet_grid(Q6~.)

coord_data %>% 
  mutate(Q6 = as.factor(Q6)) %>% 
  ggplot(aes(y = na_count, x = Q6)) +
  geom_boxplot()
  
  
coord_data %>% 
  group_by(Q6) %>% 
  summarize(mean_ = mean(na_count),
            sd_ = sd(na_count),
            count_ = n())


#####################
# Membership Data
#####################

mem_data %>% View()

# The data seems clean enough to not use the useful_data function to clean
# the dataframe. Skipping that part, we will now see how the NAs are distributed
# across the dataframe

mem_data %>% 
  select_at(vars(colnames(mem_data)[18:ncol(mem_data)])) %>%
  select(-contains("TEXT")) %>% 
  aggr(., numbers = TRUE, prop = c(TRUE, FALSE))

# It appears that a good portion of the missing data comes from asking
# inconvenient questions such as providing the contact information of
# the Marketing teams and IT teams (information regular employees would
# have to look for). 

