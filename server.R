library(shiny)
library(tidyverse)
library(ggplot2)
library(leaflet)

read.csv("gathered_data_corrected")
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:4, na.rm= TRUE)
breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)
read.table("Final Breast Cancer Table")
View(final_breastcancer)

# Define server logic required to draw a histogram
# function(input, output) {
#   
#   output$RacePlot <- renderPlot({
#   
# 
#     gathered_data %>%
#       filter(Area == input$State) %>%
#       arrange(Incidence) %>%      
#       mutate(Race = factor(Race, levels = Race, ordered = TRUE)) %>%
#       ggplot(aes(Race, Incidence, fill = Race)) + 
#       geom_bar(stat = 'identity') + 
#       theme(axis.text.x = element_text(angle = 60, hjust = 1))
# 
#   })  
  


#Server for map by county

popupColumn <- final_breastcancer %>%
paste(County, p(), `Average Annual Count`)
function(input, output) {
    
    output$mymap <- renderLeaflet({
      filteredMap <- final_breastcancer %>%
        na.omit(final_breastcancer) %>%
        filter(!is.na(longitude)) %>%
        filter(!is.na(latitude)) %>%
        filter(state == input$state) %>%
        arrange(county)
      leaflet(filteredMap) %>% 
        setView(lng= -98, lat= 41, zoom= 4) %>%
        addTiles() %>%
        addMarkers(label = ~filteredMap$`Average Annual Count`, clusterOptions = markerClusterOptions(), popup = as.character(filteredMap$`Average Annual Count`))
    })                                                                                                                                                                                                                        
}

  


    


  


# death_rate_time <- read_excel("~/Pink-Ribbon-Project/death_rate_time.xlsx")
# gathered_death <- gather(death_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
# 
# 
#   
#   output$DeathPlot <- renderPlot({
#     
#     
#     gathered_death %>%
#       filter(Age == input$Age) %>%
#       arrange(Rate) %>%      
#       mutate(Year = factor(Year, levels = Year, ordered = TRUE)) %>%
#       ggplot(aes(Year, Rate)) +
#       scale_y_continuous(limit= c(0, 100)) +
#       geom_line(aes(group = 1)) + 
#       geom_point() +
#       theme(axis.text.x = element_text(angle = 60, hjust = 1))
#     
#   })  
# }      

    
    


  

