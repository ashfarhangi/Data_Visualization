#stop mid writing Press F1 to help at anything in R
library(tidyverse)
#Quant
library(ggplot2)
library(readxl)
# Please replace the data with the your current folder
gdppc_cppp_by_gapminder <- read_excel("GitHub/Data_Visualization/data/gdppc_cppp-by-gapminder.xlsx", sheet = "countries_and_territories")
df <- gdppc_cppp_by_gapminder

colnames(df) -> x 
x<-x[5:245]
totalyears <- as.integer(x[245]) - as.integer(x[5])
usa <- df[245]
china <-df[45]
iran <- df[104]
russia <- df[186]
#Now lets clean the data a little
sum(is.na(usa))
sum(is.na(china))
sum(is.na(iran))

# Using zoo package for muting missing data
#install.packages("zoo")
library('zoo')
na.approx(usa) -> usa
sum(is.na(usa))
na.approx(china) -> china
sum(is.na(china))
na.approx(iran) -> iran
sum(is.na(iran))
na.approx(russia) -> russia
sum(is.na(russia))
# Now lets plot them
cbind(usa,china,iran,russia) -> df2



