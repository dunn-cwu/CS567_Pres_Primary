library(ggplot2)
library(dplyr)
library(lubridate)

setwd("C:\\Users\\Coder\\OneDrive\\Documents\\CS 567 Computational Stats\\CS567_Pres_Primary")

theme_set(
  theme_bw() +
    theme(legend.position = "top")
)

filterOutCandidate<-function(df, canID, pollsterID) {
  if (pollsterID == 0)
  {
    df<-df[df$candidate_id == canID, c("end_date", "pct")]
  }
  else 
  {
    df<-df[df$candidate_id == canID & df$pollster_id == pollsterID, c("end_date", "pct")]
  }
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

# Filter out date range
pdata_dem<-pdata_dem[pdata_dem$end_date >= "2020-01-01",]

# Sort dataframe by poll end date, question id, and candidate id
pdata_dem<-pdata_dem[order(pdata_dem$end_date, pdata_dem$question_id, pdata_dem$candidate_id),]
View(pdata_dem)

# Use poll 1102 or 0 for all polls
poll<-0

# Get poll data for sanders
sanders<-filterOutCandidate(pdata_dem, 13257, poll)

# Get poll data for biden
biden<-filterOutCandidate(pdata_dem, 13256, poll)

# Get poll data for biden
bloomberg<-filterOutCandidate(pdata_dem, 13289, poll)

# Get poll data for buttigieg
buttigieg<-filterOutCandidate(pdata_dem, 13345, poll)

# Get poll data for buttigieg
warren<-filterOutCandidate(pdata_dem, 13258, poll)

#spline.d <- as.data.frame(spline(sanders$end_date, sanders$pct))
#spline.d$x <- as.Date(spline.d$x, origin = "1970-01-01")

# Set plot line size
lineSize<-1
d_election=data.frame(date=as.Date(c("2020-02-03", "2020-02-11", "2020-02-22")), event=c("Iowa Caucus", "New Hampshire Primary", "Nevada Caucus"))
d_debate=data.frame(date=as.Date(c("2020-02-07", "2020-02-19")), event=c("8th Presidential Debate", "9th Presidential Debate"))
# Plot sanders polls
ggplot() +
  geom_line(data=sanders, aes(x=end_date, y=pct, color="san"), size = lineSize) +
  # geom_point(data=sanders, aes(x=end_date, y=pct, group=1)) +
  geom_line(data=biden, aes(x=end_date, y=pct, color="bid"), size = lineSize) +
  # geom_point(data=biden, aes(x=end_date, y=pct, group=1)) +
  geom_line(data=bloomberg, aes(x=end_date, y=pct, color="bloom"), size = lineSize) +
  geom_line(data=buttigieg, aes(x=end_date, y=pct, color="butt"), size = lineSize) +
  geom_line(data=warren, aes(x=end_date, y=pct, color="war"), size = lineSize) +
  #geom_vline(xintercept = "2020-02-03", linetype="dotted", color = "blue", size=1.5) +
  #geom_vline(xintercept = as.numeric(as.Date("2020-02-03")), size=1, linetype=4) +
  #geom_vline(xintercept = as.numeric(as.Date("2020-02-11")), size=1, linetype=4) +
  #geom_vline(xintercept = as.numeric(as.Date("2020-02-22")), size=1, linetype=4) +

  geom_vline(data=d_election, mapping=aes(xintercept=date), color="red") +
  geom_text(data=d_election, mapping=aes(x=date, y=0, label=event), size=4, angle=90, vjust=-0.4, hjust=0.15) +
  geom_text(data=d_election, mapping=aes(x=date, y=0, label=date), size=4, angle=90, vjust=1.1, hjust=0.15) +
  geom_vline(data=d_debate, mapping=aes(xintercept=date), color="blue") +
  geom_text(data=d_debate, mapping=aes(x=date, y=0, label=event), size=4, angle=90, vjust=-0.4, hjust=0.15) +
  geom_text(data=d_debate, mapping=aes(x=date, y=0, label=date), size=4, angle=90, vjust=1.1, hjust=0.15) +

  scale_color_discrete(name = "Candidate", labels = c("Biden", "Bloomberg", "Buttigieg", "Sanders", "Warren")) +
  #geom_line(data = spline.d, aes(x = x, y = y), size = 1)
  ggtitle("Candidate Support Over Time") +
  labs(y="Percent", x="Date") +
  theme(legend.position="bottom")
