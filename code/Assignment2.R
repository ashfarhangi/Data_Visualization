#Author: Ashkan Farhangi
trafficstops <- read.csv("data/trafficstops.csv")
library(tidyverse)
select(trafficstops, police_department, officer_id, driver_race)
select(trafficstops, starts_with("driver"))
filter(trafficstops, county_name == "Yazoo County")
slice(trafficstops, 1:3)
senior_drivers <- trafficstops %>% 
  filter(driver_age > 85) %>% 
  select(violation_raw,driver_gender,driver_race) 

#Challenge 1 with bonus
challenge1 <-trafficstops %>% 
  filter(county_name=="Tunica County") %>% 
  select(stop_date,driver_age,violation_raw) %>% 
  arrange(driver_age)
  view(challenge1)
