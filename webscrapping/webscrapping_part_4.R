# in previous notes we had done webscrapping using selectorGadget we have made separate columns for everything and finally build our DataFrame If there is table there is another way!



#-------All iphones--------
iphonePage = read_html("https://en.wikipedia.org/wiki/IPhone")
iphoneTable = iphonePage %>% html_nodes(".wikitable") %>% .[2] %>% html_table() %>% .[[1]] 
iphoneTable_crude = data.frame(iphoneTable)
iphoneTable_final<-iphoneTable_crude[3:26,1:9]
