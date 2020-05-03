

**This diagram depicts nurses' rating of organizational efforts to educate the workforce on the care of older adults.**
<center>
**Cohort Results**
</center>
```{r, fig.asp = .2, fig.width=14, out.width = "85%"}
wrap_15 <- wrap_format(15)
wrap_30 <- wrap_format(30)
cols <- c("Strongly Disagree" = "#474C4F",
          "Disagree" = "#AE6180", 
          "Neither Agree nor Disagree" = "#A3A9AC", 
          "Agree" = "#FFC842", 
          "Strongly Agree" = "#6BAB8A")
giap %>%
  select(Hospital.Name, CASEID, Q17) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q17" ~ "Job your institution has done educating staff about the care of the older adult")) %>% 
  count(Item, Response) %>%
  mutate(Item = wrap_30(Item)) %>% 
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .5, color = "white") +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", 
        text = element_text(size = 20, color = "black"), 
        panel.border = element_blank())
 
```
```{r, fig.width=7, fig.height= 5 , out.width = "75%"}
question <- "Job your institution has done educating staff about the care of the older adult"
# Cohort
cohort_data <- giap %>%
  filter(!is.na(Q17), Q17 != 9) %>%
  rename(`Response` = Q17) %>%
  {sum(.$Response==4 | .$Response == 5)/cohort_n}
# Hospital
hospital_data <- giap %>%
  filter(!is.na(Q17), Q17 != 9, Hospital.Name==name) %>%
  rename(`Response` = Q17) %>%
  {sum(.$Response==4 | .$Response == 5)/hospital_n}
df <- data.frame(matrix(nrow=2, ncol = 2))
names(df) <- c("variable", "percentage")
df$variable <- c("Cohort", name)
df$percentage <- round(c(cohort_data, hospital_data),2)
df <- df %>% mutate(group = ifelse(percentage <0.5, "red",
                                 ifelse(percentage>=0.5 & percentage<0.75, "yellow","green")),
                    label = paste0(percentage*100, "%"),
                    title = wrap_35(variable))
ggplot(df, aes(fill = group, ymax = percentage, ymin = 0, xmax = 2, xmin = 1)) +
  geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#faf9eb") +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + xlim(c(0, 2)) + ylim(c(0,2)) +
  geom_text(aes(x = 0, y = 0, label = label, colour=group), size=6.5) +
  geom_text(aes(x=1.5, y=1.5, label=title), size=4.2) + 
  facet_wrap(~title, ncol = 2) +
  theme_void() +
  scale_fill_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  scale_colour_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  theme(strip.background = element_blank(),
        strip.text.x = element_blank()) +
  guides(fill=FALSE) +
  guides(colour=FALSE)
```
<center>
**`r name` Results**
</center>
```{r, fig.asp = .2, fig.width=14, out.width = "85%"}
giap %>%
  filter(Hospital.Name == name) %>% 
  select(Hospital.Name, CASEID, Q17) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q17" ~ "Job your institution has done educating staff about the care of the older adult")) %>% 
  count(Item, Response) %>%
  mutate(Item = wrap_30(Item)) %>% 
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .5, color = "white") +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", 
        text = element_text(size = 20, color = "black"), 
        panel.border = element_blank())
```

**Practice Environment**
This section of the GIAP focuses on nurses' perceptions of the nursing unit to support age-friendly care. A practice environment that supports the unique care needs of older adults is characterized by: 1) the availability of specialized equipment and professional expertise; 2) holistic and person-centered care planning and care delivery processes; and 3) organizational values that support age-friendly care by taking older adults' unique needs into account in the design and delivery of care. This section concludes with nurses' assessment of the time and priority that managers, and other clinical leaders, place on implementing changes to improve the care of older adults on their unit. 

**Age-Friendly Care Planning and Patient-Centered Care**
  The following diagram illustrates nurses' perceptions regarding the organizational environment to provide nursing care tailored to the unique needs of older adults.

<center>
**Cohort Level**
</center>

