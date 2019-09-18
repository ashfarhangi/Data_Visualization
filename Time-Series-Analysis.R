#stop mid writing Press F1 to help at anything in R
install.packages("tidyverse")
install.packages("tidyquant")
library(tidyverse)
help(tidyquant)
#Quant
library(tidyquant)
library(ggplot2)
tq_get_options()
APPLE <- tq_get("AAPL")
view(APPLE)
APPLE %>% ggplot(aes(x=date,y=high))+geom_line()+ geom_line(color = "darkblue")+ ggtitle("Apple prices series") + xlab("Date") + ylab("Price") + scale_x_date(date_labels = "%y", date_breaks = "6 months")+ theme(plot.title = element_text(hjust = 0.5))
