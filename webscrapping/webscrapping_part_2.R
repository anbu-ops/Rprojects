# nested html/link: which will help us to scrap from a hyperlink inside a webpage

page= read_html("https://www.imdb.com/search/title/?genres=adventure&sort=user_rating,desc&title_type=feature&num_votes=25000,&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=5aab685f-35eb-40f3-95f7-c53f09d542c3&pf_rd_r=V2SV333RSF1H13Z2AB2Q&pf_rd_s=right-6&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_gnr_2")

Movie_name= page %>% html_nodes(".lister-item-header a") %>% html_text()
Movie_name
Release_year= page %>% html_nodes(".text-muted.unbold") %>% html_text()
Release_year
Rating= page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
Rating
About_movie= page %>% html_nodes(".ratings-bar+ .text-muted") %>% html_text2() #html_text is not used here to remove the "/n" part.
About_movie
Movie_url= page %>% html_nodes(".lister-item-header a") %>% html_attr("href") %>% paste("https://www.imdb.com",.,sep="")
Movie_url

get_cast = function(Movie_url){
  Movie_page_initial = read_html(Movie_url)
  # Movie_page_initial = read_html("https://www.imdb.com/title/tt1201607/?ref_=adv_li_tt")
  Movie_url_final = (Movie_page_initial %>% html_nodes("a.ipc-metadata-list-item__icon-link") %>% html_attr("href"))[1] %>% paste("https://www.imdb.com",.,sep="")
  Movie_page_final = read_html(Movie_url_final)
  Cast_name = (Movie_page_final %>% html_nodes(".primary_photo+ td") %>% html_text2())[1:10] %>% paste(collapse = ",")
  return(Cast_name)
}

Movie_cast = sapply(Movie_url, FUN= get_cast,USE.NAMES = F) # if we do not use USE.NAMES = F then it will create an anonymous row at the begoinning of the data frame which will contain all the movie urls
#?sapply
#typeof(Cast_name)

IMDB_TOP_50_ADVENTURE <- data.frame(Movie_name,Release_year,Rating,About_movie,Movie_cast)
write.csv(IMDB_TOP_50_ADVENTURE,"webscrapping_part_2.csv")