```{r,fig.width=13, fig.asp=.4}
cols <- c("Strongly Disagree" = "#474C4F",
          "Disagree" = "#AE6180",
          "Neither Agree nor Disagree" = "#A3A9AC", 
          "Agree" = "#FFC842", 
          "Strongly Agree" = "#6BAB8A")
giap %>%
  select(Q7_1, Q7_2, Q7_5, Q7_7, Q7_11, Q7_13) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q7_1" ~ "Staff provide individualized, person-centered care",
                          Item == "Q7_2" ~ "Older adults get the care they need ",
                          Item == "Q7_5" ~ "Staff are familiar with how aging affects treatment responses",
                          Item == "Q7_7" ~ "Aging is considered as a factor when planning and evaluating care",
                          Item == "Q7_11" ~ "Staff receive information about the older adult's pre-hospitalization baseline",
                          Item == "Q7_13" ~ "There is continuity of care across settings")) %>%
  group_by(Item) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Percent = ifelse(Percent < 7, NA, paste0(Percent, '%'))) %>%
  ungroup() %>% 
  mutate(Item = wrap_30(Item)) %>%
  ggplot(aes(x = Item, y = n, fill = Response, label = Percent)) +
  geom_bar(position = "fill", stat = "identity", width = .6, color = "white") +
  geom_text(aes(colour = Response), size = 3.5, position = position_fill(vjust = 0.5)) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  scale_colour_manual(values=c("black","black","black","white","white"), guide = FALSE) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank(),
        axis.text.x=element_blank())
```
<center>
**`r name`**
</center>
```{r,fig.width=13, fig.asp=.4}
giap %>%
  filter(Hospital.Name==name) %>% 
  select(Q7_1, Q7_2, Q7_5, Q7_7, Q7_11, Q7_13) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q7_1" ~ "Staff provide individualized, person-centered care",
                          Item == "Q7_2" ~ "Older adults get the care they need ",
                          Item == "Q7_5" ~ "Staff are familiar with how aging affects treatment responses",
                          Item == "Q7_7" ~ "Aging is considered as a factor when planning and evaluating care",
                          Item == "Q7_11" ~ "Staff receive information about the older adult's pre-hospitalization baseline",
                          Item == "Q7_13" ~ "There is continuity of care across settings")) %>%
  mutate(Item = wrap_30(Item)) %>%
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .6, color = "white") +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank())
```

**Organizational Values to Support Age-Sensitive Care**
The following diagram illustrates nurses' perceptions regarding organizational values to provide nursing care tailored to the unique needs of older adults. 

*(Note: These questions assess nurses' perceptions regarding barriers and the lack of specialized resources to care for older adults. For this diagram, higher levels of disagreement reflect nurses' perceptions that the organization values and supports care for older adults.)*
  
  <center>
  **Cohort Level**
  </center>
  ```{r,fig.width=13, fig.height=4}
giap %>%
  select(Q8_1, Q8_2, Q8_5, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q8_1" ~ "Lack of knowledge about care of older adults",
                          Item == "Q8_2" ~ "Lack of (or inadequate) written policies and procedures specific to the older adult population",
                          Item == "Q8_5" ~ "Lack of specialized services for the older adult",
                          Item == "Q8_11" ~ "Communication difficulties with older adults and their families",
                          Item == "Q8_12" ~ "Confusion over who is the appropriate decision maker for the older adult")) %>%
  mutate(Item = wrap_30(Item)) %>%
  group_by(Item) %>%
  mutate(Percent = round(n / sum(n) * 100),
         Percent = ifelse(Percent < 7, NA, paste0(Percent, '%'))) %>%
  ungroup() %>%
  ggplot(aes(x = Item, y = n, fill = Response, label = Percent)) +
  geom_bar(position = "fill", stat = "identity", width = .5, color = "white") +
  geom_text(aes(colour = Response), size = 4, position = position_fill(vjust = 0.5)) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  scale_colour_manual(values=c("black","black","black","white","white"), guide = FALSE) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank(),
        axis.text.x=element_blank())
```

