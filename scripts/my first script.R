#data.frames
#Let´s import some data 
download.file(url="https://ndownloader.figshare.com/files/229216",destfile="data_raw/portal_data_joined.csv")
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")
library(tidyverse)
survays <- read_csv("data_raw/portal_data_joined.csv")
head(survays)
#read.table(you mention which separator is used)
#A tibble 
view(survays)
#shows a full table in the script 
#Dataframe -> collection of vectors..in column, each column is  a vector 
#data in each column must be same type (ch,numeric,logic)
#
#
str(survays)

#dimention of table, raws,colums
dim(survays)
nrow(survays)
tail(survays)
#last raws
#column names
names(survays)
#statistic info of numeric column, and length of chr.columns.
summary(survays)
#Index and subsetting
survays[1,6]
#1st raw ,6th column 
survays[1,]
survays[ ,1]
survays[c(1,2,3),c(5,6)]
#extracts the intersection of these columns and raws
survays[1:3,5:6]
survays[,-1]


survays["sex"]
survays$plot_id
survays[plot_id]
#challange
survays[200,]
nrow(survays)
survays[34786,]
tail(survays)
raw(c(200))
nrow(survays)/2
survays[nrow(survays)/2, ]

#Factors
str(survays)
#diffrence between categories or ch data----R deals with it as factors
#creating a factor (limitted number of variances ex sex)
#or if you have lemitted no. of species 
survays$sex <- factor(survays$sex)
survays$sex

levels(survays$sex)
nlevels(survays$sex)
#sex <- factor
survays$taxa<-factor(survays$taxa)
nlevels(survays$taxa)
survays$genus <-  factor(survays$genus)
nlevels(survays$genus)
summary(survays)
sum(survays$taxa=="Rabbit")

#convert a factor
as.character(survays$sex)

#what if the factor is numeric---ex year num
# Renaming factors
plot(survays$sex)
summary(survays$sex)
sex<-survays$sex
leves(sex)
sex<-addNA(sex)
levels(sex)

#change NA to undetermined 
levels(sex)[3]<-"undetermined"
plot(sex)

levels(sex)
levels(sex)[1:2]<-c("female","male")
plot(sex)
sex<-factro(sex,level=)