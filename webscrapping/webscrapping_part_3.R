get_cast = function(Movie_url){
  Movie_page_initial = read_html(Movie_url)
  # Movie_page_initial = read_html("https://www.imdb.com/title/tt1201607/?ref_=adv_li_tt")  #for testing with one movie url
  Movie_url_final = (Movie_page_initial %>% html_nodes("a.ipc-metadata-list-item__icon-link") %>% html_attr("href"))[1] %>% paste("https://www.imdb.com",.,sep="")
  Movie_page_final = read_html(Movie_url_final)
  Cast_name = (Movie_page_final %>% html_nodes(".primary_photo+ td") %>% html_text2())[1:10] %>% paste(collapse = ",")
  return(Cast_name)
}
IMDB_TOP_100_ADVENTURE = data.frame() #assigning this blank data frame at the beginning of the loop and adding upon that at the end of the loop using 'rbind'.
# the below for loop will run using page_result as 1 and again using page_result as 51
for (page_result in seq(1,51,50)) { #seq(starting,end,difference b/w the 'end' and 'starting') 
  page= read_html(paste0("https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=adventure&sort=user_rating,desc&start=",page_result,"&ref_=adv_nxt"))
  Movie_name= page %>% html_nodes(".lister-item-header a") %>% html_text()
  #Movie_name
  Release_year= page %>% html_nodes(".text-muted.unbold") %>% html_text()
  #Release_year
  Rating= page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
  #Rating
  About_movie= page %>% html_nodes(".ratings-bar+ .text-muted") %>% html_text2() #html_text is not used here to remove the "/n" part.
  #About_movie
  Movie_url= page %>% html_nodes(".lister-item-header a") %>% html_attr("href") %>% paste("https://www.imdb.com",.,sep="")
  #Movie_url
  Movie_cast = sapply(Movie_url, FUN= get_cast,USE.NAMES = F) # if we do not use USE.NAMES = F then it will create an anonymous row at the beginning of the data frame which will contain all the movie urls
  IMDB_TOP_100_ADVENTURE = rbind(IMDB_TOP_100_ADVENTURE,data.frame(Movie_name,Release_year,Rating,About_movie,Movie_cast))
}

write.csv(IMDB_TOP_100_ADVENTURE,"webscrapping_part_3.csv")