<center>
  **`r name`**
  </center>
  
  ```{r,fig.width=13, fig.height=5.5}
giap %>%
  filter(Hospital.Name==name) %>% 
  select(Q8_1, Q8_2, Q8_5, Q8_11, Q8_12) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>%
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = case_when(Response == 1 ~ "Strongly Disagree",
                              Response == 2 ~ "Disagree",
                              Response == 3 ~ "Neither Agree nor Disagree",
                              Response == 4 ~ "Agree",
                              Response == 5 ~ "Strongly Agree"),
         Response = ordered(Response, levels = rev(c("Strongly Disagree","Disagree","Neither Agree nor Disagree","Agree","Strongly Agree"))),
         Item = case_when(Item == "Q8_1" ~ "Lack of knowledge about care of older adults",
                          Item == "Q8_2" ~ "Lack of (or inadequate) written policies and procedures specific to the older adult population",
                          Item == "Q8_5" ~ "Lack of specialized services for the older adult",
                          Item == "Q8_11" ~ "Communication difficulties with older adults and their families",
                          Item == "Q8_12" ~ "Confusion over who is the appropriate decision maker for the older adult")) %>%
  mutate(Item = wrap_30(Item)) %>%
  ggplot(aes(x = Item, y = n, fill = Response)) +
  geom_bar(position = "fill", stat = "identity", width = .6, color = "white") +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = cols) +
  labs(y = "", x = "", fill = "") +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "right", text = element_text(size = 20, color = "black"),
        plot.margin = unit(c(-0.3, 0, 0, 0), "cm"),
        panel.border = element_blank())
```

**Unit Environment to Support Improvements in the Care of Older Adults**
  The following diagram illustrates nurses' perceptions regarding the priority that nurse mangers and clinical leaders place on improving care for older adults.

<center>
**Cohort Level**
</center>

```{r, fig.width=9, fig.height=6, out.width='90%'}
giap %>%
  select(Q7_26, Q7_27, Q7_28, Q7_29, Q7_30) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>% 
  group_by(Item) %>% 
  mutate(Response = ifelse(is.na(Response), 6, Response),
         Agree_n = ifelse(Response == 4 | Response == 5, n, 0)) %>% 
  summarize(Agree_prop = sum(Agree_n, na.rm = T)/sum(n, na.rm = T)) %>% 
  mutate(Agree_prop = round(Agree_prop, 2),
         group = ifelse(Agree_prop <0.5, "red",
                        ifelse(Agree_prop>=0.5 & Agree_prop<0.75, "yellow","green")),
         label = paste0(Agree_prop*100, "%")) %>% 
  ggplot(aes(fill = group, ymax = Agree_prop, ymin = 0, xmax = 2, xmin = 1)) +
  geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#faf9eb", color = 'black') +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + xlim(c(0, 2)) + ylim(c(0,2)) +
  geom_text(aes(x = 0, y = 0, label = label, colour=group), size=6.5) +
  geom_text(aes(x=1.5, y=1.5, label=Item), size=4.2) + 
  facet_wrap(~Item, ncol = 5) +
  theme_void() +
  scale_fill_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  scale_colour_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  theme(strip.background = element_blank(),
        strip.text.x = element_blank()) +
  guides(fill=FALSE) +
  guides(colour=FALSE)
```

<center>
**`r name`**
</center>

