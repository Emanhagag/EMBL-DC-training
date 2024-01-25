library(tidyverse)

#survays <- read.csv("")
survays <- read_csv("data_raw/portal_data_joined.csv")
str(survays)

select(survays, plot_id, species_id,weight)
select(survays, -record_id, -species)


filter(survays, year==1995, sex=="M")


survays2 <- filter(survays, weight<5)


Survay3_select(filter(survays,weight<5),species_id,sex,weight)


survays %>%
  filter(weight<5) %>%
  select(species_id, sex, weight)

survays %>%
  filter(year<1995) %>%
  select(year,sex,weight)


survays %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg=weight/1000, Weight_lb=weight_kg*2.2)%>%
  head()

# grouping (groub_by)
survays %>%
  filter(!is.na(sex)) %>%
  group_by(sex) %>%
  summarise(mean_weight=mean(weight,na.rm = T))


survays %>%
  filter(!is.na(sex)) %>%
  group_by(sex,species_id) %>%
  summarise(mean_weight= mean(weight, na.rm = T)),min_weight = min(weight,na.rm = T)
 

# looking to number of dta

survays %>%
  count(sex, species)%>%
  arrange(species,desc(n))
survay_new <- survays %>%
  count(sex, species)%>%
  arrange(species,desc(n))

survays %>%
  count(plot_type)
 
  
  

survays %>%
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(
    mean_fl=mean(hindfoot_length,na.rm = T),
    min_fl=min(hindfoot_length),
    max_fl=max(hindfoot_length),
    n=n()
  )
  %>%
  view()


survays %>%
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight==max(weight)) %>% 
  select(year, genus, species_id, weight) %>% 
  arrange(year) %>% 
  unique()
 
#######


survay_gw <- survays %>% 
  filter(!is.na(weight)) %>% 
  group_by(plot_id,genus) %>% 
  summarise(mean_weight=mean(weight))

str(survay_gw)

survay_gw %>% 
  pivot_wider(names_from = genus, values_from = mean_weight, values_fill = 0)
 
#Error in `pivot_wider()`:
# Can't subset columns that don't exist.
# Column `genus` doesn't exist.
#Run `rlang::last_trace()` to see where the error occurred--solved


####(from wide to long formate)
survay_wide <- survay_gw %>% 
  pivot_wider(names_from = genus, values_from = mean_weight, values_fill = 0)

survay_wide %>% 
  pivot_longer(names_to ="genus", values_to = "mean_weight", cols=-plot_id)

survays_long <- survays %>% 
  pivot_longer(names_to = "measurmen", values_to = "value",cols = c(hindfoot_length,weight))

survays_long %>% 
  group_by(year, measurmen, plot_id) %>% 
  summarise(mean_value=mean(value,na.rm = T)) %>% 
  pivot_wider(names_from = measurmen,values_from = mean_value)

####

survay_complete <- survays %>% 
  filter(!is.na(weight),
       !is.na(hindfoot_length),
       !is.na(sex))
write_csv(survay_complete,file = "data_raw/surveys_complete.csv")

#### session_2

download.file(url= "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv") 
library(ggplot2)
ggplot()


ggplot(data=survay_complete, mapping = aes(x=weight,y=hindfoot_length))+
  geom_point()
plt <- ggplot(data=survay_complete, mapping = aes(x=weight,y=hindfoot_length))+
  geom_point()
plt+
  ggtitle("weight vs HFL")

install.packages("hexbin")
library(hexbin)
ggplot(data=survay_complete,mapping = aes(x=weight, y=hindfoot_length))+
  geom_hex()

ggplot(data=survay_complete, mapping = aes(x=weight,y=hindfoot_length))+
  geom_point(alpha= 0.1)
#alphe correspond to transparency 


ggplot(data=survay_complete, mapping = aes(x=weight,y=hindfoot_length))+
  geom_point(alpha= 0.1,color="blue")

ggplot(data=survay_complete, mapping = aes(x=weight,y=hindfoot_length))+
  geom_point(alpha= 0.1, aes(color=species_id))
