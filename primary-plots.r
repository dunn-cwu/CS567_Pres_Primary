library(ggplot2)

setwd("C:\\Users\\Coder\\OneDrive\\Documents\\CS 567 Computational Stats\\CS567_Pres_Primary")

pdata<-read.csv("data/president_primary_polls.csv", header = TRUE)
View(pdata)

sanders<-pdata[pdata$candidate_id == 13257, 
               c("question_id", "end_date", "candidate_id", "candidate_name", "pct")]

sanders$end_date <- as.Date(sanders$end_date , format = "%m/%d/%y")
sanders<-sanders[order(sanders$end_date ),]
View(sanders)

sanders_pct<-setNames(aggregate(sanders[, 5], list(sanders$end_date), mean), c("end_date", "pct"))
View(sanders_pct)

# df[order(df$State,df$Mortality.Rate,df$Hospital.Name),]
sanders_pct_sorted<-sanders_pct[order(sanders_pct$end_date),]
View(sanders_pct_sorted)

ggplot(data=sanders_pct, aes(x=end_date, y=pct, group=1)) +
  geom_line()+
  geom_point()+
  ggtitle("Bernie Sanders Percent of Support")+
  labs(y="Percent", x="Date")