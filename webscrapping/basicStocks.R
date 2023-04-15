stocksPage = read_html("https://www.tickertape.in/screener/equity")

Name = stocksPage %>% html_nodes(".highlight-onhover") %>% html_text2()
Name
subSector = stocksPage %>% html_nodes(".ellipsis.desktop--only") %>% html_text2()
subSector
marketCap = stocksPage %>% html_nodes(".mrktCapf-col .screener-cell") %>% html_text2()
marketCap<- marketCap[seq(1,40,2)]
marketCap
closePrice = stocksPage %>% html_nodes(".lastPrice-col .screener-cell") %>% html_text2()
closePrice<- closePrice[seq(1,40,2)]
PERatio = stocksPage %>% html_nodes(".apef-col .screener-cell") %>% html_text()
PERatio<- PERatio[seq(1,40,2)]

BASIC_STOCKS = data.frame(Name,subSector,marketCap,closePrice,PERatio)
write.csv(BASIC_STOCKS,"basicStocks.csv")
