#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Load necessary libraries
library(shiny)
library(leaflet)
library(DT)
library(readr)
library(dplyr)
library(sf)  # For handling spatial data


# Load the data
data <- read_csv("full_geosections_clusters_new.csv")

# Load the GeoJSON dataset
sections_geo <- st_read("Seksyon_Kominal_simplified.geojson")

# Join the cluster data to the GeoJSON dataset
sections_geo <- sections_geo %>%
  left_join(data, by = c("NAME_SEC" = "NAME_SEC"))  # Make sure the columns match

# Ensure that the CRS is in the correct format (long-lat)
sections_geo <- st_transform(sections_geo, crs = 4326)

# Define the Shiny UI
ui <- fluidPage(
  
  # App title
  titlePanel("Communal Sections in Haiti: New Clusters and Locations"),
  
  # Sidebar layout for inputs
  sidebarLayout(
    
    # Sidebar panel for user inputs
    sidebarPanel(
      
      # Add the text description of clusters
      h4("Cluster Descriptions:"),
      p("Cluster 1 (Blue):Border Sections"),
      p("Cluster 2 (Yellow): Unique sections adjacent to urban centers"),
      p("Cluster 3 (Red): Sections with Socio-Economic Challenges"),
      p("Cluster 4 (Green): Sections with Socio-Economic potential"),
      # Dropdown to select a Department
      selectInput("department", 
                  "Select Department:",
                  choices = c("All", unique(data$DEPARTEMENT)),
                  selected = "All"),
      
      # Dropdown to select a Commune
      uiOutput("commune_select"),
      
      actionButton("reset", "Reset Filters")
    ),
    
    # Main panel for displaying outputs
    mainPanel(img(src='POLLNEX_logo.png', height="40%", width="40%", align = "right"),
      tabsetPanel(
        tabPanel("Map", leafletOutput("map")),
        tabPanel("Table", DTOutput("table"))
      )
    )
  )
)

# Define the Shiny server
server <- function(input, output, session) {
  
  # Reactive function to update commune options based on selected department
  output$commune_select <- renderUI({
    req(input$department)
    
    if(input$department == "All") {
      selectInput("commune", "Select Commune:", choices = c("All", unique(data$COMMUNE)), selected = "All")
    } else {
      selected_communes <- data %>%
        filter(DEPARTEMENT == input$department) %>%
        pull(COMMUNE) %>%
        unique()
      selectInput("commune", "Select Commune:", choices = c("All", selected_communes), selected = "All")
    }
  })
  
  # Reactive data filtered by selected Department and Commune
  filtered_data <- reactive({
    if (input$department == "All" & input$commune == "All") {
      return(sections_geo)
    } else if (input$department != "All" & input$commune == "All") {
      return(sections_geo %>% filter(DEPARTEMENT == input$department))
    } else {
      return(sections_geo %>% filter(DEPARTEMENT == input$department, COMMUNE == input$commune))
    }
  })
  
  # Render the map with the filtered data
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addPolygons(data = filtered_data(),
                   opacity = 1,
                  dashArray = "4",
                 
                  color = ~case_when(
                    cluster == 1 ~ "blue",  # Light blue for Cluster 1
                    cluster == 2 ~ "yellow",  # Light yellow for Cluster 2
                    cluster == 3 ~ "red" ,
                    cluster == 4 ~ "green" # Light pink for Cluster 3
                  ),
                   popup = ~paste0("Section: ", NAME_SEC, 
                                       "<br>Cluster: ", cluster, 
                                       "<br>Population (2021): ", POPES2021,
                                       "<br>DANSI (2021): ", DANSI2021,
                                       "<br>Poverty Rate: ", PC_POV, "%",
                                       "<br>% more 3km away of Health Center: ", PC_3kmSant, "%",
                                       "<br>% more 3km away of School: ", PC_3kmLekol, "%"),
                  fillOpacity = 0) %>%
      addLegend("bottomright", 
                colors = c("blue", "yellow", "red", "green"), 
                labels = c("Cluster 1", "Cluster 2", "Cluster 3","Cluster 4"), 
                title = "Clusters")
  })
  
  # Render the table with the filtered data
  output$table <- renderDT({
    datatable(as.data.frame(filtered_data()))
  })
  
  # Reset button functionality
  observeEvent(input$reset, {
    updateSelectInput(session, "department", selected = "All")
    updateSelectInput(session, "commune", selected = "All")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
