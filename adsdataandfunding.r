require(readxl)
library(ggplot2)


setwd('C:\\Users\\phanho\\Desktop\\Project2ComputerStatistic')
data = read_xlsx("Adspending.xlsx",range ='A2:B11', col_names = c("candidate", "spending"))
x<- data[['candidate']]
y<- data[['spending']]


xx<-barplot(y,names.agr =x,xaxt ='n',ylim =c(0,350),ylab ='Money spends on TV Ads in Millions', width = 0.4,col ='orange',
            main = "Money spends on Ads for democratic Candidates", border ='blue')
text(x= xx, y= y,labels =y, pos =3 , cex=0.8 ,col ='red')
axis(1, at =xx, labels = x, tick=FALSE, las= 2, line =-0.8,cex.axis =1)






##############################################################

setwd('C:\\Users\\phanho\\Desktop\\Project2ComputerStatistic')
data = read_xlsx("Adspending.xlsx",range ='F1:I9')
data$NewHampshire

###########################IOWA
y1<- data[['Iowa']]
x1<- data[['candidate']]
xx1<-barplot(y1,names.agr =x1,xaxt ='n',ylim =c(0,20000),ylab ='Money spends on TV Ads in Thousands', width = 0.4,col ='orange',
            main = "Money spends on Ads for democratic Candidates in IOWA", border ='blue')
text(x= xx1, y= y1,labels =y1, pos =3 , cex=0.8 ,col ='red')
axis(1, at =xx1, labels = x1, tick=FALSE, las= 2, line =-0.8,cex.axis =1)
####################################New Hamshire

y2<- data$NewHampshire
print(y2)

xx2<-barplot(y2, names.agr =x1,xaxt ='n',ylim =c(0,4000),ylab ='Money spends on TV Ads in Thousands', width = 0.4,col ='orange',
             main = "Money spends on Ads for democratic Candidates in New Hampshire", border ='blue')
text(x= xx2, y= y2,labels =y2, pos =3 , cex=0.8 ,col ='red')
axis(1, at =xx2, labels = x1, tick=FALSE, las= 2, line =-0.8,cex.axis =1)


y3<- data$Nevada


xx3<-barplot(y3, names.agr =x1,xaxt ='n',ylim =c(0,12000),ylab ='Money spends on TV Ads in Thousands', width = 0.4,col ='orange',
             main = "Money spends on Ads for democratic Candidates In Nevada", border ='blue')
text(x= xx3, y= y3,labels =y3, pos =3 , cex=0.8 ,col ='red')
axis(1, at =xx3, labels = x1, tick=FALSE, las= 2, line =-0.8,cex.axis =1)




