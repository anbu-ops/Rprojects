workingData<-read_csv("Future_500_dataset.csv")

# workingData<-as.data.frame(workingData)
head(workingData,20)
str(workingData)
#-------------------------------
b=c("10","11","12","10","13","11","10")
z=factor(b)
z
as.numeric(b)
#----------------------------------
sapply(workingData, is.factor)  # to see how may columns are already factorized
#----------------------------------
?sub
#grep(pattern, x, ignore.case = FALSE, perl = FALSE, value = FALSE,fixed = FALSE, useBytes = FALSE, invert = FALSE)
#grepl(pattern, x, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
#sub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
#gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)  :-> global substitution
#regexpr(pattern, text, ignore.case = FALSE, perl = FALSE, fixed = FALSE, useBytes = FALSE)
#gregexpr(pattern, text, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
#regexec(pattern, text, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
#gregexec(pattern, text, ignore.case = FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
#-----------------------------------
head(workingData)

#making data clean by removing ,/$/Dollars/%

workingData$Growth<-gsub("%","",workingData$Growth)
head(workingData) # % sign has been removed from Growth column but it's still in character format, need to change it to NUMERIC.
workingData$Growth<-as.numeric(workingData$Growth)
head(workingData) #Growth column changed to numeric.


workingData$Expenses<-gsub(",","",workingData$Expenses)
head(workingData) # , sign has been removed from Expenses column but it's still in character format.
workingData$Expenses<-gsub(" Dollars","",workingData$Expenses)
head(workingData) #need to change it to NUMERIC
workingData$Expenses<-as.numeric(workingData$Expenses)
head(workingData) #Expenses column changed to numeric.


workingData$Revenue<-gsub(",","",workingData$Revenue)
head(workingData) # , sign has been removed from Revenue column but it's still in character format.
workingData$Revenue<-gsub("\\$","",workingData$Revenue)  ### To remove $ symbol we need to specify as \\$ because $ is used in R to decide column
head(workingData) #need to change it to NUMERIC
workingData$Revenue<-as.numeric(workingData$Revenue)
head(workingData) #Revenue column changed to numeric.

# You have a dataframe 'df' and you have just removed some rows from it. Which of the following lines will help you resent the dataframe index (the row names)?
# Answer :->  rownames(df)<-NULL
  

#---------------------------cleaning Starts----------------------------

# Handling NA: filling NA with 100% accurate values/removing that row/fill that NA with median value of that column/using mathematical formulas to fill tgose NA

workingData %>%
  head(20) 
workingData[22,]
All_case<-(complete.cases(workingData)) #this returns us the Boolean values: for complete row returns T/for incomplete rows returns F 
length(All_case[All_case==FALSE]) # this gives us the count of if at least 1 blank in a row.
is.na.data.frame(workingData)

          #fixing the Industry Column

workingDataBackup<-workingData   # taking a backup first 

workingData[!complete.cases(workingData$Industry),] # this gives us the incomplete cases but we need to replace it with complete cases only

workingData<-workingData[complete.cases(workingData$Industry),] #those which are complete for industry only those will be present
workingData %>%
  head(20)
workingData

          # Industry column fixed

          # fixing the state column

 #-------------*************-------------
workingData[!complete.cases(workingData$State),]
#the upper and lower command returns the same thing ie. the NA values along with the rows
workingData[is.na(workingData$State),]
 #-------------*************-------------

workingData %>%
  filter(is.na(workingData$State) & workingData$City=="New York") 

workingData[is.na(workingData$State) & workingData$City=="New York","State"]<-"NY"
workingData[is.na(workingData$State) & workingData$City=="San Francisco","State"]<-"CA"

workingData[is.na(workingData$State),] #all replaced! and returns 0*11 table

          # fixed the state column

          # median imputation method for growth/employees column

# it often the case that the median imputation method is preferred over the mean imputation method because : the median is less affected by outliars

workingData[is.na(workingData$Employees),] #returns 2 rows

emp_retail<-workingData %>%filter(workingData$Industry=="Retail")
median_emp_retail<-median(emp_retail$Employees,na.rm = T)
mean_emp_retail<-mean(emp_retail$Employees,na.rm = T)

workingData[is.na(workingData$Employees) & workingData$Industry=="Retail","Employees"]<- median_emp_retail


emp_retail<-workingData %>%filter(workingData$Industry=="Financial Services")
median_emp_FS<-median(emp_retail$Employees,na.rm = T)
mean_emp_FS<-mean(emp_retail$Employees,na.rm = T)

workingData[is.na(workingData$Employees) & workingData$Industry=="Financial Services","Employees"]<- median_emp_FS

workingData[is.na(workingData$Employees),] #returns 0 rows

# for growth column
workingData[is.na(workingData$Growth),] #returns 1 row

growth_construction<-workingData %>% filter(workingData$Industry=="Construction")
med_growth_construction<-median(growth_construction$Growth,na.rm = T)

workingData[is.na(workingData$Growth) & workingData$Industry=="Construction","Growth"]<- med_growth_construction


workingData[is.na(workingData$Growth),] #returns 0 row

          # median imputation for NA rev/exp/prof

workingData[!complete.cases(workingData),]
#we do not touch the id=17 row as that can be derived from mathematical way like [revenue-expenses=profit]

#REVENUE 

rev_construction<-workingData %>% filter(workingData$Industry=="Construction")
med_rev_construction<-median(rev_construction$Revenue,na.rm = T)

workingData[is.na(workingData$Revenue) & workingData$Industry=="Construction","Revenue"]<- med_rev_construction

workingData[!complete.cases(workingData),] #all revenues are filled

#EXPENSES

exp_construction<-workingData %>% filter(workingData$Industry=="Construction")
med_exp_construction<-median(rev_construction$Expenses,na.rm = T)

workingData[is.na(workingData$Expenses & workingData$Profit) & workingData$Industry=="Construction","Expenses"]<- med_exp_construction

workingData[!complete.cases(workingData),] #all expenses are filled except which we didn't touch

#last Step to fill all NA using mathematical operation

workingData[c(8,42),] #not filled profit rows

workingData[is.na(workingData$Profit),"Profit"]<-workingData[is.na(workingData$Profit),"Revenue"]-workingData[is.na(workingData$Profit),"Expenses"]

workingData[c(8,42),] #all filled


workingData[is.na(workingData$Expenses),"Expenses"]<-workingData[is.na(workingData$Expenses),"Revenue"]-workingData[is.na(workingData$Expenses),"Profit"]

workingData[!complete.cases(workingData),] #left only one row with 1 NA Inception!

#----------------------------cleaning complete-------------------------------

#-------------------****VISUALIZATION STARTS****------------------

#-------scatter Plot---------
workingData %>%
  ggplot(aes(Revenue,Expenses,color=Industry))+
  geom_point()+
  geom_smooth(size=1.2,fill=NA)


#--------Box Plot----------
workingData %>%
  ggplot(aes(Industry,Growth,color=Industry))+ # Industry should be on X axis as it's a categorical variable
  geom_jitter()+
  geom_boxplot(alpha=0.5,size=1)


workingData %>%
  ggplot(aes(Industry,Profit,color=Industry))+ # Industry should be on X axis as it's a categorical variable
  geom_jitter()+
  geom_boxplot(alpha=0.5,size=1)













