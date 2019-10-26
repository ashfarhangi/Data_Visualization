D3
==

Using the d3 requires to install the library:

Html will run the whole css, d3 and more.

R:
==

library(ggplot2)

df \<- read.csv("data/cereal.csv")

For replacing negative values I’ve used the following:

df[df\<0] \<- 1

**Histogram of calories_per_cup (computed element) **

Code:

ggplot(data=df,aes(x=Calories/Cups.per.Serving))+ggtitle("Histogram:
Calories/Cup by shelf")+geom_histogram(colour='black',fill="blue")

![Last](media/394c41f2a7e7f8525dc3b06c397c9cc0.png)

**Histogram of calories_per_cup  faceted by Shelf**

**Code**: h+facet_wrap(\~Display.Shelf,nrow=1)+ggtitle('Histogram Facet by
shelf') + scale_fill_gradient(low="blue")

![HistogramFacedbyShelf](media/a1b3c890131fbec735e9395d4716d258.png)

Violin

v
\<-ggplot(data=df,aes(x=Display.Shelf,y=Calories/Cups.per.Serving))+ggtitle("Calories/Cup
by shelf")+geom_violin()

v+facet_wrap(\~Display.Shelf,nrow=1)+ggtitle('Violin Facet by shelf')

![](media/d66ec42f72517d587211fc9bfc6ec766.png)

![C:\\Users\\as630696\\AppData\\Local\\Microsoft\\Windows\\INetCache\\Content.Word\\Violing by shelf.png](media/3179dc7d9b53c099979dbf26b40c6574.png)

![](media/3179dc7d9b53c099979dbf26b40c6574.png)
