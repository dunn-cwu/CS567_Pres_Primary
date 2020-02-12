setwd("C:\\Users\\Coder\\OneDrive\\Documents\\CS 567 Computational Stats\\CS567_Pres_Primary")
pdata<-read.csv("data/president_primary_polls.csv")

View(pdata[pdata$party == "DEM", c("question_id", "end_date", "candidate_name", "pct")])
