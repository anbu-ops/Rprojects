WP<-read_csv("world_population.csv")
names(WP)
head(WP)
WP[!complete.cases(WP),]
WP<-WP %>%
  mutate_if(
    sapply(WP, is.character),as.factor
  )
names(WP)[6:17]<- c("2022_pop","2020_pop","2015_pop","2010_pop","2000_pop","1990_pop","1980_pop","1970_pop","Area","Density","Growth_Rate","world_population_Percentage")
names(WP)[2]<- c("abbreviation")
names(WP)
?arrange
WP<-WP[,c(1,3,2,4,5,13,12,11,10,9,8,7,6,14,15,16,17)]

AFRICA<-WP %>%
  filter(Continent == "Africa")
mean(AFRICA$`2022_pop`)

WP %>%
  select()


#Countries-with-The-Highest-Population-in-2022
WP %>%
  select(Country,abbreviation,Continent,`2022_pop`) %>%
  arrange(desc(`2022_pop`))
#Country-With-The-Highest-Population-in-Each-Continent
x<-WP %>%
  select(Country,Continent,`2022_pop`) %>%
  group_by(Continent)

head(x,20)


#------Provide us an overview that how many rows are there for each unique entry-----
WP %>%
  count(Continent)
#--------- Provide us how many types are entries are there in a column -----------
WP %>%
  distinct(Continent)




