library(shiny)
library(tidyverse)
library(ggplot2)


read_xlsx("death.xlsx")
gathered_death <- gather(death, key = "Race", value = "Deaths", 2:5, na.rm= TRUE)



# Define server logic required to draw a histogram
function(input, output) {
  
  output$DeathPlot <- renderPlot({

    gathered_death %>%
      filter(gathered_death$Area == input$Area) %>%
      ggplot(aes(Race, Deaths, fill = Race)) + geom_histogram(stat = "identity")
    
  })   
}


