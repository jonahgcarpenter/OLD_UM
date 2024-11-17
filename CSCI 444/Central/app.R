#Jonah Carpenter
#CSCI 444 - Unit 12

library(shiny)
library(leaflet)
library(htmltools)

ui <- fluidPage(
  titlePanel(
    tags$img(src = "logo.png", height = "100px", width = "200px")
  ),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("location", "Choose a Central BBQ Location:",
                   choices = c("Downtown" = "downtown", "Poplar" = "poplar"))
    ),
    
    mainPanel(
      leafletOutput("CentralMap")
    )
  )
)

server <- function(input, output) {
  CentralData <- reactiveValues(
    name = c("Downtown", "Poplar"),
    address = c("147 E Butler Ave, 38102", "6201 Poplar Ave, 38119"),
    phone = c("901.672.7760", "901.417.7962"),
    long = c(-90.057134, -89.856992),
    lat = c(35.134117, 35.101341)
  )
  
  output$CentralMap <- renderLeaflet({
    leaflet() %>% addTiles()
  })
  
  observeEvent(input$location, {
    if (input$location == "downtown") {
      viewLong <- CentralData$long[1]
      viewLat <- CentralData$lat[1]
      index <- 1
    } else {
      viewLong <- CentralData$long[2]
      viewLat <- CentralData$lat[2]
      index <- 2
    }
    
    leafletProxy("CentralMap") %>%
      clearMarkers() %>%
      setView(lng = viewLong, lat = viewLat, zoom = 10) %>%
      addMarkers(
        lng = viewLong, lat = viewLat,
        popup = paste("<b>", CentralData$name[index], "Location</b><br>",
                      CentralData$address[index], "<br>",
                      CentralData$phone[index])
      ) %>%
      addPopups(
        lng = viewLong, lat = viewLat,
        popup = paste("<b>", CentralData$name[index], "Location</b><br>",
                      CentralData$address[index], "<br>",
                      CentralData$phone[index])
      )
  })
}

shinyApp(ui = ui, server = server)

#shiny::runApp("C:/Users/jonah/Downloads/Central")