```{r,  fig.width=9, out.width='90%', fig.asp=0.667}
giap %>%
  filter(Hospital.Name == name) %>% 
  select(Q7_26, Q7_27, Q7_28, Q7_29, Q7_30) %>%
  gather(Item, Response) %>% 
  count(Item, Response) %>% 
  group_by(Item) %>% 
  mutate(Response = ifelse(is.na(Response), 6, Response),
         Agree_n = ifelse(Response == 4 | Response == 5, n, 0)) %>% 
  summarize(Agree_prop = sum(Agree_n, na.rm = T)/sum(n, na.rm = T)) %>% 
  mutate(Agree_prop = round(Agree_prop, 2),
         group = ifelse(Agree_prop <0.5, "red",
                        ifelse(Agree_prop>=0.5 & Agree_prop<0.75, "yellow","green")),
         label = paste0(Agree_prop*100, "%")) %>% 
  ggplot(aes(fill = group, ymax = Agree_prop, ymin = 0, xmax = 2, xmin = 1)) +
  geom_rect(aes(ymax=1, ymin=0, xmax=2, xmin=1), fill ="#faf9eb", color = 'black') +
  geom_rect() + 
  coord_polar(theta = "y",start=-pi/2) + xlim(c(0, 2)) + ylim(c(0,2)) +
  geom_text(aes(x = 0, y = 0, label = label, colour=group), size=6.5) +
  geom_text(aes(x=1.5, y=1.5, label=Item), size=4.2) + 
  facet_wrap(~Item, ncol = 5) +
  theme_void() +
  scale_fill_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  scale_colour_manual(values = c("red"="#AE6180", "yellow"="#FFC842", "green"="#6BAB8A")) +
  theme(strip.background = element_blank(),
        strip.text.x = element_blank()) +
  guides(fill=FALSE) +
  guides(colour=FALSE)
```

<center>
### **Summary and Recommendations**
</center>

High quality care for older adults relies on two factors; a highly competent nursing workforce and care delivery processes that take the unique needs of older adults into account. The GIAP evaluates nurses' knowledge and perceptions of the care environment to support high quality care for older adults. The GIAP provides leaders with information to develop population-specific care for older adults at the nursing unit, hospital, and health system levels.

The results of the GIAP for the `r cohort` cohort suggests that nurses' knowledge regarding evidence-based practices to care for older adults is aligned with national trends [@author3]. There are opportunities to improve nurses' knowledge to both assess and use evidence-based interventions to address the problems of nutrition and hydration, incontinence, and managing behaviors associated with dementia and cognitive decline among the population of older adults receiving care at your hospital. Some poor practices or uncertainty regarding the best interventions to promote optimal health outcomes for older adults were also identified.

In general, nurses perceive that organizational factors impede progress to deliver age-sensitive care. The participating staff identified a lack of time to both care for older adults and to devote to clinical practice change projects as barriers to providing age-friendly care on their units. The participating nurses also reported that there is a lack of equipment and professional expertise available to them on a daily basis to support high-quality care for older adults. Finally, participants reported that there is room for nurse managers and clinical leaders to communicate the importance of caring for older adults and to determine ways to integrate quality improvement and education into daily practice to develop clinical expertise and use evidence-based practices to care for older adults. 

<center>
  **Summary**
  </center>
  
  This diagram summarizes the participating hospitals' performance on the knowledge and practice environment components of the GIAP survey. The majority of hospitals participating in the `r cohort` survey fall within the **Early Quadrant**. Your hospital is marked with a bold dot.

