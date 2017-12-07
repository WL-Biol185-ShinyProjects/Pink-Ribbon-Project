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
# final_breastcancer$popupColumn <- paste("<p>", final_breastcancer$County, final_breastcancer$zip_code, "</p>", "<p> Age-Adjusted Incidence Rate: ", final_breastcancer$`Age-Adjusted Incidence Rate - cases per 100,000`, "</p>", "<p> Average Annual Count: ", final_breastcancer$`Average Annual Count`, "</p>", "<p> Recent 5-Year Trend in Incidence Rates: ", final_breastcancer$`Recent 5-Year Trend in Incidence Rates`, "</p>", sep= " ")

function(input, output) {
    
    output$mymap <- renderLeaflet({
        final_breastcancer %>%
        na.omit(final_breastcancer) %>%
        filter(!is.na(longitude)) %>%
        filter(!is.na(latitude)) %>%
        arrange(county)
      leaflet(final_breastcancer) %>% 
        setView(lng= -98, lat= 41, zoom= 4) %>%
        addTiles() %>%
        addMarkers(label = ~`County`, clusterOptions = markerClusterOptions(), popup = ~popupColumn)
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

    
    


  

