library(ggplot2)

setwd("C:\\Users\\Coder\\OneDrive\\Documents\\CS 567 Computational Stats\\CS567_Pres_Primary")

theme_set(
  theme_bw() +
    theme(legend.position = "top")
)

filterOutCandidate<-function(df, canID, pollsterID) {
  df<-df[df$candidate_id == canID & df$pollster_id == pollsterID, c("end_date", "pct")]
  df<-setNames(aggregate(df[, 2], list(df$end_date), mean), c("end_date", "pct"))
  return (df)
}

# Load data set from csv file
pdata<-read.csv("data/president_primary_polls.csv", header = TRUE)

# Filter out democrats and needed columns
pdata_dem<-pdata[pdata$party=="DEM", c("question_id", "poll_id", "pollster_id", "fte_grade", "end_date", "candidate_id", "candidate_name", "pct")]

# Replace blank cells with NA
pdata_dem[pdata_dem == ""] = NA

# Filter out all polls that are rated worse than A-
pdata_dem<-subset(pdata_dem, fte_grade == 'A+' | fte_grade == 'A' | fte_grade == 'A-')

# Replace data strings with date data type
pdata_dem$end_date <- as.Date(pdata_dem$end_date, format = "%m/%d/%y")

# Sort dataframe by poll end date, question id, and candidate id
pdata_dem<-pdata_dem[order(pdata_dem$end_date, pdata_dem$question_id, pdata_dem$candidate_id),]
View(pdata_dem)

# Get poll data for sanders
sanders<-filterOutCandidate(pdata_dem, 13257, 1102)
View(sanders)

# Get poll data for biden
biden<-filterOutCandidate(pdata_dem, 13256, 1102)
View(biden)

# Plot sanders polls
ggplot() +
  geom_line(data=sanders, aes(x=end_date, y=pct), size = 1, color = "darkred") +
  #geom_point(data=sanders, aes(x=end_date, y=pct, group=1)) +
  geom_line(data=biden, aes(x=end_date, y=pct), size = 1, color = "steelblue") +
  #geom_point(data=biden, aes(x=end_date, y=pct, group=1)) +
  ggtitle("Bernie Sanders Percent of Support") +
  labs(y="Percent", x="Date")
