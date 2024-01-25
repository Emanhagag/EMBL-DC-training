3+4
weight_kg <- 55
<- 
My_weight <- 50
(My_weight <- 50)
2.2*weight_kg
Weight_lb <- 2.2*weight_kg
# values need update
Mass <- 47.5
Age <- 122
sqrt(9)
?round
round(1.234567,2)
round(2,3.34325)
weight <- c(50,60,70)
Animals <- c("mouse", "Rat","dog")
length(Animals)
Animals <- c(monkey, Animals)
str(Animals)
typeof(Animals)
#what happen in case: 
num_chr <- c(1,2,3,"a")
num_logical <- c(1,2,3,TRUE)
char_logical <- c("a","B","c",TRUE)
#logical -> numeric -> chr,
#and logical -> char
Animals[2]
Animals[c(1,2)]
more_animals <- Animals[c(1,2,3,2,1,3)]
weight_g <- c(56,70,80,92,12)
weight_g[weight_g>63 & weight_g<80]
#combine 2 logic
weight_g[weight_g>63 I weight_g<80]
#or
#<,>,==,!=,<=,>=,!(not)
Animals [Animals=="rat"]
#%in% find all elements to a vector of elements of our choice
Animals %in% c("rat,"frog")
#missing data =NA
#An example of avector with missing data 
height <- c(2,4,4,NA,6)
mean(hight)
# to remove NA
mean(height, na.rm=T)
height[!is.na(heigt)]
na.omit(height)
#Identfy which are missing data (is.na(height))
#omit the missing the data (na.om)
#complete ...???
heights<-c(63,69,65,NA,68,61,59,64)
median(heights,na(heights))
download.file(url = "https://ndownloader.figshare.com/files/2292169,
              destfile = "data_raw/portal_data_joined.csv")
              
