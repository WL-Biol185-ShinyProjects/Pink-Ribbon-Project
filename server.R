library(shiny)
library(tidyverse)
library(ggplot2)
library(leaflet)

read.csv("gathered_data_corrected")
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:4, na.rm= TRUE)
breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)
View(zip_codes_states)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$RacePlot <- renderPlot({
  

    gathered_data %>%
      filter(Area == input$State) %>%
      arrange(Incidence) %>%      
      mutate(Race = factor(Race, levels = Race, ordered = TRUE)) %>%
      ggplot(aes(Race, Incidence, fill = Race)) + 
      geom_bar(stat = 'identity') + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1))

  })  
  


#Server for map by county
<<<<<<< HEAD

function(input, output) {
    
    output$mymap <- renderLeaflet({
      zip_codes_states %>%
        na.omit(zip_codes_states) %>%
        filter(!is.na(longitude)) %>%
        filter(!is.na(latitude)) %>%
        filter(state == input$state) %>%
        arrange(county) %>%
        leaflet(data = zip_codes_states) %>% 
        setView(lng= -79.44, lat= 37.78, zoom= 20) %>%
        addTiles() %>%
        addMarkers(label = ~`Recent 5-Year Trend in Incidence Rates`, clusterOptions = markerClusterOptions())
    
    })
  }


      
=======
# zip_codes_states <- 
#   zip_codes_states %>%
#   left_join(breastcancer_bycounty_edited2, by = c("county" = "County"))
# 
# 
# 
#   
# 
#     output$mymap <- renderLeaflet({
#       zip_codes_states %>%
#         filter(condition %in% input$condition)
#         addTiles() %>%
#         setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>%
#         addProviderTiles(providers$OpenStreetMap)
#                          leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18)) %>%
#         addMarkers(lng= 174.768, lat=-36.852, popup="The birthplace of R")
#     })
  


death_rate_time <- read_excel("~/Pink-Ribbon-Project/death_rate_time.xlsx")
gathered_death <- gather(death_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE)


  
  output$DeathPlot <- renderPlot({
    
    
    gathered_death %>%
      filter(Age == input$Age) %>%
      arrange(Rate) %>%      
      mutate(Year = factor(Year, levels = Year, ordered = TRUE)) %>%
      ggplot(aes(Year, Rate)) +
      scale_y_continuous(limit= c(0, 100)) +
      geom_line(aes(group = 1)) + 
      geom_point() +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
    
  })  
}      
>>>>>>> 1b2d55aaafa3ae754e45188fcd348e5fcdacef29
    
    


  

