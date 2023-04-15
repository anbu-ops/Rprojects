Job_list<- read_csv("Job_list.csv")

head(Job_list)

summary(Job_list)

Job_list %>%
  sapply(is.numeric) #nothing numeric here!

Job_list$timestamp<-as.POSIXct(Job_list$timestamp,format="%Y-%m-%d")

#-------------job_type-------------
length(grep("(.*)Full-time(.*)",Job_list$job_type))
Job_list[(grep("\"Full-time\"",Job_list$job_type)),]
gsub("(.*)Full-time(.*)","Full-time",Job_list$job_type)

now()


strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12")
strings
grep("ab.", strings, value = TRUE)
grep("ab[c-e]", strings, value = TRUE)
grep("ab[^c]", strings, value = TRUE)
grep("^ab", strings, value = TRUE)
grep("\\^ab", strings, value = TRUE)
grep("abc|abd", strings, value = TRUE)
