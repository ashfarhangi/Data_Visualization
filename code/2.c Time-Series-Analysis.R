#route 2
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
# Please replace the data with the your current folder
gdppc_cppp_by_gapminder <- read_csv("GitHub/Data_Visualization/data/income_per_person_gdppercapita_ppp_inflation_adjusted.csv")
                                      
df <- gdppc_cppp_by_gapminder

df1 <- df %>% 
  gather(year,gpd,-country) %>% 
  filter(year <= 2018 & year >= 1800 &country %in% c("United States","China","Iran","Russia")) %>%
  select(country,year,gpd)

color1 <- c('red','blue','green','yellow')
ggplot(df1,aes(x=year, y=gpd,group=country,color=country))+ geom_line(size=2)+scale_x_discrete(breaks=(seq(1800,2010,by=20))) +
  scale_color_manual(values = c('blue','red','yellow','green')) +
  annotate("point",x=218,y= 16000,label="O",color='red',size=6) +
  annotate("point",x=218,y= 54200,label="O",color='green',size=6)+
  annotate("point",x=218,y= 24800,label="O",color='yellow',size=6)+
  annotate("point",x=218,y= 17400,label="O",color='blue',size=6)
  
  
       
colnames(df3) = df3[1,]
df3 <- as.data.frame(df3)
df3 <- df3[-1,]
df3 %>% 
  ggplot(aes(x=year, y=China, colour = 'red')) +geom_line()+geom_point() +annotate("text",x = as.integer(df3[240,1]),y= as.integer(df3[240,2]) ,label="O",color='red',size=10)

df3 %>% 
  ggplot(aes(x=year,y=Iran, colour = "blue",size=4))+geom_line() +annotate("text",x = as.integer(df3[240,1]),y= as.integer(df3[240,3]) ,label="O",color='Blue',size=10)
df3 %>% 
  ggplot(aes(x=year, y=`United States`, colour = 'red')) +geom_line()+geom_point() +annotate("text",x = as.integer(df3[240,1]),y= as.integer(df3[240,5]) ,label="O",color='Black',size=10)

df3 %>% 
  ggplot(aes(x=year,y=Russia, colour = "black"))+geom_line()+geom_point() +annotate("text",x = as.integer(df3[240,1]),y= as.integer(df3[240,4]) ,label="O",color='Green',size=10)

#Long to wide
df3Wide<-df3 %>% 
  gather(China,year)

plot = ggplot() + geom_line(data = df3,aes(x=year,y=China),color="red") +geom_point(data = df3,aes(x=year,y=Iran),color="blue")+geom_point(data = df3,aes(x=year,y=`United States`),color="green")+geom_point(data = df3,aes(x=year,y=Russia),color="yellow") + 
  scale_y_discrete() +expand=c(0.2,0)
  
print(plot)
as.integer(df[2,3])
