library(plotly)
library(dplyr)
## plotly2
## first review the concepts 
## we will work with world happiness report
X2016%>%
  plot_ly(x=~`Health (Life Expectancy)`,y=~`Happiness Rank`)%>%
  add_markers()
## adding color in it
X2016%>%
  plot_ly(x=~`Health (Life Expectancy)`,y=~`Happiness Rank`)%>%
  add_markers(color=~Region)
## adding size in it
X2016%>%
  plot_ly(x=~`Health (Life Expectancy)`,y=~`Happiness Rank`)%>%
  add_markers(size=~`Economy (GDP per Capita)`)
## polishing the plot
happy %>%
  plot_ly(x = ~social.support, y = ~happiness,
          hoverinfo = "text",
          text = ~paste("Country: ", country,
                        "<br> Income: ", income,
                        "<br> Happiness: ", round(happiness, 2),
                        "<br> Social support: ", round(social.support, 2))) %>%
  add_markers(symbol = ~income, 
              symbols = c("circle-open", "square-open", "star-open", "x-thin-open")) %>%
  layout(xaxis = list(title = "Social support index"),
         yaxis = list(title = "National happiness score"))
## moving beyond simple interactivty
## working with us economy
## taking 2014 data
library(dplyr)
library(tidyr)
data_2014<-state_economic_data%>%
  filter(year==2014)
state_economic_data %>%
  filter(year == 2017) %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(size = ~population, 
              color = ~region, 
              marker = list(sizemode = "diameter"))
## creating a time series graph plotting multiple timeseries
test<-state_economic_data %>%
  filter(year >= 2000) %>%
  group_by(state) %>%
  plot_ly(x = ~year, y = ~house_price) %>%
  add_lines()
## animated graphs
## we use frame argument 
## like we want to see how relationship between carbon emmision and gdp has changed over time
## first frame should be time
## ids should be country to ensure consistency of the data
## creating animated bubble graph
state_economic_data %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(size = ~population, color = ~region, 
              frame = ~year, ids = ~state,
              marker = list(sizemode = "diameter"))
## time is not only element on frame you can take any element
# Animate a bubble chart of house_price against gdp over region
ani<-state_economic_data%>%
  filter(year == 2017) %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(size = ~population, color = ~region, 
              frame = ~region, ids = ~state,
              marker = list(sizemode = "diameter"))
## polishing animations
## animation options
## frame ## decide the total time between the frames including trasition
## transition decide the pause between two frames
# Adjust the frame and transition
ani %>% 
  animation_opts(frame = 2000, transition = 300)
## you can also change animation slider
ani%>%
  animation_slider(currentvalue=list(prefix=NULL,font=list(color="red")))
## removing animation slider
ani%>%
  animation_slider(hide = T)
## layering in plotly
state_economic_data%>%
  plot_ly(x = ~gdp, y = ~house_price, hoverinfo = "text", text = ~state) %>%
  add_text(x = 200000, y = 450, text = ~year, frame = ~year,
           textfont = list(color = toRGB("gray80"), size = 150)) %>%
  add_markers(size = ~population, color = ~region, 
              frame = ~year, ids = ~state,
              marker = list(sizemode = "diameter", sizeref = 3)) %>%
  layout(xaxis = list(title = "Real GDP (millions USD)", type = "log"),
         yaxis = list(title = "Housing price index")) %>%
  animation_slider(hide = T)
us1997 <- state_economic_data %>%
  filter(year == 1997)

# create an animated scatterplot with baseline from 1997
state_economic_data %>%
  plot_ly(x = ~gdp, y = ~house_price) %>%
  add_markers(data = us1997, marker = list(color = toRGB("gray60"), opacity = 0.5)) %>%
  add_markers(frame = ~year, ids = ~state, data = state_economic_data, showlegend = FALSE, alpha = 0.5) %>%
  layout(xaxis = list(type = "log"))
## cumulative animations
## creating cumulative time series
# Find median life HPI for each region in each year
med_hpi<-state_economic_data%>%
  group_by(region,year)%>%
  summarize(median_hpi=median(house_price))
library(purrr)
data<-med_hpi %>%
  split(.$year) %>%
  accumulate(~bind_rows(.x, .y)) %>%
  set_names(1997:2017) %>%
  bind_rows(.id = "frame")
med_hpi %>%
  split(.$year) %>%
  accumulate(~bind_rows(.x, .y)) %>%
  set_names(1997:2017) %>%
  bind_rows(.id = "frame") %>%
  plot_ly(x = ~year, y = ~median_hpi, color = ~region) %>%
  add_lines(frame = ~frame)
## linking two charts 
## linking two scatter plots
## first create shared data
library(crosstalk)
shared_us<-SharedData$new(data_2014)
## creating first scatter plot
t1<-shared_us%>%
  plot_ly(x=~home_owners,y=~house_price)%>%
  add_markers()
t1
##creating sceond scatter plot
t2 <- shared_us %>%
  plot_ly(x = ~employment/population, y = ~house_price)%>%
  add_markers()
t2
subplot(t1,t2)
# Polish the linked scatterplots
linked_plots<-subplot(t1, t2, titleX = TRUE, shareY = TRUE) %>% 
  hide_legend()
linked_plots%>%
  highlight()
# Enable linked brushing
linked_plots %>% highlight(on = "plotly_selected")
## enable hover highlight point vs point
linked_plots%>%
  highlight("plotly_hover")
## brushing groups
## highlighting time series data
## by double clicking on a particular series you will be able to highlight it
state_data<-state_economic_data%>%
  SharedData$new(key=~state)
state_data%>%
  plot_ly(x=~year,y=~house_price)%>%
  group_by(state)%>%
  add_lines()
## linking a dot plot and time series plot
shared_region<-state_economic_data%>%
  SharedData$new(~region)
# Create a dotplot of avg house_price by region in 2017
dp_chart <- shared_region %>%
  plot_ly() %>%
  filter(year == 2017) %>%
  group_by(region) %>%
  summarize(avg.hpi = mean(house_price, na.rm = TRUE)) %>%
  add_markers(x = ~avg.hpi, y = ~region)
dp_chart
# Code for time series plot
ts_chart <- shared_region %>%
  plot_ly(x = ~year, y = ~house_price) %>%
  group_by(state) %>%
  add_lines()
ts_chart
subplot(dp_chart,ts_chart)
## linking a bar chart with scatterplot
## working with coronavirus data
