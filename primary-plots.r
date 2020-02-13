library(ggplot2)

setwd("C:\\Users\\Coder\\OneDrive\\Documents\\CS 567 Computational Stats\\CS567_Pres_Primary")

pdata<-read.csv("data/president_primary_polls.csv", header = TRUE)
View(pdata)

# Filter by sanders and specific poll
sanders<-pdata[pdata$candidate_id == 13257 & pdata$pollster_id == 1102, 
               c("question_id", "pollster_id", "fte_grade", "end_date", "candidate_id", "candidate_name", "pct")]

# Replace blank cells with NA
sanders[sanders == ""] = NA

# Filter out all polls that are rated worse than A-
sanders<-subset(sanders, fte_grade == 'A+' | fte_grade == 'A' | fte_grade == 'A-')

# Replace data strings with date data type
sanders$end_date <- as.Date(sanders$end_date , format = "%m/%d/%y")

# Sort dataframe by date
sanders<-sanders[order(sanders$end_date ),]
View(sanders)


# Aggregate dataframe by end_date (group by date and average out pct)
sanders_pct<-setNames(aggregate(sanders[, 7], list(sanders$end_date), mean), c("end_date", "pct"))
View(sanders_pct)

# df[order(df$State,df$Mortality.Rate,df$Hospital.Name),]
# sanders_pct_sorted<-sanders_pct[order(sanders_pct$end_date),]
# View(sanders_pct_sorted)

# Plot sanders polls
ggplot(data=sanders_pct, aes(x=end_date, y=pct, group=1)) +
  geom_line()+
  geom_point()+
  ggtitle("Bernie Sanders Percent of Support")+
  labs(y="Percent", x="Date")