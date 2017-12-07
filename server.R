library(shiny)
library(tidyverse)
library(ggplot2)
library(leaflet)


# read.csv("gathered_data_corrected")
# gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:4, na.rm= TRUE)
# breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)
read.table("Final Breast Cancer Table")
View(final_breastcancer)


# read_xlsx("death.xlsx")
# gathered_death <- gather(death, key = "Race", value = "Deaths", 2:5, na.rm= TRUE)
# 
# 

# 
# # Define server logic required to draw a histogram
# function(input, output) {

#   output$DeathPlot <- renderPlot({
# 
#     gathered_death %>%
#       filter(gathered_death$Area == input$Area) %>%
#       ggplot(aes(Race, Deaths, fill = Race)) + geom_histogram(stat = "identity")
#     
#   })   
# # }
# 
# read.csv("gathered_data_corrected")
# gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 2:4, na.rm= TRUE)
# breast_cancerrates2 <- read.csv("gathered_data_corrected", header= TRUE)
# View(zip_codes_states)
# 
# # Define server logic required to draw a histogram
# # function(input, output) {
# #   
# #   output$RacePlot <- renderPlot({
# #   
# # 
# #     gathered_data %>%
# #       filter(Area == input$State) %>%
# #       arrange(Incidence) %>%      
# #       mutate(Race = factor(Race, levels = Race, ordered = TRUE)) %>%
# #       ggplot(aes(Race, Incidence, fill = Race)) + 
# #       geom_bar(stat = 'identity') + 
# #       theme(axis.text.x = element_text(angle = 60, hjust = 1))
# # 
# #   })  
#   
# 
# 
# 
# 


  


#Server for map by county
# final_breastcancer$popupColumn <- paste("<p>", final_breastcancer$County, final_breastcancer$zip_code, "</p>", "<p> Age-Adjusted Incidence Rate- cases per 100,000: ", final_breastcancer$`Age-Adjusted Incidence Rate - cases per 100,000`, "</p>", "<p> Average Annual Count: ", final_breastcancer$`Average Annual Count`, "</p>", "<p> Recent 5-Year Trend in Incidence Rates: ", final_breastcancer$`Recent 5-Year Trend in Incidence Rates`, "</p>", sep= " ")

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
# 
# # zip_codes_states <-
#    zip_codes_states %>%
#    left_join(breastcancer_bycounty_edited2, by = c("county" = "County"))
# 
# 
# 
# 
# 
#      output$mymap <- renderLeaflet({
#        zip_codes_states %>%
#          filter(condition %in% input$condition)
#          addTiles() %>%
#          setView(lng = -79.442778, lat = 37.783889, zoom = 5) %>%
#          addProviderTiles(providers$OpenStreetMap)
#                           leaflet(options = leafletOptions(minZoom = 0, maxZoom = 18)) %>%
#        addMarkers(lng= 174.768, lat=-36.852, popup="The birthplace of R")
#      })
# 

# death_rate_time <- read_excel("~/Pink-Ribbon-Project/death_rate_time.xlsx")
# gathered_death <- gather(death_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE
#                          )
# 
# 
# 
#   output$DeathPlot <- renderPlot(
# 
# 
#     gathered_death %>%
#       filter(Age == input$Age) %>%
#       arrange(Rate) %>%
#       mutate(Year = factor(Year, levels = Year, ordered = TRUE)) %>%
#       ggplot(aes(Year, Rate)) +
#       scale_y_continuous(limit= c(0, 400)) +
#       geom_line(aes(group = 1)) +
#       geom_point() +
#       theme(axis.text.x = element_text(angle = 60, hjust = 1)) 
#       
# 
#   )


  ##### incidence over time

# incidence_rate_time <- read_excel("~/Pink-Ribbon-Project/annual_incidence.xlsx")
# gathered_incidence <- gather(incidence_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
# 
# 
# 
# output$IncidencePlot <- renderPlot(
# 
# 
#   gathered_incidence %>%
#     filter(Age == input$Age_of_diagnosis) %>%
#     arrange(Rate) %>%
#     mutate(Year = factor(Year, levels = Year, ordered = TRUE)) %>%
#     ggplot(aes(Year, Rate)) +
#     scale_y_continuous(limit= c(0, 400)) +
#     geom_line(aes(group = 1)) +
#     geom_point() +
#     theme(axis.text.x = element_text(angle = 60, hjust = 1)) 







