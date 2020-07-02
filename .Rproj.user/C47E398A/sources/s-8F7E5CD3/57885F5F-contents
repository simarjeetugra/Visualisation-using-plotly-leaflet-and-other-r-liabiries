## Interactive time series plots in R
library(tsviz)
library(xts)
library(zoo)
library(lubridate)
library(forecast)
library(ggplot2)
library(plotly)
library(tbl2xts)
bse_comp<-xts_tbl(bse_complete381)
## autoplotting
## Type of graphs
## dynamic, static and interactive graphs


## basic time series plot with ploty
bseret2001%>%
  plot_ly(x=~...1,y=~A.C.C.Ltd.)%>%
  add_lines()

bse_comp%>%
  plot_ly(x=~date,y=~Abbott.India.Ltd.)%>%
  add_lines()
