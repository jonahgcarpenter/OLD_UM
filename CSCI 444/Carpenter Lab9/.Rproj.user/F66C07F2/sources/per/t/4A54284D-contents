pacman::p_load(tidyverse, leaflet, htmltools, shiny, shinyWidgets)

ui <- fluidPage(
  titlePanel(
    tags$img(src = "logo.png", height = "100px", width = "200px")
  ),
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("state_ui"),
      awesomeRadio(
        inputId = "location",
        label = "Select Location:",
        choices = c("Choose" = "")
      )
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output, session) {
  
  location_data <- data.frame(
    name = c("Oxford", "Inlet Beach", "Destin", "Charleston", "Mt. Pleasant", "Nashville", "Franklin", "Spring Hill",
             "Memphis", "Chattanooga", "South Pittsburg", "Greystone", "Homewood", "Florence", "Mobile", "Madison",
             "Tuscaloosa", "Little Rock – Bowman Road", "Little Rock - Downtown", "Louisville – Barrett Avenue",
             "Louisville – Brownsboro Crossing", "Durham"),
    address = c("719 N Lamar", "10711 E Hwy 30A", "10562 Emerald Coast Pkwy, Ste 169", "456 Meeting St",
                "2664 N Hwy 17, Ste 101", "5304 Charlotte Ave", "1201 Liberty Pike", "2086 Wall Street",
                "6450 Poplar Ave, St 119", "313 Manufactures Road, Ste 119", "220 Third St", "5361 US-280",
                "1926 29th Avenue S", "315 N Court St", "1812 Shell Rd, St D", "8071 Highway 72 W", "520 19th St",
                "101 S Bowman Rd", "306 Main St", "984 Barret Avenue", "5050 Norton Healthcare Blvd", "2608 Erwin Rd suite 120"),
    city = c("Oxford", "Inlet Beach", "Destin", "Charleston", "Mt. Pleasant", "Nashville", "Franklin", "Spring Hill",
             "Memphis", "Chattanooga", "South Pittsburg", "Birmingham", "Homewood", "Florence", "Mobile", "Madison",
             "Tuscaloosa", "Little Rock", "Little Rock", "Louisville", "Louisville", "Durham"),
    state = c("MS", "FL", "FL", "SC", "SC", "TN", "TN", "TN", "TN", "TN", "TN", "AL", "AL", "AL", "AL", "AL", "AL",
              "AR", "AR", "KY", "KY", "NC"),
    zip = c("38655", "32461", "32550", "29403", "29466", "37209", "37067", "37174", "38119", "37406", "37380", "35242",
            "35209", "35630", "35242", "35758", "35401", "72211", "72201", "40204", "40241", "27705"),
    phone = c("662.236.2666", "850.532.6952", "850.388.6894", "843.459.1800", "843.936.8854", "615.610.3403",
              "615.656.5539", "931.486.8118", "901.881.3346", "423.287.5325", "423.228.5220", "205.490.7568",
              "205.666.7099", "256.415.8545", "251.318.1411", "256.870.0113", "205.539.6859", "501.406.0195",
              "501.387.1158", "502.289.1922", "502.305.8905", "984.243.9929"),
    long = c(-89.516107, -86.010989, -86.393022, -79.939229, -79.784110, -86.851889, -86.842168, -86.922671,
             -89.848424, -85.321611, -85.707947, -86.6838, -86.7928, -87.6766, -88.0894, -86.7477, -87.5481,
             -92.387032, -92.271889, -85.717279, -85.591737, -78.937468),
    lat = c(34.375572, 30.2802131, 30.390738, 32.795024, 32.843331, 36.152353, 35.933358, 35.745533,
            35.103801, 35.066372, 35.009759, 33.4055, 33.4797, 34.7998, 30.6867, 34.7487, 33.2065,
            34.743538, 34.747283, 38.235939, 38.297841, 36.010332)
  )
  
  output$state_ui <- renderUI({
    unique_states <- unique(location_data$state)
    awesomeRadio(inputId = "state", label = "Select State:", choices = unique_states)
  })
  
  observeEvent(input$state, {
    req(input$state)
    
    selected_state <- input$state
    locations_in_state <- location_data %>%
      filter(state == selected_state) %>%
      pull(name)
    
    if (length(locations_in_state) > 0) {
      updateAwesomeRadio(session, inputId = "location", choices = setNames(locations_in_state, locations_in_state))
    } else {
      updateAwesomeRadio(session, inputId = "location", choices = c("Choose" = ""))
    }
  }, ignoreInit = TRUE)
  
  observeEvent(input$location, {
    req(input$location)
    
    cityData <- location_data %>%
      filter(name == input$location)
    
    if (nrow(cityData) > 0) {
      viewLong <- cityData$long
      viewLat <- cityData$lat
      label <- paste0("<b>", cityData$name, " Location</b><br>", cityData$address, "<br>", cityData$city, ", ", cityData$state, " ", cityData$zip, "<br>", cityData$phone)
      
      leafletProxy("map") %>%
        clearMarkers() %>%
        setView(lng = viewLong, lat = viewLat, zoom = 15) %>%
        addMarkers(lng = viewLong, lat = viewLat, label = label, popup = label)
    } else {
      leafletProxy("map") %>%
        clearMarkers()
    }
  }, ignoreInit = TRUE)  # Prevent triggering on app load
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -89.3985, lat = 34.3665, zoom = 5)
  })
}

shiny::runApp("C:/Users/jonah/Downloads/Carpenter Lab9/BBB")


