#Our goal is to make it x1 y1 x2 y2 and so forth! 
data("anscombe")
help("select")
anscombe -> df
select(df,x1,x2,x3,x4) %>%
rename(set1=x1,set2=x2,set3=x3,set4=x4) %>%
gather(key= groupX,value =x_values, set1,set2,set3,set4) ->dfX
df%>%
select(y1,y2,y3,y4)  %>%
gather(key=groupY,value = y_values,y1,y2,y3,y4) ->dfY
merge(dfX,dfY,all.y=TRUE) ->df3
ggplot(df3,aes(x=x_values,y=y_values))+geom_point()


#better
dat <- datasets::anscombe
datLong <-data.frame(
  group = rep(1:4, each = 11),
  x = unlist(dat[,c(1:4)]),
  y = unlist(dat[,c(5:8)]))

rownames(datLong)<-NULL
ggplot(datLong,aes(x=x,y=y,color=group))+geom_point() +facet_wrap(~group)

write.csv(df3,"df3.csv")
