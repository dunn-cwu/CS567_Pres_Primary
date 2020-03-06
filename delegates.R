library(ggplot2)
library(viridis)
library(dplyr)
library(hrbrthemes)

#setting the working directory for loading the dataset
setwd("C:\\Users\\phanho\\Desktop\\Project1cs565\\CS567_Pres_Primary")
contestantData <- read.csv("Delegates.csv")
States<-contestantData$States

#Creating daaframe
data <-data.frame(States,contestantData$Candidates,contestantData$Delegates)
sum_count <- contestantData %>% group_by(Candidates) %>% summarise(max_pos = sum(Delegates))

dev.new(width=6, height=6, unit="in")
ggplot(data, aes(fill=States, y=contestantData$Delegates, x=contestantData$Candidates)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_manual(values=c("dimgray", "seagreen", "maroon", 'midnightblue', "#808000", "orangered", "orange" ,"mediumblue", "chartreuse" ,"mediumorchid" ,"#00FFFF",'#F08080', '#ff00ff', 'dodgerblue', 'palegoldenrod','#ffff54', 'palegreen', 'lightskyblue'))+
  #scale_fill_viridis_d(alpha = 1, begin = 0, end = 1, direction = 1, option = "D", aesthetics = "fill") +
  ggtitle("Number of Delegates Awarded for Presidential Candidates") + theme_ipsum() +
  xlab("Presidential Candididates") + ylab("Number of Delegates") +
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        axis.title.x = element_text(hjust = 0.5, size = 13, face = "bold" ),
        axis.title.y = element_text(hjust = 0.5, size = 13, face = "bold" ))+
  #geom_text(aes(label = contestantData$Delegates, y=contestantData$Delegates), size = 3, position = position_stack(vjust = 0.5)) +
  annotate("text", x = 1:5, y = sum_count$max_pos + 10, label = sum_count$max_pos, size = 4, face = "bold")

