library(shiny)

fluidPage(
  
  # Application title
  titlePanel("Breast Cancer By State and Ethnicity"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'State', 
                  label = 'Select a State',
                  choices = sort(unique(gathered_data$Area)),
                  selected = 1
                   )
              ),
    
#Panelplot
mainPanel(
  plotOutput(outputId = "RacePlot")

    )
  ),




#UI for Map of Incidence by County


 # titlePanel("Breast Cancer Map by County"),
 #   
 # 
 # #Map for incidence by county
 #  library(leaflet),
 #  library(maps) ,
 #    mapStates = map("state", fill = TRUE, plot = FALSE), 
 # leaflet(data =breastcancer_bycounty_edited$County) %>%
 #   addTiles() %>%
 #   addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE),
 # 
 #  

  
  # Application title
  titlePanel("Breast Cancer Mortality Over Time"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'Age', 
                  label = 'Select an Age Category',
                  choices = sort(unique(gathered_death$Age)),
                  selected = 1
      )
    ),
    
    #Panelplot
    mainPanel(
      plotOutput(outputId = "DeathPlot")
      
    )
  )
)







  


   
  