ggplot(
  data = survay_complete,
  mapping = aes(
    x=weight,
    y=hindfoot_length,
    color=species_id
    )
)+
  geom_point(alpha=0.21)

#### scatterPlot of weight vs species name color by plot_type

ggplot(data=survay_complete, mapping = aes(y=weight, x=species_id, color=plot_id)) +
  geom_point()

#boxplot

ggplot(data=survay_complete, mapping = aes(y=weight, x=species_id)) +
  geom_boxplot()


ggplot(data=survay_complete, mapping = aes(y=weight, x=species_id)) +
  geom_boxplot()+
  geom_jitter()
#adding a little value for each x coord

ggplot(data=survay_complete, mapping = aes(y=weight, x=species_id)) +
  geom_jitter(alpha=0.3, color="salmon", fill=NA)+geom_boxplot(outlier.shape = NA,fill=NA)
#challenge (produce a volcano plot of weight by species_id)

ggplot(data = survay_complete,mapping = aes( x=species_id,
  y=weight)) +
  geom_jitter(volcano)
  
ggplot(data=survay_complete, mapping = aes(y=weight, x=species_id)) +
  geom_violin()+
  scale_y_log10()+
  ylab("weight(log10")

#chall_creat boxplot+jittered scatterplotof hindfootlength by species_id,boxplot infront of the dots and filled with white

ggplot(data=survay_complete, mapping = aes(y=hindfoot_length, x=species_id))+
  geom_jitter(alpha=0.2, aes(color=factor(plot_id)))+
  geom_boxplot()
# define color--1-by name or rgb(red=3,blue=..)

year_cont <- survay_complete %>% count(year,genus)
ggplot(data=yearly_cont,mapping = aes(x=year,
                                      y=n,
                                      color=genus))+geom_line()

yearly_count_graph <- survay_complete %>% count(year,genus)
ggplot(data=yearly_cont,mapping = aes(x=year,
                                      y=n,
                                      color=genus))+geom_line()


ggplot(data=yearly_cont, mapping = aes(x=year,
                                       y=n))+geom_line()+facet_wrap(facets = vars(genus))

survay_complete %>% count(year,genus,sex) %>% 
ggplot(data=survay_complete, mapping = aes(x=year, y=n, color= sex)) +
  geom_line()+
  facet_grid(cols=vars(genus))

#add mea comparison to ggplot..https://rpkgs.datanovia.com/ggpubr/

plt <- survay_complete %>%
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x=year,
      y=n,
      color = sex)) +
  geom_line() +
  facet_wrap(facet= vars(genus),
             scales = "free"
  ) +
  scale_color_manual(values = c("tomato", "dodgerblue"),
                     labels = c("female", "male"),
                     name = "Sex") +
  xlab("Years of observation") +
  ylab("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom", # "none"
    aspect.ratio = 1,
    axis.text.x = element_text(angle = 45,
                               hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank(),
    strip.background =  element_blank()
  )


survay_complete %>%
  count(year, genus, sex) %>%
  ggplot(
    mapping = aes(
      x=year,
      y=n,
      color = sex)) +
  geom_line() +
  facet_wrap(facet= vars(genus),
             scales = "free"
  ) +
  scale_color_manual(values = c("tomato", "dodgerblue"),
                     labels = c("female", "male"),
                     name = "Sex") +
  xlab("Years of observation") +
  ylab("Number of individuals") +
  ggtitle("Observed genera over time") +
  theme_bw(base_size = 14) +
  theme(
    legend.position = "bottom", # "none"
    aspect.ratio = 1,
    axis.text.x = element_text(angle = 45,
                               hjust = 1),
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank(),
    strip.background =  element_blank()
  )

dir.create("data")

# Download the data provided by your collaborator
# using a for loop to automate this step
for(i in c("counts_raw.csv", "counts_transformed.csv", "sample_info.csv", "test_result.csv")){
  download.file(
    url = paste0("https://github.com/tavareshugo/data-carpentry-rnaseq/blob/master/data/", i, "?raw=true"),
    destfile = paste0("data/", i)
  )
}