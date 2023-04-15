library(readr)
musicBoard = read_csv("charts.csv")

musicBoard %>% head(10)

#-------------------------------------------------------
# for column operation we can use select(),mutate() etc.
musicBoard %>% select("date","rank","weeks-on-board")
# until and unless we are storing the data will not be replaced with mucicBoard's data.

musicBoard %>% 
  select(date:artist,week_popular="weeks-on-board") %>%
  mutate(is_colab = grepl("Featuring",artist)) %>% #grepl is taking the string upon which it will check in artist column where featuring is present on artist column and according to that it sets the is_colab column as boolean value.   
  select(artist,is_colab,everything()) #everything means all other columns

#-------------------------------------------------------

#for row operation we can use filter(),distinct(),arrange() etc.
musicBoard %>%
  select(date:artist,"weeks-on-board") %>%
  filter(artist=="Ed Sheeran") 

musicBoard %>%
  select(date:artist,week_popular="weeks-on-board") %>%
  filter((artist=="Ed Sheeran" | artist=="Drake") & week_popular >= 10) %>%
  distinct(song)  #returns as a dataframe

musicBoard %>%
  select(date:artist,week_popular="weeks-on-board") %>%
  filter((artist=="Ed Sheeran" | artist=="Drake") & week_popular >= 10) %>%
  distinct(song) %>%
  .$song #returns as a vector 

#-------------------------------------------------------

#for group group_by(),summarize(),count()
musicBoard %>%
  select(date:artist,week_popular="weeks-on-board") %>%
  filter(artist=="Ed Sheeran" | artist=="Drake") %>%
  group_by(song) %>%
  summarise(total_weeks_popular=max(week_popular)) %>%
  arrange(desc(total_weeks_popular))
