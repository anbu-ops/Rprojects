## importing the dataset
ds_salaries<- read.csv("ds_salaries.csv")
## have a look at the dataset
glimpse(ds_salaries)
## renaming the first column as it was wrongly named
names(ds_salaries)[1]<-"id"
## we do not need the id column because they are only serial numbers!
ds_salaries<-ds_salaries[c(2:12)]
## company_location and employee_residence are same column?
ds_salaries$employee_residence == ds_salaries$company_location
## How many N/A are in this dataset?
ds_salaries[!complete.cases(ds_salaries),] #no N/A is here!
## factorization:
ds_salaries<-ds_salaries %>%
  mutate_if(sapply(ds_salaries, is.character),as.factor)

glimpse(ds_salaries)
## making some symbols more readable
ds_salaries<- ds_salaries %>%
  mutate(experience_level = recode(experience_level,  EN = "Entry/Junior", 
                                   MI = "Mid-level", 
                                   SE = "Senior/Expert", 
                                   EX = "Executive"))%>% 
  mutate(employment_type = recode(employment_type,   PT = "Part Time", 
                                  FT = "Full Time", 
                                  CT = "Contract", 
                                  FL = "Freelance"))%>%  
  mutate(remote_ratio = recode_factor(remote_ratio,'0'= "Stationary", 
                                      '50' = "Partially remote", 
                                      '100' = "Remote"))
glimpse(ds_salaries)
## plotting starts
ds_salaries %>%
  ggplot(aes(remote_ratio))+
  geom_bar(binwidth=10,aes(fill=company_size),color="black") #data is not continuous so we use geom_bar
#geom_bar() is for both x and y-values are categorical data -- so there are spaces between two bars as x-values are factor with distinct levels. geom_histogram() is for one continuous data and one categorical data.

ds_salaries %>%
  ggplot(aes(remote_ratio,experience_level,color=experience_level))+
  geom_jitter()+
  geom_boxplot(size=1.2,alpha=0.5)









