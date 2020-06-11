```{r educational_efforts_dataframe, fig.asp = .2, fig.width = 14, out.width = "85%"}
cols <- c("Poor" = "#474C4F",
          "Fair" = "#AE6180",
          "Good" = "#A3A9AC",
          "Very Good" = "#FFC842",
          "Excellent" = "#6BAB8A")

educational_efforts_dataframe <- giap %>%
  select(Hospital.Name, CASEID, Q17) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Poor",
                              Response == 2 ~ "Fair",
                              Response == 3 ~ "Good",
                              Response == 4 ~ "Very Good",
                              Response == 5 ~ "Excellent"),
         Response = ordered(Response, levels = rev(names(cols))),
         Item = case_when(Item == "Q17" ~ "Job your institution has done educating staff about the care of the older adult")) %>% 
  count(Item, Response) %>%
  mutate(Item = wrap_30(Item),
         Label =  ifelse(n/sum(n)<0.074, NA, paste0(as.character(round(n/sum(n)*100, 1)), "%")))

educational_efforts_dataframe %>% 
  ggplot(aes(x = Item, y = n/sum(n), fill = Response, label = Label)) +
  geom_bar(stat = "identity", width = .5, color = "white") +
  scale_y_continuous(labels = percent_format(),
                     breaks = cumsum(rev(eduactional_efforts_dataframe$n))/sum(eduactional_efforts_dataframe$n)) +
  geom_text(position = position_stack(vjust = 0.5), 
            color = c("white", "white", "black", "black", "black"),
            size = 5) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", 
        text = element_text(size = 20, color = "black"), 
        panel.border = element_blank(),
        axis.text.x = element_text(color="#993333", 
                                   size=14, angle=45))
```