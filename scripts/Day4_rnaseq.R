


# Create a "data" directory
dir.create("data_rnaseq")

# Download the data provided by your collaborator
# using a for loop to automate this step
for(i in c("counts_raw.csv", "counts_transformed.csv", "sample_info.csv", "test_result.csv")){
  download.file(
    url = paste0("https://github.com/tavareshugo/data-carpentry-rnaseq/blob/master/data/", i, "?raw=true"),
    destfile = paste0("data_rnaseq/", i)
  )
}

library(tidyverse)
# read the data
raw_cts <- read_csv("./data_rnaseq/counts_raw.csv")
trans_cts <- read_csv("./data_rnaseq/counts_transformed.csv")
sample_info <- read_csv("./data_rnaseq/sample_info.csv")
test_result <- read_csv("./data_rnaseq/test_result.csv")

# "gather" the counts data
trans_cts_long <- trans_cts %>% 
  pivot_longer(cols = wt_0_r1:mut_180_r3, 
               names_to = "sample", 
               values_to = "cts")


trans_cts_long <- full_join(trans_cts_long,sample_info, by= "sample") 

trans_cst_long %>% 
  ggplot(aes(x=cts))+
  geom_freqpoly()

trans_cts_long %>% 
  ggplot(aes(x=cts,colour=replicate))+
  geom_freqpoly(binwidth=1)+
  facet_grid(rows = vars(strain), cols= vars(minute))


# how to separate blot by strain and min --Facet_grid (since we kno)

raw_cts_long <- raw_cts %>% 
  pivot_longer(cols = wt_0_r1:mut_180_r3, names_to = "sample",values_to ="cts")
raw_cts_long <- full_join(raw_cts_long, sample_info, by="sample" )


raw_cts_long %>% 
  ggplot(aes(x=cts,colour=replicate))+
  geom_freqpoly()+
  facet_grid(rows=vars(strain), cols=vars(minute))+
  scale_x_log10()

log10(0)
log10(1)

raw_cts_long %>% 
  ggplot(aes(x=cts,colour=replicate))+
  geom_freqpoly()+
  facet_grid(rows=vars(strain), cols=vars(minute))+
  scale_x_log10()


log10(1)

raw_cts_long %>% 
  ggplot(aes(x=cts,colour=replicate))+
  geom_freqpoly(binwidth=1)+
  facet_grid(rows=vars(strain), cols=vars(minute))+
  scale_x_log10()
# boxplot instead of freqpoly


raw_cts_long %>% 
 ggplot(aes(x=factor(minute),y=log10(cts+1),fill=strain))+
 geom_boxplot()+
  facet_grid(cols = vars(replicate))

##correlation , or comarison between samples
#scatterplot wt0 and wt_30 min
# correlation between wt samples at T0 and T30
#is better to use the wide table for ths

trans_cts %>% 
  ggplot(aes(x=wt_0_r1,y=wt_30_r1)) +
  geom_point()+
  geom_abline(colour="red")



trans_cts %>% 
  ggplot(aes(x=wt_0_r1,y=wt_0_r2)) +
  geom_point()+
  geom_abline(colour="red")

##to look at the correlation of count data across al samples in our experiment

trans_cts_crr <- trans_cts %>% 
  select(-gene) %>% 
  cor(method = "spearman")

# how to visualize_  PCA, correlation matrix_heatmap  

#heatmap

library(corrr)

install.packages("corrr")
library(corrr)

rplot(trans_cts_crr)+
  theme(axis.text.x = element_text(angle = 45,hjust=1))


#compare trans_cts and raw_cts
summary(raw_cts_long$cts)
summary(trans_cts_long$cts)

raw_cts %>% 
  ggplot(aes(x=wt_0_r1,y=wt_0_r2))+
  geom_point()


raw_cts %>% 
  ggplot(aes(x=wt_0_r1+1,y=wt_0_r2+1))+
  geom_point()+
  scale_x_continuous(trans = "log2")+
  scale_y_continuous(trans = "log2")
# mean of the counts and variance x axix
# need to work on long formate .. to bre able to group


raw_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts=mean(cts),var_cts=var(cts)) %>% 
  ggplot(aes(x=mean_cts,y=var_cts))+
  geom_point()+
  geom_abline(colour="red")+
  scale_x_continuous(trans = "log2")+
  scale_y_continuous(trans="log2")

#deseq2----package for RNA-seq analysis


trans_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts=mean(cts),var_cts=var(cts)) %>% 
  ggplot(aes(x=mean_cts,y=var_cts))+
  geom_point()

# just to try to add information for colour..
trans_cts_long %>% 
  group_by(gene) %>% 
  summarize(mean_cts=mean(cts),var_cts=var(cts)) %>% 
  mutate(above_four=var_cts>4) %>% 
  ggplot(aes(x=mean_cts,y=var_cts,color=above_four))+
  geom_point()


####session 2
##PCA--- Dimentionality reduction method...(how much is the variation in certain gene , how much it contributes to expe

library(tidyverse)
