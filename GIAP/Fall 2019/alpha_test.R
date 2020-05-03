know <- c("Q42", "Q43", "Q44", "Q45", "Q46", "Q51", "Q47", "Q48", "Q49",
          "Q50", "Q58", "Q59", "Q52", "Q56", "Q53", "Q55", "Q54", "Q57", 
          "Q60", "Q61")

know_matrix <- matrix(, nrow(giap), length(know))
colnames(know_matrix) <- know

i <- 1
for(Q in know){
  know_matrix[,i] <- max.col(giap %>%
                               select(contains(Q)) %>% 
                               mutate_all(na_to_zero))
  i=i+1
}

alpha(know_matrix)
