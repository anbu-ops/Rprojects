summary(iris)
sepal_length_5.1<-iris %>%
  filter(iris$Sepal.Length == 5.1) %>%
  nrow()


View(mtcars)
-----------------# Goal is to set a column name for the first UNNAMED column which is technically known as rownames-------------------------
modelname<-rownames(mtcars)  # map the rownames into a new Vector

mtcars$modelname<-modelname  # add a new column using that Vector

rownames(mtcars)<- NULL      # set the rownames as NULL

modified_mtcars<-select(mtcars,modelname,everything())  # rearrange the column names
---------------------------------------------------------------------------------------------

modified_mtcars %>% select(one_of(c("mpg","cyl","garbage")))

data("flights")

head(mtcars,8)
  
head(iris)
unique(iris$Species)
iris<-iris %>% as_factor(iris$Species)
iris<- as_tibble(iris)  
  
  
  

mea