```{r}
ResAv <- giap %>%
  select(Hospital.Name, CASEID, 
         Q8_1, Q8_2, Q8_5, Q8_11, Q8_12) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = Response - 1,
         Item = case_when(Item == "Q8_1" ~ "Lack knowledge about care",
                          Item == "Q8_2" ~ "Lack written policy and procedure",
                          Item == "Q8_5" ~ "Lack of specialized services",
                          Item == "Q8_11" ~ "Communication difficulties",
                          Item == "Q8_12" ~ "Confusion regarding decision maker")) %>%
  group_by(Hospital.Name) %>%
  mutate(Resource_Availability_H = mean(Response)) %>%
  group_by(Hospital.Name, CASEID) %>%
  mutate(Resource_Availability_P = mean(Response)) %>%
  ungroup() %>%
  mutate(Resource_Availability_T = mean(Response))

AgeSensCare <- giap %>%
  select(Hospital.Name, CASEID, 
         Q7_1, Q7_2, Q7_5, Q7_7, Q7_11, Q7_13) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = Response -1,
         Item = case_when(Item == "Q7_1" ~ "Individualized care",
                          Item == "Q7_2" ~ "Care needed",
                          Item == "Q7_5" ~ "How aging affects treatment responses",
                          Item == "Q7_7" ~ "Aging is a factor in plan of care",
                          Item == "Q7_11" ~ "Pre-hospitalization baseline",
                          Item == "Q7_13" ~ "Continuity of care across settings")) %>%
  group_by(Hospital.Name) %>%
  mutate(Age_Sensitive_Care_H = mean(Response)) %>%
  group_by(Hospital.Name, CASEID) %>%
  mutate(Age_Sensitive_Care_P = mean(Response)) %>%
  ungroup() %>%
  mutate(Age_Sensitive_Care_T = mean(Response))

ImpClim <- giap %>%
  select(Hospital.Name, CASEID, 
         Q7_26, Q7_27, Q7_28, Q7_29, Q7_30) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = Response -1,
         Item = case_when(Item == "Q7_26" ~ "Time",
                          Item == "Q7_27" ~ "Training",
                          Item == "Q7_28" ~ "Time off work",
                          Item == "Q7_29" ~ "Nursing management",
                          Item == "Q7_30" ~ "Priority")) %>%
  group_by(Hospital.Name) %>%
  mutate(Implementation_Climate_H = mean(Response)) %>%
  group_by(Hospital.Name, CASEID) %>%
  mutate(Implementation_Climate_P = mean(Response)) %>%
  ungroup() %>%
  mutate(Implementation_Climate_T = mean(Response))

EduOpp <- giap %>%
  select(Hospital.Name, CASEID, 
         Q17) %>%
  gather(Item, Response, -Hospital.Name, -CASEID) %>% 
  filter(!is.na(Response), Response != 9) %>%
  mutate(Response = Response - 1,
         Item = case_when(Item == "Q17" ~ "Job your institution has done educating\nstaff about the care of the older adult")) %>%
  group_by(Hospital.Name) %>%
  mutate(Edu_Opp_H = mean(Response)) %>%
  group_by(Hospital.Name, CASEID) %>%
  mutate(Edu_Opp_P = mean(Response)) %>%
  ungroup() %>%
  mutate(Edu_Opp_T = mean(Response))

profile_DF <- list(ResAv %>% select(Hospital.Name, Resource_Availability_H) %>%unique(),
AgeSensCare %>% select(Hospital.Name, Age_Sensitive_Care_H) %>% unique(),
ImpClim %>% select(Hospital.Name, Implementation_Climate_H) %>% unique(),
EduOpp %>% select(Hospital.Name, Edu_Opp_H) %>% unique(),
Assess %>% select(Hospital.Name, Assess_H) %>% unique(),
Delirium %>% select(Hospital.Name, Delirium_H) %>% unique(),
Dementia %>% select(Hospital.Name, Dementia_H) %>% unique(),
Depression %>% select(Hospital.Name, Depression_H) %>% unique(),
Medication %>% select(Hospital.Name, Medication_H) %>% unique(),
Nutrition %>% select(Hospital.Name, Nutrition_H) %>% unique(),
Skin %>% select(Hospital.Name, Skin_H) %>% unique(),
Sleep %>% select(Hospital.Name, Sleep_H) %>% unique(),
Urinary %>% select(Hospital.Name, Urinary_H) %>% unique()) %>%
  reduce(full_join, by = "Hospital.Name") %>%
  gather(Variable, `Hospital Average`, -Hospital.Name) %>%
  mutate(Variable = gsub("_H", "", Variable),
         Variable = gsub("_", " ", Variable)) %>%
  group_by(Variable) %>%
  mutate(`Overall Average` = mean(`Hospital Average`)) %>%
  ungroup() %>%
  mutate(Variable = forcats::fct_reorder(Variable, `Overall Average`)) %>%
  gather(Level, Value, c(`Hospital Average`, `Overall Average`)) %>%
  mutate(Axis = ifelse(Variable %in% c("Assess", "Delirium", "Dementia", "Depression", "Falls",
                                       "Medication", "Nutrition", "Skin", "Sleep", "Urinary"),
                       "Knowledge", 
                       "Practice Environment"))
```

