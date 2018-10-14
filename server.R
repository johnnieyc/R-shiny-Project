ratiotable1 = dplyr::select(delaydata,
                            Year,Month,UniqueCarrier,
                            Origin,Dest,
                            CarrierDelay,WeatherDelay,NASDelay,
                            SecurityDelay,LateAircraftDelay)


server <- function(input, output,session) {
 
  
  
  
  map_data = reactive({
    depature_airport0 %>% filter(Month==input$Month3)
    
    
  })
  output$mymap = renderLeaflet({
    input$Month3
    leaflet(depature_airport0) %>% addTiles() %>%
      addCircles(lng = ~Longitude, lat = ~Latitude, weight = 1,
                 radius = ~sqrt(traffic) * 1000, popup = ~Origin
                 )
      
  })
  
  month_data = reactive({
    delay31 <-delaydata%>% mutate(.,Total_length_of_time_of_delay=CarrierDelay+WeatherDelay+
                                              NASDelay+SecurityDelay+LateAircraftDelay)%>%mutate(.,status=ifelse(Total_length_of_time_of_delay<16,"On time","Delay"))%>%
      select(UniqueCarrier,Total_length_of_time_of_delay,Month) %>%
      filter(Month==input$Month2)
    #& (Revenue<100) & (PE<50) & (PE>-10)
  })
  output$table1 <- renderPlotly({
    print(month_data())
    plot_ly(month_data(),y=~Total_length_of_time_of_delay,  color = ~UniqueCarrier,type = "box") 
    
      # layout(xaxis = list(title = "Sector"), 
      #        yaxis = list(title = as.character(input$ratio)))
  })
  
 
  month_data2 = reactive({
    delay41 <-delaydata%>% mutate(.,Total_length_of_time_of_delay=CarrierDelay+WeatherDelay+
                                              NASDelay+SecurityDelay+LateAircraftDelay)%>%mutate(.,status=ifelse(Total_length_of_time_of_delay<16,"On time","Delay"))%>%
      select(UniqueCarrier,Total_length_of_time_of_delay,Month,status)%>%
      group_by(UniqueCarrier)%>% filter(Month==input$Month1)
    
  })
   output$number_delay <- renderTable({
    month_data2()%>%summarise(.,ontime=sum(status=='On time'),
                delay = sum(status=='Delay'),
                delay_ratio=sum(status=='Delay')/sum(n()))
                
  })
   month_data3 = reactive({
     delay41 <-delaydata%>% mutate(.,Total_length_of_time_of_delay=CarrierDelay+WeatherDelay+
                                               NASDelay+SecurityDelay+LateAircraftDelay)%>%mutate(.,status=ifelse(Total_length_of_time_of_delay<16,"On time","Delay"))%>%
       select(UniqueCarrier,Total_length_of_time_of_delay,Month)%>%
       group_by(UniqueCarrier)%>% filter(Month==input$Month2)
   })
  
  output$length_of_time <- renderTable({
    month_data3() %>%
      summarise(.,averageTime = mean(Total_length_of_time_of_delay),
                medianTime  = median(Total_length_of_time_of_delay)
                )
  })
  
  month_data1 = reactive({
    delay31 <- delaydata%>%mutate(.,Total_length_of_time_of_delay=CarrierDelay+WeatherDelay+
                                    NASDelay+SecurityDelay+LateAircraftDelay)%>%mutate(.,status=ifelse(Total_length_of_time_of_delay<16,"On time","Delay"))%>%
      select(UniqueCarrier,Month,status) %>% filter(Month==input$Month1)%>%
      count(UniqueCarrier, status) 
     
  })
  output$table2 <- renderPlotly({
    # p <- delay20 %>% count(UniqueCarrier, status) %>%
      plot_ly(month_data1(),x = ~UniqueCarrier, y = ~n, color = ~status)
    
    
  })
 
  
  datasetInput<- reactive({
    data <- ratiotable1[1:10000,]
    if (input$UniqueCarrier != "All") {
      data <- data[data$UniqueCarrier == input$UniqueCarrier,]
    }
    if (input$Origin != "All") {
      data <- data[data$Origin == input$Origin,]
    }
    if (input$Dest != "All") {
      data <- data[data$Dest == input$Dest,]
    }
    data
  })
  
  # show data using DataTable
  output$table3 <- DT::renderDataTable(DT::datatable({
    datasetInput()},options = list(pageLength= 10,scrollX = TRUE)
    ))
  
}

  
  
  
  




  
