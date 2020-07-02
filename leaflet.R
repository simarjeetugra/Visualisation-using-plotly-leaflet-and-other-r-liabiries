library(leaflet)
library(dplyr)
library(tidyr)
## leaflet
## for Spatial data
## creating  simple world map
leaflet()%>%
  addTiles()
## leaflet package has more than 100 map tiles
## default map tile is osm open street map
providers
names(providers)
## if you donot want to use deafaut style use add provider tiles
leaflet()%>%
  addProviderTiles("CartoDB")
leaflet()%>%
  addProviderTiles("Stamen")
leaflet()%>%
  addProviderTiles("Esri")
leaflet()%>%
  addProviderTiles("CartoDB.PositronNoLabels" )
## setting default map view
## getting location 
library(ggmap)
library(osmar)
geocode("Washington University")
register_google(key="AIzaSyBfTM3GfHSd6a3Omi7XGtWp8jtOIMe3jLU")
has_google_key()
google_key()
has_google_client()
## now google donot provide free data
leaflet()%>%
  addProviderTiles("Esri")%>%
  addMarkers(lat=30.760618,lng=76.765388)%>%
  setView(lat=30.760618,lng=76.765388,zoom=4)
## creating a file with latitude and longtitude
dc_hq<-data.frame(hq=c("Ohio","Calcutta","Seatlle","Thailand"),lat=c(40.0055451,25.7904064,3.0625881,22.3189133),lng=c(-105.2656407,-80.2141815,101.6146366,87.3115263))
leaflet() %>% 
  addProviderTiles("Esri") %>% 
  addMarkers(lng = jinesh_location_1_$Longitude, lat = jinesh_location_1_$Latitude)    
## adding pop up
map<-leaflet() %>% 
  addProviderTiles("CartoDB") %>% 
  addMarkers(lng = dc_hq$lng, lat = dc_hq$lat,popup=dc_hq$hq)
## zooming a particular location from a map
map%>%
  setView(lat=30.760618,lng=76.765388,zoom=4)
## clear bounds
map%>%
  clearBounds()
  clearMarkers()
## exploring IPEDS 
  install.packages("remotes")
  remotes::install_github("Btibert3/ripeds")
ipeds<-read.delim("ipeds.txt",header=T,sep=",")
ipeds<-as.data.frame(ipeds)
## counting sector_lab
  group_by(sector_label)%>%
  count()
## removing missing observations
ipeds<-
  ipeds_missing%>%
  drop_na()
## loading data
ipeds%>%
  group_by(State)%>%
  count()
## colleges in maine province
Florida<-ipeds%>%
  filter(State=="FL")
## mapping colleges in florida
Florida_map<-leaflet()%>%
  addProviderTiles("Esri")%>%
  addMarkers(data=jinesh_location_1_)
Florida_map
## we can also add circle markers
Florida_map%>%
  addCircleMarkers(data=Florida)
## removing markers and adding circle markers
Florida_map_circle<-Florida_map%>%
  clearMarkers()%>%
  addCircleMarkers(data=jinesh_location_1_,radius = count(jinesh_location_1_$Affiliations),color = "red",opacity = 0.70)
Florida_map_circle%>%
  addTiles("OpenStreetMap")
Florida_map_circle
## adding info of everycollege
## with the help of pop up
Florida_map_circle
## We can also set color 
Florida_map_circle<-Florida_map%>%
  clearMarkers()%>%
  addCircleMarkers(data=Florida,radius = 2,popup = Florida$INSTNM,color = "red",opacity = 0.9)
Florida_map_circle
## Setting view on a particular location
## Suppose in Florida I want to set view on Miami
Florida_map_circle%>%
  setView(lng=-80.34765,lat=25.81071,zoom = 12)
## changing the map colour
leaflet()%>%
  addProviderTiles("CartoDB")%>%
  addCircleMarkers(data="untitled spreadsheet",color = "FF000",radius = 3)
## adding labels and popup
## labels are better than popups because they require less effort
leaflet()%>%
  addProviderTiles("CartoDB")%>%
  addCircleMarkers(data=Florida,color = "red",radius = 3,label = Florida$INSTNM)
## label with two options
leaflet()%>%
  addProviderTiles("CartoDB")%>%
  addCircleMarkers(data=Florida,color = "red",radius = 3,label = ~paste0(INSTNM,"(",State,")"))
## color coding different types of colleges in orgenon state
org_state<-ipeds%>%
  filter(State=="OR")
## adding color palettes
pal<-colorFactor(palette = c("red","blue","#9b4a11"),levels=c(0,1,2))
org_map<-leaflet()%>%
  addProviderTiles("CartoDB")%>%
  addCircleMarkers(data=org_state,radius = 2,color = ~pal(Type),label=org_state$INSTNM)
org_map
## adding a legend
org_map%>%
  addLegend(pal=pal,values=c(0,1,2),opacity = 0.5,title = "Sector",position = "topright")
## working with leaflet extra packages
## searching any location on map use addSearchOSM
## getting back use addReverseSearchOSM
library(leaflet.extras)
leaflet()%>%
  addTiles()%>%
  addSearchOSM()%>%
  addReverseSearchOSM()
## seeing all colleges in america
## creating a centre
m2 <-
  ipeds %>% 
  leaflet() %>% 
  # use the CartoDB provider tile
  addProviderTiles("CartoDB") %>% 
  # center on the middle of the US with zoom of 3
  setView(lat = 39.8282, lng = -98.5795, zoom=3)
m2%>%
  addCircleMarkers(data=ipeds,radius = 1,label=ipeds$INSTNM)
pal <- colorFactor(palette = c("red", "blue", "#9b4a11"), 
                   levels = c(0,1,2))

m2 %>% 
  addCircleMarkers(radius = 1, label = ~INSTNM, color =~pal(Type))
## overlay groups or plottting by layers
## grouping colleges by Type first type
## layer control at side (topright) will show layers controlling
library(htmltools)
type_0<-ipeds%>%
  filter(Type==0)
m3<-
  leaflet()%>%
  addProviderTiles("CartoDB")%>%
  addCircleMarkers(data=type_0,radius = 1,label=~htmlEscape(~INSTNM),color = ~pal(Type),group=0)
m3%>%
  setView(lat = 39.8282, lng = -98.5795, zoom=3)
type_2<-ipeds%>%
  filter(Type==2)
m3<-m3%>%
  addCircleMarkers(data=type_2,radius = 1,label=~htmlEscape(~INSTNM),color = ~pal(Type),group = 2)%>%
  addLayersControl(overlayGroups = c(0,2))%>%
  setView(lat = 39.8282, lng = -98.5795, zoom=3)
type_1<-ipeds%>%
  filter(Type==1)
m4<-m3%>%
  addCircleMarkers(data=type_1,radius = 1,label=htmlEscape(~INSTNM),color= ~pal(Type),group = 1)%>%
  addLayersControl(overlayGroups = c(0,1,2))%>%
  setView(lat=39.282,lng=-98.5795,zoom=3)
m4
gag_map<-leaflet()%>%
  addProviderTiles("Esri")%>%
  addCircleMarkers(data=gag,clusterOptions = markerClusterOptions())
gag_map 