```{r}
profile_DF %>%
  mutate(Hospital.Name = as.factor(Hospital.Name)) %>%
  group_by(Hospital.Name, Axis) %>%
  summarize(Mean = mean(Value)) %>%
  spread(., key = Axis, value = Mean) %>%
  ggplot(aes(x = `Practice Environment` / 4, y = Knowledge)) +
  geom_tile(aes(x = 0.64, y = 0.4, width = 0.24, height = 0.4), fill = "#6199AE") +
  geom_tile(aes(x = 0.64, y = 0.8, width = 0.24, height = 0.4), fill = "#E6E6E6") +
  geom_tile(aes(x = 0.88, y = 0.4, width = 0.24, height = 0.4), fill = "#E6E6E6") +
  geom_tile(aes(x = 0.88, y = 0.8, width = 0.24, height = 0.4), fill = "#6BAB8A") +
  geom_point(aes(shape = Hospital.Name == name), color = "black", size = 5) +
  geom_text(aes(x = 0.64, y = 0.4, label = "Early"), color = "white") +
  geom_text(aes(x = 0.64, y = 0.8, label = "Senior Friendly")) +
  geom_text(aes(x = 0.88, y = 0.4, label = "Senior Friendly")) +
  geom_text(aes(x = 0.88, y = 0.8, label = "Exemplary"), color = "white") +
  scale_x_continuous(limits=c(0.52,1), breaks = c(.64,.88), labels = c("Beginning","Advanced")) +
  scale_y_continuous(limits=c(0.2,1), breaks = c(.4,.8), labels = c("Beginning","Advanced")) +
  scale_shape_manual(values = c(1,19), labels = c("Peers", "You")) +
  labs(x = "Senior Friendly Practice", y = "Senior Friendly Knowledge") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  labs(shape = "")
```

Hospitals in the ***early quadrant*** are characterized by gaps in nurses' knowledge regarding evidence-based practices to assess and manage common nursing problems experienced by older adults during acute care hospital stays. Because nursing practice and population-based care approaches are embedded within unit-level care processes, hospitals in the early practice environment stage are characterized by limited resources and specialized services designed to meet the needs of older adults.

##### **Recommendations to Develop Your NICHE Program**
##### **`r name`**
##### **Early**

The information gained from the GIAP enables nurse managers and clinical leaders to prioritize continuing professional development and clinical quality improvement initiatives to implement the NICHE practice model. Based on your hospital's results we recommend:

1. **Workforce Education**
    * Work with the nurse educators and unit nurse managers to identify gaps in nurses' knowledge, skills or practice. Align the nursing education priorities with the broader nursing practice development agenda.  
* Initiate on-line or instructor-led staff education using the NICHE Geriatric Resource Nurse and Geriatric PCA/CNA programs.

* Link continuing education priorities to the nursing process to identify gaps in staff's skills to assess, intervene, or evaluate nursing care to effectively manage  each geriatric syndrome or nursing problem. 
    
2. **Develop the Practice Environment to Support Age-Friendly Care**
    * Review the NICHE Protocols and other national clinical practice guidelines to integrate evidence-based practices in the nursing care policies, procedures, documentation and reporting processes 
      + Establish nurse-led protocols for falls/mobility, pressure injury prevention, urinary catheter management, medication reconciliation, and discharge planning, patient and caregiver teaching 
      
    * Develop the Geriatric Resource Nurse (GRN) role on participating units to oversee and lead inter-professional care planning and team development efforts 
      + Identify and select staff nurses ready to take the next step in their leadership careers.  We recommend that a minimum of three nurses per shift to serve as GRNs
      
    * Establish a NICHE Steering Committee and collaborate with the nursing practice councils to review policies, procedures and documentation systems to standardize data collection and care planning approaches based on the NICHE Protocols and other national clinical practice guidelines for older adults. 
    
3. **Share results and publicize nurses' accomplishments to establish Age-Friendly care**
  * If there are discrepancy between nurses' perceptions and the actual availability of equipment or specialty geriatric services at your hospital, consider a marketing campaign targeting the front line staff to raise awareness about these resources to support the care of older adults.
    
    * Work with your hospital's communications department to publicize staff participation in the NICHE program 

