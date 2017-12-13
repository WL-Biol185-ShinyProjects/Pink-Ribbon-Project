library(shiny)
library(tidyverse)
library(ggplot2)
library(leaflet)


function(input, output) {

#Tyding data for breast cancer incidence histogram 
breastcancerates2 <- read.csv("Barplot Incidence Data" , header = TRUE)
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 3:6, na.rm= TRUE)

#server logic required to draw a histogram of Breast Cancer Incidence
output$RacePlot <- renderPlot({
  
    gathered_data %>%
    filter(Area == input$'state') %>%
    arrange(Incidence) %>%
    ggplot(aes(Race, Incidence, fill = Race)) +
    scale_y_continuous(limit= c(0, 150)) +
    geom_bar(stat = 'identity') +
    theme(axis.text.x = element_text(angle = 60, hjust = 1))
})


#Tyding data for breast cancer death plot histogram 
read_xlsx("death.xlsx")
gathered_death2 <- gather(death, key = "Race", value = "Deaths", 2:5, na.rm= TRUE)
gathered_death2 <- read.table("Gathered DeathPlot Data")

# server logic required to draw a histogram of Breast Cancer Death Rates

    output$DeathPlot <- renderPlot({

        gathered_death2 %>%
        filter(Area == input$Area) %>%
        ggplot(aes(Race, Deaths, fill = Race)) +
        scale_y_continuous(limit= c(0, 150)) +
        geom_histogram(stat = "identity")

  })

#Server for line graphs
     #data for mortality line graph
colnames(death_rate_time) <- c("Year", "All Ages", "Ages <50", "Ages 50+")
gathered_death_fixed <- gather(death_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
gathered_death_fixed <- read.table("Line Graph Gathered Death Table")

#Mortality line plot
  output$MortalityPlot <- renderPlot({

    gathered_death_fixed %>%
      filter(Age == input$`Age of mortality`) %>%
      arrange(Rate) %>%
      mutate(Year = factor(Year, levels = Year, ordered = TRUE, sort(Year, decreasing = FALSE))) %>%
      ggplot(aes(Year, Rate)) +
      scale_y_continuous(limit= c(0, 400)) +
      geom_line(aes(group = 1)) +
      geom_point() +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))

  })

  #Server logic for line plot of breast cancer incidence over time
 # annual_incidence_1_ <- read_excel("~/Pink-Ribbon-Project/annual_incidence (1).xlsx")
 gathered_incidence_line <- gather(annual_incidence_1_, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
 gathered_incidence_line <- read.table("Gathered Incidence 2")
  
 #Data tyding for breast cancer incidence over time
 
 output$IncidencePlot <- renderPlot({
   
   gathered_incidence_line %>%
     filter(Age == input$'Age of incidence') %>%
     arrange(Rate) %>%
     mutate(Year = factor(Year, levels = Year, ordered = FALSE, sort(Year, decreasing = FALSE))) %>%
     ggplot(aes(Year, Rate)) +
     scale_y_continuous(limit= c(0, 400)) +
     geom_line(aes(group = 1)) +
     geom_point() +
     theme(axis.text.x = element_text(angle = 60, hjust = 1))
   
     })
 
 #data tidying, creating table to run in server for map by county
zip_codes_states <-
zip_codes_states %>%
left_join(breastcancer_bycounty_edited2, by = c("county" = "County"))
final_breastcancer$popupColumn <- paste("<p>", final_breastcancer$County, final_breastcancer$zip_code, "</p>", "<p> Age-Adjusted Incidence Rate- cases per 100,000: ", final_breastcancer$`Age-Adjusted Incidence Rate - cases per 100,000`, "</p>", "<p> Average Annual Count: ", final_breastcancer$`Average Annual Count`, "</p>", "<p> Recent 5-Year Trend in Incidence Rates: ", final_breastcancer$`Recent 5-Year Trend in Incidence Rates`, "</p>", sep= " ")
final_breastcancer <- read.table("Final Breast Cancer2")
 
 #Server for map by county
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
  