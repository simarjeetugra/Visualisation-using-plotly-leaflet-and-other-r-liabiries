## making interactive plots using plotly
library(plotly)
library(rattle.data)
library(tidyr)
library(dplyr)
library(gapminder)
library(fivethirtyeight)
## making basic histogram 
dat_1982%>%
  plot_ly(x=~log(pop))%>%
  add_histogram(nbinsx=10)
## making scatter plot
wine%>%
  plot_ly(x=~Phenols,y=~Flavanoids)%>%
  add_markers()
## inceasing transparency and changing color
wine%>%
  plot_ly(x=~Phenols,y=~Flavanoids)%>%
  add_markers(Color=I("navy"),opacity=0.6)
## changing shape and size
wine%>%
  plot_ly(x=~Phenols,y=~Flavanoids)%>%
  add_markers(marker=list(symbol="diamond",size=6))
## color with third variable
data_ind_chn%>%
  plot_ly(x=~year,y=~gdpPercap,color=~country)%>%
  add_markers(colors="Dark2")%>%
  add_lines()
## changing hoover info
dat_1982%>%
  plot_ly(x=~gdpPercap,y=~lifeExp,color =~ continent,hoverinfo="y")%>%
  add_markers()
## adding country in hoover info
dat_1982%>%
  plot_ly(x=~gdpPercap,y=~lifeExp,color =~ continent,text=~country)%>%
  add_markers()
## polising a graph
## adding layout 
## adding titles x and y axis are lists because we can add multiple options in it
dat_1982%>%
  plot_ly(x=~gdpPercap,y=~lifeExp,color =~ continent,text=~country)%>%
  add_markers()%>%
  layout(xaxis=list(title="GDP Per CApia"),yaxis=list(title="Life Expentecy"),title="GDP Per Capita Vs LifeExp")
## changing background colour paper_bgcolor
dat_1982%>%
  plot_ly(x=~gdpPercap,y=~lifeExp,color =~ continent,text=~country)%>%
  add_markers()%>%
  layout(xaxis=list(title="GDP Per CApia"),yaxis=list(title="Life Expentecy"),title="GDP Per Capita Vs LifeExp",paper_bgcolor="#ebebeb")
## removing grids for x showgrid=False
dat_1982%>%
  plot_ly(x=~gdpPercap,y=~lifeExp,color =~ continent,text=~country)%>%
  add_markers()%>%
  layout(xaxis=list(title="GDP Per CApia",showgrid=F),yaxis=list(title="Life Expentecy"),title="GDP Per Capita Vs LifeExp",paper_bgcolor="#ebebeb")
## adding smoother
## adding linear smoother
## first fit linear model
m<-lm(log(gdpPercap)~lifeExp,data=dat_1982)
dat_1982%>%
  plot_ly(x=~log(gdpPercap),y=~lifeExp,text=~country)%>%
  add_markers()%>%
  layout(xaxis=list(title="GDP Per CApia",showgrid=F),yaxis=list(title="Life Expentecy"),title="GDP Per Capita Vs LifeExp",paper_bgcolor="#ebebeb")%>%
  layout(showlegend=F)%>%
  add_lines(y~fitted(m))
## creating sub plots
data1997<-gapminder%>%
  filter(year==1997)
p1<-data1997%>%
  filter(continent=="Africa")%>%
  plot_ly(x=~log(gdpPercap),y=~lifeExp)%>%
  add_markers(name="Africa")
p2<-data1997%>%
  filter(continent=="Asia")%>%
  plot_ly(x=~log(gdpPercap),y=~lifeExp)%>%
  add_markers(name="Asia")
subplot(p1,p2,nrows = 1)
## automatic subplotting faceting using group by and do
plot1997<-data1997%>%
  group_by(continent)%>%
  do(plot=plot_ly(data=.,x=~log(gdpPercap),y=~lifeExp)%>%
  add_markers(name=~continent))%>%
  subplot(nrows = 2)%>%
  layout(title="GDP vs LifeExp",)
## adding titles in scatter plot by using x axis, xaxis1, xaxis2 etc
plot1997%>%
  layout(xaxis=list(title="GDP Per Capita"),yaxis=list(title="lifeExp"),xaxis4=list(title="GDP Per Capita"))
## creating scatter plot matrix
data1997%>%
  plot_ly()%>%
  add_trace(
    type='splom',
    dimensions=list(
      list(label='lifeExp',values=~lifeExp),
      list(label='gdp',values=~gdpPercap),
      list(label='pop',values=~pop)
    )
  )
## binned scatter plots
## you can make binned scatter plot by using histogram_2d
## case study genrel election 2018
## comparing turout 2018 vs turnout 2014
## first unzip a zip file
unzip("election_data.zip")
TurnoutRates%>%
  plot_ly(x=~turnout2014,y=~turnout2018)%>%
  add_markers()