* Present data about changes in patient outcomes and satisfaction, nurse satisfaction and engagement or cost reductions resulting from quality improvement initiatives carried out under the NICHE program 

**Technical Note:  GIAP Survey and Data Analysis**
  
  This technical note provides an overview of the GIAP survey and the data analyses used to generate this report. The GIAP is assesses the following components of the nursing practice environment:
  
  **Geriatric Nursing Knowledge**
  Nurses' abilities to recognize the multifactorial clinical problems commonly experienced by older adults and appropriately intervene is integral to improving clinical outcomes for older adults. The GIAP assess nurses' knowledge about evidence-based assessments and interventions to manage the geriatric syndromes of skin injuries, incontinence, falls, delirium, and the nursing problems of managing dementia and depression behaviors, sleep, nutrition and hydration, and medication management. A sample question from this section is: "Medications are the only way to treat behavioral symptoms in persons living with dementia."

**Specialized Resources**
  This scale assesses nurses' perceptions about the availability of specialized resources to deliver care to older adults. Respondents are asked to rate the extent to which durable medical equipment, clinical resources, and information from colleagues and families are available to plan and implement care for older adults. A sample question from this scale is: "Lack of written policies and procedures specific to the older adult population are a barrier to providing care to older adults."
 
**Age-Friendly Care Planning and Delivery**
This scale assesses nurses' perceptions about the organization and delivery of nursing care that takes the unique physical, emotional and psychological needs of older adults into account.   Respondents are asked to rate the extent to which they agree or disagree with a series of questions on a five-point Likert agreement scale. A sample question from this scale is: "Staff provided individualized, person-centered care."

**Organizational Values to Support Age-Friendly Care**
  The organizational values scale assesses nurses' perceptions of the ways that staff work together to create a practice environment that values and supports the unique care needs of older adults. Respondents are asked to rate the extent to which they agree with a series of statements on a five-point Likert scale. A sample question from this scale is "Clinicians and administrators work together to solve problems facing older adult patients."

**Unit Environment to Support Improvements in Care of Older Adults**
Changing nursing practice to improve the quality of care is challenging and requires a well-defined change management plan. The questions in the unit environment scale provides information about nurses' perceptions of the time required to care for older adults and the role of the nurse managers and clinical leaders to support the use of evidence-based clinical practices know to improve health outcomes for older adults. A sample question from this scale is "Care of the older adult is a priority on my unit."  
The GIAP scales each contain between five and eleven questions and the coefficient alphas for the scales range between 0.81 and 0.94.

**Sample**
  Registered nurses and nursing assistants/patient care associates between the ages of 18 -70 years, working on the nursing units implementing the NICHE nursing practice model, were invited to participate in the GIAP. Staff working on a full-time or part-time basis are eligible to participate in the survey. Because the GIAP focuses on nurses' knowledge and perceptions, the sample is limited to nursing personnel.

`r num_hospitals` NICHE member hospitals participated in the `r cohort` GIAP survey. Within the `r num_hospitals` hospitals, `r eligible_nurses` nurses were eligible to participate. We received complete data from `r responded_nurses` respondents, which equates to a `r round(responded_nurses/eligible_nurses*100, 2)`% response rate.

**Data analysis**
The data were pooled across participating hospitals. We analyzed the cohort and individual hospital data using descriptive statistics.

*Knowledge Scores:* The percentage of correct responses were calculated for each topic and the mean score is marked with an asterisk. Following standard practice in continuing nursing education, a mean score of 80% denotes nurses' mastery of interventions to effectively identify and manage common health problems and complications of hospitalization experienced by older adults. 

*Scale construction:* The survey data were aggregated to the unit-level and reported for each participating hospital. The aggregated cohort data provides insights into the state of geriatric nursing practice at participating hospitals and can be used to inform the development of policies, procedures and services to support age-friendly nursing care.

#### **References**



