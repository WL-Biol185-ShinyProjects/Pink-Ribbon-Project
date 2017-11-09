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
  )
    
)

#UI for Map of Incidence by County
fluidPage(
 titlePanel("Breast Cancer Map by County"),
   
 
 #Map for incidence by county
   library(leaflet),
     bcmap <- leaflet(data = breastcancer_bycounty_edited),
        addTiles(bcmap),
              setView(bcmap, 39.8283, 98.5795, zoom= 18),

 
        )



  


   
  




