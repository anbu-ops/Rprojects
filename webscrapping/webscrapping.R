install.packages("rvest")
install.packages("dplyr")

link = "https://www.imdb.com/chart/top/"
page = read_html(link)
Movie_name = page %>% html_nodes(".titleColumn a") %>% html_text()
Movie_name
Release_year = page %>% html_nodes(".secondaryInfo") %>% html_text()
Release_year
Rating = page %>% html_nodes("strong") %>% html_text()
Rating

IMDB_RATINGS <- data.frame(Movie_name,Release_year,Rating)
nrow(IMDB_RATINGS)
#write_csv(IMDB_RATINGS,"webscrapping.csv")


?read_html
??html_text  #it picks up the text only from an HTML
