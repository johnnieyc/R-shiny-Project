

library(shiny)

library(leaflet)




library(DT)
library(dplyr)
library(plotly)
packageVersion('plotly')
library(shinydashboard)

library(dplyr)




Sys.setenv("plotly_username" = "johnnie2019")
Sys.setenv("plotly_api_key" = "bI0USL4LJp3ATzNpv0tJ")

help(signup, package = 'plotly')

flight2008 <-read.csv("DelayedFlights.csv",header= TRUE)

myvars2008 <- c("Year","Month","UniqueCarrier",
            "Origin","Dest","Distance","Cancelled",
         "CarrierDelay","WeatherDelay","NASDelay",
           "SecurityDelay","LateAircraftDelay")


#newdata <- flight[myvars]
delaydata<-flight2008[myvars2008]%>%filter(.,Cancelled == 0 )

delaydata <- na.omit(delaydata)

delaydata<-subset(delaydata, UniqueCarrier=="AS"|UniqueCarrier=="HA"|UniqueCarrier=="WN"|
                     UniqueCarrier=="B6"|UniqueCarrier=="DL"|UniqueCarrier=="F9"|UniqueCarrier=="NK"|
                     UniqueCarrier=="AA"|UniqueCarrier=="UA")



# write.csv(delaydata, file = "Newflight.csv")
# ncol(delaydata)
# 
# nrow(delaydata)


# Merger dataset to get the geolocatoin for airport
location <- read.csv("Airport_Codes.csv",header=TRUE)

# ncol(location)
# nrow(location)

names(location)[1]<-paste("Origin") 
location

depature <- merge(delaydata,location,by="Origin")
ncol(depature)
nrow(depature)




vars<-c("Origin","Latitude","Longitude")
depature_airport <- depature[vars]%>%group_by(.,Origin)%>%summarise(traffic=n())
depature_airport_<-merge(depature_airport,location,by="Origin")
var1 <- c("Origin", "Latitude", "Longitude","traffic")

depature_airport0<-depature_airport_[var1]



leaflet(depature_airport0) %>% addTiles() %>%
  addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
             radius = ~sqrt(traffic) * 1000, popup = ~Origin
  )



#add one column with total length of time of delay
delay20<-delaydata%>% mutate(.,Total_length_of_time_of_delay=CarrierDelay+WeatherDelay+
                               NASDelay+SecurityDelay+LateAircraftDelay)%>%mutate(.,status=ifelse(Total_length_of_time_of_delay<16,"On time","Delay"))

# 2.1 add number of delays
# library(ggplot2)
delay21<-delay20
p <- delay21 %>% count(UniqueCarrier, status) %>%
  plot_ly(x = ~UniqueCarrier, y = ~n, color = ~status)
p



# 2.2 add Length of time of delay

g <- plot_ly(delay21, y = ~Total_length_of_time_of_delay, color = ~UniqueCarrier, type = "box")
chart_link = api_create(p, filename="box-multiple")
chart_link
g









