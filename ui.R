library(shiny)
library(leaflet)
# fluidPage(
  
#   # Application title
#   titlePanel("Breast Cancer By State and Ethnicity"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = 'State', 
#                   label = 'Select a State',
#                   choices = sort(unique(gathered_data$Area)),
#                   selected = 1
#                    )
#               ),
#     
# #Panelplot
# mainPanel(
#   plotOutput(outputId = "RacePlot")
# 
#     )
#   ),




#UI for Map of Incidence by County



fluidPage(
  titlePanel("Breast Cancer Map by County"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'state',
                  label = 'Select a State',
                  choices = sort(unique(final_breastcancer$state)),
                  selected = 1)
    ),
#PanelMap
  mainPanel(
    leafletOutput(outputId = "mymap")
  )
    )
     )




    

  
  




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

  
<<<<<<< HEAD
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
=======
#   # Application title
#   titlePanel("Breast Cancer Mortality Over Time"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(inputId = 'Age', 
#                   label = 'Select an Age Category',
#                   choices = sort(unique(gathered_death$Age)),
#                   selected = 1
#       )
#     ),
#     
#     #Panelplot
#     mainPanel(
#       plotOutput(outputId = "DeathPlot")
#       
#     )
#   )
# )
>>>>>>> 1f0fc30a3a5e8e258157e683c638e14bb1c0ec48








  


   
  




