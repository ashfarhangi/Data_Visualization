library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(reshape2)
# Population violing + boxplot
populationTotal <- read_excel("GitHub/Data_Visualization/data/indicator gapminder population.xlsx")




df1 <-populationTotal
df1wide<-melt(df1,id.vars = c("Total population")) 
#  filter(country == 'Iran')
df2 <- df1wide %>% 
  filter(`Total population` %in% c("United States","China","Iran","Russia","India")) %>% 
  select(`Total population`,variable,value)

ggplot(df2, aes(x=variable, y=value, group = 'Total population'))+
  geom_violin(width=0.9, position=position_dodge(0.75), bw=1.5, aes(fill = value))+
  geom_boxplot(width=0.3, outlier.shape = NA, position=position_dodge(0.75), fill = "white")

dfx<- populationTotal %>% 
  gather(year,population,-"Total population") %>% 
  filter(`Total population` %in% c("United States","China","Iran","Russia","India")) %>% 
  select(`Total population`,year,population)

color1 <- c('red','blue','green','yellow','black')
ggplot(dfx,aes(x=`Total population`,y=population,group = 'Total population',color = 'Total population'),colour = color1 <- c('red','blue','green','yellow'),size = 0.2, draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.5, scale = "count")+
  geom_violin()+
  ggtitle("Violin: Population based on 5 countries")+
  scale_color_manual(values = color1) +
  geom_boxplot(width=.1)

ggplot(dfx,aes(x='Total population',y=population,factor(interaction('Total population',population)),color = 'Total population'),colour = color1 <- c('red','blue','green','yellow'),size = 0.2, draw_quantiles = c(0.25, 0.5, 0.75), alpha = 0.5, scale = "count")+
  geom_violin()+
  ggtitle("Violin: Population based on 5 countries")+
  scale_color_manual(values = color1) +
  geom_boxplot(width=.1)

#Pyramid
male1 <- read_excel("GitHub/Data_Visualization/data/indicator_male 0-4 percen.xlsx")
male2 <- read_excel("GitHub/Data_Visualization/data/indicator_male 5-9 percen.xlsx")
male3 <- read_excel("GitHub/Data_Visualization/data/indicator_male 10-14 percen.xlsx")
male4 <- read_excel("GitHub/Data_Visualization/data/indicator_male 15-19 percen.xlsx")
male5 <- read_excel("GitHub/Data_Visualization/data/indicator_male 20-39 percen.xlsx")
male6 <- read_excel("GitHub/Data_Visualization/data/indicator_male 40-59 percen.xlsx")
male7 <- read_excel("GitHub/Data_Visualization/data/indicator_male above 60 percen.xlsx")

female1 <- read_excel("GitHub/Data_Visualization/data/indicator_female 0-4 percen.xlsx")
female2 <- read_excel("GitHub/Data_Visualization/data/indicator_female 5-9 percen.xlsx")
female3 <- read_excel("GitHub/Data_Visualization/data/indicator_female 10-14 percen.xlsx")
female4 <- read_excel("GitHub/Data_Visualization/data/indicator_female 15-19 percen.xlsx")
female5 <- read_excel("GitHub/Data_Visualization/data/indicator_female 20-39 percen.xlsx")
female6 <- read_excel("GitHub/Data_Visualization/data/indicator_female 40-59 percen.xlsx")
female7 <- read_excel("GitHub/Data_Visualization/data/indicator_female above 60 percen.xlsx")

male1 <- male1 %>% 
  gather(year,population,-'Male 0-4 years (%)') %>% 
  filter('Male 0-4 years (%)' %in% c("United States","China","Iran","Russia","India")) %>% 
  select('Male 0-4 years (%)',year,population)

labs<-c("Male 0-4 years","Male4-9 years","")

df = data.frame(labs=rep(labs,4), values=c(mov, mob, fov, fob), 
                sex=rep(c("Male", "Female"), each=2*length(fov)),
                bmi = rep(rep(c("population"), each=length(fov)),2))

# Order countries by overall percent overweight/obese
labs.order = ddply(df, .(labs), summarise, sum=sum(values))
labs.order = labs.order$labs[order(labs.order$sum)]
df$labs = factor(df$labs, levels=labs.order)



ggplot(df, aes(x=labs)) +
  geom_bar(data=df[df$sex=="Male",], aes(y=values, fill=bmi), stat="identity") +
  geom_bar(data=df[df$sex=="Female",], aes(y=-values, fill=bmi), stat="identity") +
  geom_hline(yintercept=0, colour="white", lwd=1) +
  coord_flip(ylim=c(-101,101)) + 
  scale_y_continuous(breaks=seq(-100,100,50), labels=c(100,50,0,50,100)) +
  labs(y="Percent", x="Country") +
  ggtitle("Female                                                 Male")
