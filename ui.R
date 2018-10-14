
#Define UI ----
ui <- fluidPage(
  theme = "theme.css",
  
  navbarPage("Flight Delay",
             
             ##### Welcome Page #####
             tabPanel("Introduction",
                      # H1
                      tags$div(class = "header", checked = NA,
                               tags$h1("Flight Delays")),
                      fluidRow(
                        column(12, wellPanel(tags$h3("Definition of delay"),
                                            tags$p("According to the Federal Aviation Administration (FAA), a flight is considered
                                                   considered to be delayed when it is 15 minutes later than its scheduled time."),
                                            tags$h3("Why do this project"),
                                            tags$p("Help travelers to choose an Airline based on the flight delay records of 8 
                                                    Airlines in 2008, include: American Airlines, Alaska Airlines, Jetblue Airlines, Delta Air lines, 
                                                    Frontier Airlines, Hawaiian Airlines, United Airlines and Southwest Airlines."),
                                            
                                            tags$h3("How to utilize this app"),
                                            tags$p("This app contains several important tabs, include: Map, Airline and Data Table."),
                                            tags$p("Map: Users can have a sense of flight traffic in the United States. "),
                                            tags$p("Airline: Uses are able to compare monthly flight delay, include the number of delay and time of delay, between different airlines."),
                                            tags$p("Data Table: Users can find detail information for each flight delay by selecting airline, departure airport and arrive airport."),
                                            
                                            tags$h3("Data Source"),
                                            tags$p("The dataset is downloaded from",tags$a(href="https://www.kaggle.com/giovamata/airlinedelaycauses","Kaggle")),
                                            
                                            tags$h3("Future Work"),
                                            tags$p("This project only considers one factor that leads to flight delay, the carrier. However, there are other factors which lead to flight delay, such as weather, late aircraft and security, which will be included in the future work."),
                                            tags$p("The dataset only includes the record of 2008, I will find more data records from different years to make the analysis more convincing.")
                                            
                                            #actionButton("map_btn", label = "Map")
                        ))
                      )
                      
             ),
  
              tabPanel("Map",
                       # H1
                       tags$div(class = "header", checked = NA,
                                tags$h1("")),
                       # Add a row for the map
                       fluidRow(
                         column(12,
                                leafletOutput("mymap",height = 500)
                                
                         )
                       ),
                       
                       fluidRow(
                       
                       column(4, wellPanel(
                         selectizeInput(inputId = "Month3",
                                        label = "Select Month",
                                        choices = c(1,2,3,4,5,6,7,8,9,10,11,12),
                                        selected = 1)
                       ))
                       
                       
                       )),
             navbarMenu("Airline",
               tabPanel("Number of Delay",
                        # H1
                        tags$div(class = "header", checked = NA,
                                 tags$h1("")),
                        fluidRow(
                          column(5,
                                 wellPanel(
                                   selectizeInput(inputId = "Month1",
                                                  label = "Select Month",
                                                  choices = c(1,2,3,4,5,6,7,8,9,10,11,12),
                                                  selected = 1)
                                 ))),
                        fluidRow(
                          column(10,
                                 wellPanel(
                                   h4("Number of Delay"),
                                   plotlyOutput("table2")
                                 )),
                          
                                 
                                 infoBoxOutput("number_delay"),
                          
                                 
                                 div("AA--American Airlines",align="left"),
                                 div("AS--Alaska Airlines",align="left"),
                                 div("B6--Jetblue Airlines",align="left"),
                                 div("DL--Delta Air Lines",align="left"),
                                 div("F9--Frontier Airlines",align="left"),
                                 div("HA--Hawaiian Airlines",align="left"),
                                 div("UA--United Airlines",align="left"),
                                 div("WN--Southwest Airlines",align="left")
                          
                        )
                        
                      
                        
               ),
               tabPanel("Length of Time of Delay",
                        # H1
                        tags$div(class = "header", checked = NA,
                                 tags$h1("")),
                        fluidRow(
                          column(5,
                                 wellPanel(
                                   selectizeInput(inputId = "Month2",
                                                  label = "Select Month",
                                                  choices = c(1,2,3,4,5,6,7,8,9,10,11,12),
                                                  selected = 1)
                                 ))),
                        fluidRow(
                          column(12,
                                 wellPanel(
                                   h4("Time of Delay"),
                                   plotlyOutput("table1")
                                 ),
                                  infoBoxOutput("length_of_time"),
                                 br(),
                                 br(),
                                 div("AA--American Airlines",align="left"),
                                 div("AS--Alaska Airlines",align="left"),
                                 div("B6--Jetblue Airlines",align="left"),
                                 div("DL--Delta Air Lines",align="left"),
                                 div("F9--Frontier Airlines",align="left"),
                                 div("HA--Hawaiian Airlines",align="left"),
                                 div("UA--United Airlines",align="left"),
                                 div("WN--Southwest Airlines",align="left")
                                
                                 
                                       
                          ))
                        
                        
                        
               )
               
               ),
             tabPanel("Data Table",
                      # H1
                      tags$div(class = "header", checked = NA,
                               tags$h1("")),
                      tags$div(class = "header", checked = NA,
                               tags$h1("Detail")),
                      
                    
                      fluidRow(
                        column(4,
                               selectInput("UniqueCarrier",
                                           "UniqueCarrier:",
                                           c("All",
                                             unique(as.character(delay20$UniqueCarrier))))
                        ),
                      column(4,
                             selectInput("Origin",
                                         "Origin:",
                                         c("All",
                                           unique(as.character(delay20$Origin))))
                      ),
                      column(4,
                             selectInput("Dest",
                                         "Dest:",
                                         c("All",
                                           unique(as.character(delay20$Dest))))
                      )
                      ),
                      
                      fluidRow(
                        column(12,
                        DT::dataTableOutput("table3"))
                      )
                      
                      
                      
             )))

  

 


 

  
    
