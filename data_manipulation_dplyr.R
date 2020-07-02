## data manipulation with dplyr
## four basic verbs of data manipulation
## select,filter,arrange,mutate
library(dplyr)
## first we will learn select verb
## with this verb you can select columns you need in the dataset
selected_variables<-counties%>%
  select(state,county,region,population,unemployment)
## if you want to select colomuns in sequence
## like i want to select from 1 to 6 columns 
counties%>%
  select(state:women)
## See with this i have selected required four variables only
## if you want to preview dataset
glimpse(selected_variables)
## filter and arrange verbs
## arrange verb can be used to sort data based on one or two variables variable
## like in this dataset we will arrange data according to population
selected_variables%>%
  arrange(population)
## you can also arrange according to descending order
selected_variables%>%
  arrange(desc(population))
## filter can be used to extract particular observations based on some condition
## like i want to extract all the observations related to california state only
selected_variables%>%
  filter(state=="California")
## extracting based on two conditions
test<-selected_variables%>%
  filter(state==c("California","New York"))
## filter can be used to apply numerical condition and can be used twice
selected_variables%>%
  filter(state=="California")%>%
  filter(population>1000000)
## using multiple verbs to gether
selected_variables%>%
  arrange(population)%>%
  filter(population>1000000,state=="New York")
## mutate verb to add new variable or change existing variable
## adding a new variable
selected_variables%>%
  mutate(unemployment_pop=population*unemployment/100)
### Now we will learn how to aggregate data
## first count verb
## count will count number of observations 
count(selected_variables)
## like following function will count how many times each state name appread in the data
## which represents counties, So n represent how much counties in each state
selected_variables%>%
  count(state)
## counting and sorting count often comes with sort
## which will sort the data in descending order
selected_variables%>%
  count(state,sort=T)
## count according to population of a state
selected_variables%>%
  count(state,sort=TRUE,wt=population)
##The summarize() verb is very useful for collapsing a large dataset into a single observation.
selected_variables%>%
  summarise(sum(population))
selected_variables%>%
  summarise(sum(population),mean(unemployment))
## to summarise few selecte columns
selected_variables%>%
  summarise_at(population,unemployment)
## group_by  is very useful verb
## it is often used with summarize
## suppose i want to get the population of every state
selected_variables%>%
  group_by(state)%>%
  summarise(sum(population))
## lets work with covid data
covid_data<-COVID_19_geographic_disbtribution_worldwide%>%
  group_by(countriesAndTerritories)%>%
  summarise(sum(cases))
counties_selected <- counties %>%
  select(region, state, county, population)
counties_selected%>%
  group_by(state,region)%>%
  summarise(sum(population))
## top_n verb is often used to select exterme observations
## suppose i want to select county with maximum population in each state
## I can do this with following example
selected_variables%>%
  group_by(state)%>%
  top_n(population,n=1)
## suppose in covid dataset i want to know day with maximum cases in single day
COVID_19_geographic_disbtribution_worldwide%>%
  group_by(countriesAndTerritories)%>%
  top_n(cases,n=1)
## top 10 countries with maximum number of deaths
top_10<-COVID_19_geographic_disbtribution_worldwide%>%
  group_by(countriesAndTerritories)%>%
  summarise(totaldeaths=sum(deaths))%>%
  top_n(totaldeaths,n=10)%>%
  arrange(desc(totaldeaths))
top_10
## more selecting options
## selected counties that contains "work" character in their name
counties%>%
  select(state,county,contains("work"))
## selected counties that start with income
counties%>%
  select(state,county,starts_with("income"))
## similiarly you can also use end_with verb
## removing a variable from dataset use -
## like i want to remove population column
counties%>%
  select(-population)
## extracting selected rows
## extracting first 25 rows
counties%>%
  slice(1:25)
## selecting and adding new columns simulatnously
## transmtate can solve your problem
counties%>%
  transmute(state,county,unemploy_ab=population*unemployment/100)
## renaming a column
counties%>%
  rename(province=state)
## notice that new column name came at left side
