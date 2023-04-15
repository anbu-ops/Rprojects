Movie_dataframe<-read_csv("Movie_project_Udemy.csv")
head(Movie_dataframe)
str(Movie_dataframe)

Filtered_movie_dataframe<- Movie_dataframe %>%
  filter((Studio=="Buena Vista Studios"|Studio=="Fox"|
         Studio=="Paramount Pictures"|Studio=="Sony"|
         Studio=="Universal"|Studio=="WB")&
           (Genre == "action"|Genre == "adventure"|Genre == "animation"|Genre == "comedy"|Genre == "drama"
         ))
Filtered_movie_dataframe %>%
  head(20)


Filtered_movie_dataframe %>%
  ggplot(aes(Genre,`Gross % US`))+
  geom_jitter(aes(color=Studio,size=`Budget ($mill)`))+
  geom_boxplot(alpha=0.5)+
  ggtitle("Domestic Gross % by Genre")+
  theme(plot.title = element_text(color = "DarkBlue",size=30,hjust = 0.5),
        axis.title.x = element_text(color="green",size=20),
        axis.title.y = element_text(color="red",size=20),
        )


