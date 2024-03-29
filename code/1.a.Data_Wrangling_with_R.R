#Author: Ashkan Farhangi
#Questions: https://cengel.github.io/R-data-wrangling

#Uncomment if its your fresh install!
#install.packages("lubridate")
trafficstops <- read.csv("data/trafficstops.csv")
library(tidyverse)

select(trafficstops, police_department, officer_id, driver_race)
select(trafficstops, starts_with("driver"))
filter(trafficstops, county_name == "Yazoo County")
slice(trafficstops, 1:3)
a_senior_drivers <- trafficstops %>% 
  filter(driver_age > 85) %>% 
  select(violation_raw,driver_gender,driver_race) 

#Challenge 1 with bonus
library(lubridate)
challenge1 <-trafficstops %>% 
  filter(county_name=="Tunica County") %>% 
  select(stop_date,driver_age,violation_raw) %>% 
  arrange(driver_age)
  view(challenge1)
#Challenge 2 
e_mutate <- trafficstops %>% 
  mutate(birth_year = substring(driver_birthdate, 1, 4)) %>% 
  mutate(birth_date = ymd(driver_birthdate),birth_year = year(driver_birthdate)) %>% 
  mutate(birth_date = ymd(driver_birthdate),
       birth_year = year(driver_birthdate),
       birth_cohort = round(birth_year/10)*10,
       birth_cohort = factor(birth_cohort)) %>% 
  select(birth_cohort) %>%
  plot()
    
  
  
a_violation <-trafficstops %>% 
  mutate(weekday_of_stop = wday(stop_day) ) %>% 
  filter(driver_age==50,driver_gender=='female') %>% 
  filter(wday(stop_date)==1)

#Challenge 3   
MS_bw_pop <- read.csv("data/MS_acs2015_bw.csv")
head(MS_bw_pop)

e_Joined<-trafficstops %>% 
  group_by(county_name) %>% 
  summarise(n_stops = n()) %>% 
  left_join(MS_bw_pop, by = c("county_name" = "County")) %>% 
  head()
a_sorted<-e_Joined %>% 
  arrange(n_stops)
# Challenge 4
# Its a long format

# How two manipuate data
trafficstops_ma <- trafficstops %>%
  filter(!is.na(driver_gender)) %>%
  group_by(county_name, driver_gender) %>%
  summarize(mean_age = mean(driver_age, na.rm = TRUE))

head(trafficstops_ma)
trafficstops_ma_wide <- trafficstops_ma %>%
  spread(driver_gender, mean_age) 

head(trafficstops_ma_wide)

trafficstops_ma_wide %>% 
  mutate(agediff = male - female) %>% 
  ungroup() %>%
  filter(agediff %in% range(agediff))
trafficstops_ma_long <- trafficstops_ma_wide %>%
  gather(gender, mean_age, -county_name)

head(trafficstops_ma_long)
trafficstops_ma_wide %>%
  gather(gender, mean_age, female:male) %>% 
  head()

write.csv(trafficstops_ma_wide, "data_output/MS_county_stops.csv", row.names = FALSE)

# Challenge 5
a6_wide_year <- trafficstops %>%
  mutate(year = year(ymd(stop_date))) %>% 
  group_by(violation_raw,year) %>%
  summarize(number_of_stops = n()) %>% 
  spread(year,number_of_stops)
  head(a6_wide_year)

  


