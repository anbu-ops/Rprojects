getwd()
setwd("/Users/alphaomega/RProjects/Advanced_R/Weather Data")
CH<- read.csv("Chicago-F.csv",row.names = 1)
HN<- read.csv("Houston-F.csv",row.names = 1)
NY<- read.csv("NewYork-F.csv",row.names = 1)
SF<- read.csv("SanFrancisco-F.csv",row.names = 1)

CHM<- as.matrix(CH)
HNM<- as.matrix(HN)
NYM<- as.matrix(NY)
SFM<- as.matrix(SF)

Weather<- list(chicago=CHM,houston=HNM,newyork=NYM,sanfrancisco=SFM)
Weather$chicago

#------------------------------APPLY------------------------------

?apply

apply(Weather$chicago,1,mean) #Returns row-wise mean [1 for row]
apply(Weather$chicago,1,max)
apply(Weather$chicago,2,mean) #Returns column-wise mean [2 for column]
apply(Weather$chicago,2,min)


#---------comparing b/w states---------

apply(Weather$chicago,1,mean)
apply(Weather$newyork,1,mean)
apply(Weather$houston,1,mean)
apply(Weather$sanfrancisco,1,mean)

#-------------------------------LAPPLY-------------------------------

#lapply returns a list
?lapply
##we can apply it on a list/Vector
lapply(Weather,t) # t is the name of the function which transposes a matrix!
lapply(Weather,rbind,newRow=1:12) # we are adding a new row to each Matrix and the row should be same dimension with other rows.
lapply(Weather,rowMeans) #rowMeans,colMeans,rowSums,colSums all are very handy functions.


lapply(Weather,"[",1,12) # returns the 12 th element of every first rows' of every matrix inside that list

round(sapply(Weather,rowMeans),2) # sapply returns more user friendly way!

















