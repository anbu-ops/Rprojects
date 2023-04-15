util<- read_csv("P3-Machine-Utilization.csv")
head(util,20)
str(util)
summary(util)

# we need a utility column as there is a column which shows only downtime of a machine.

#-----------------Making New Column--------------
util$Utilization<- 1-util$`Percent Idle`
tail(util)
#-----------------New column Utilization added----------------

#----------------Timestamp column handling for computer to understand----------------
?POSIXct #converts the datetime into UNIX datetime format.
tail(util)
util$PosixTime<-as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M") #we must include format="" part 
#%d:-> dd , %m:-> mm , %Y:-> yyyy , %H:-> hour , %M:-> minute
tail(util)
#---------------------Timestamp handling done----------------------------------------

#----------------------Column Manipulation-------------------------
util<-util[c(2:5)] #Timestamp column removed
util<-util[c(4,1,2,3)] #bringing PosixTime column in front
tail(util)
#----------------------Column manipulation done--------------------

#----------------------Machine=="RL1"-------------------
RL1<-util %>% filter(util$Machine=="RL1")
RL1$Machine<-factor(RL1$Machine)
tail(RL1)
summary(RL1)
RL1_under_90_flag<-length(which(RL1$Utilization<0.90)) > 0 
RL1_min_mean_max<-c(min(RL1$Utilization,na.rm = T),
                    mean(RL1$Utilization,na.rm = T),
                    max(RL1$Utilization,na.rm = T))

list_RL1<-list("RL1",RL1_min_mean_max,RL1_under_90_flag)
names(list_RL1)<-c("Machine","MachineStats","lowThreshold")
#-----------------------------------------------------------

#----------------------Time-series PLOT---------------------
util %>% ggplot(aes(PosixTime,Utilization,color=Machine))+
  geom_line(size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = .90,color="grey",linetype=3,size=1.2)




















