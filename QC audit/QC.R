QC<-readxl::read_xlsx("QC.xlsx")
View(QC)
nrow(QC)


Ankit<- QC %>%
  filter(QC$`Assigned To`== "banerjee ankit _xy37318_")


howManyDefectsHaveNoComments<-sum(is.na(QC$Comments))
DefectsHaveNoComments<-QC[!complete.cases(QC$Comments),]
View(DefectsHaveNoComments)


servicingAssociates <- c("banerjee ankit _xy37318_","saha souvik _xy37307_")
servicingDefects <- QC %>%
  filter(QC$`Assigned To` %in% servicingAssociates)

QC %>%
  filter(QC$`Defect ID`=='16322')

names(QC)
QC %>%
  ggplot(aes(Project))+
  geom_bar(binwidth=10,aes(fill=Severity),color="black")
  