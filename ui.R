library(shiny)
library(leaflet)
library(shinydashboard)
library(readr)
library(readxl)
library(shinythemes)
library(extrafont)
library(tidyverse)
library(readxl)

shiny::tags

breastcancerates2 <- read.csv("Barplot Incidence Data" , header = TRUE)
gathered_data <- gather(breastcancerates2, key = "Race", value = "Incidence", 3:6, na.rm= TRUE)

death <- read_xlsx("death.xlsx")
gathered_death2 <- gather(death, key = "Race", value = "Deaths", 2:5, na.rm= TRUE)
gathered_death2 <- read.table("Gathered DeathPlot Data")

death_rate_time <- read_xlsx("death_rate_time.xlsx")
colnames(death_rate_time) <- c("Year", "All Ages", "Ages <50", "Ages 50+")
gathered_death_fixed <- gather(death_rate_time, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
gathered_death_fixed <- read.table("Line Graph Gathered Death Table")

annual_incidence_1_ <- read_xlsx("annual_incidence (1).xlsx")
gathered_incidence_line <- gather(annual_incidence_1_, key = "Age", value = "Rate", 2:4, na.rm = TRUE)
gathered_incidence_line <- read.table("Gathered Incidence 2")

zip_code_states <- read.csv("zip_codes_states.csv")
  zip_codes_states %>%
  left_join(breastcancer_bycounty_edited2, by = c("county" = "County"))
final_breastcancer <- read.table("Final Breast Cancer2")
final_breastcancer$popupColumn <- paste("<p>", final_breastcancer$County, final_breastcancer$zip_code, "</p>", "<p> Age-Adjusted Incidence Rate- cases per 100,000: ", final_breastcancer$`Age-Adjusted Incidence Rate - cases per 100,000`, "</p>", "<p> Average Annual Count: ", final_breastcancer$`Average Annual Count`, "</p>", "<p> Recent 5-Year Trend in Incidence Rates: ", final_breastcancer$`Recent 5-Year Trend in Incidence Rates`, "</p>", sep= " ")



dashboardPage(skin = "purple",
      dashboardHeader(title = "Pink Ribbon Project", titleWidth = 350),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Home", tabName = "home"),
          menuItem("Background", tabName = "background"),
          menuItem("Breast Cancer by Area and Ethnicity", tabName = "bargraphs"),
          menuItem("Breast Cancer Mortality Over Time", tabName = "linegraphs"),
          menuItem("Breast Cancer Map by County", tabName = "map"), 
          menuItem("Sources", tabName = "references")
        )
      ),

   #creating tabs in the app     
      dashboardBody(
        tabItems(
          tabItem(tabName = "home",
                  fluidPage( 
                    tags$head(
                    tags$style(HTML("
                                      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                                        
                              ")), 
                    
                      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
                  
                      
                      tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                          h1{
                                            color: #e83e8c;
                                          }
                    "))
                    ), 
                    
                    headerPanel("Welcome to the Pink Ribbon Project!"),
                    br(), 
                    br(), 
                    img(src= "pinkribbon.fw.png", height = 400, width = 300, align= "center"),
                    br(), 
                    br(), 
                                
                 
                   p("This app provides information regarding breast cancer mortality and incidence by race, year, and county in the United States.", style = "font-size:20px; font-family:'Lobster'")
                   
                    )),
                  
          tabItem(tabName = "background",
                  fluidPage(
                    tags$head(
                      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
                      
                      tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                          h1{
                                            color: #e83e8c;
                                          }
                    "))
                    ), 
                    
                    headerPanel("Breast Cancer Background"),
                    br(), 
                    
                  p("Cancer can be defined as a condition which causes the abnormal cells to divide uncontrollably. Only outnumbered by cases of skin cancer, breast cancer is the most prevalent form of cancer in women in the United States today. Risk for the disease increases with age, and in women the average age of diagnosis is 61 in the US. Although breast-cancer related deaths are reported to be decreasing, each year approximately 237,000 cases are reported in women.", style = "font-size: 15px"),
                  br(), 
                  img(src = "breast.jpg", height = 200, width = 200, align = "right"),
                  img(src = "side_breast.jpg", height = 200, width = 200, align = "right"),
                  tags$b("How Can You Reduce Your Risk of Breast Cancer?", style = "font-size: 20px"),
                  p("Many factors can increase your risk for breast cancer in your lifetime, many of which are still unknown. Some factors -- like age and family history-- are impossible to change, but by maintaining a healthy lifestyle many factors that can increase your risk can be reduced. Some of these factors include:", style = "font-size: 15px"), 
                    br(), 
                      p("Maintaining a healthy weight", style = "font-size: 15px"),
                    br(),
                      p("Exercising regularly", style = "font-size: 15px"),
                    br(),
                      p("Getting enough sleep (6-8 hrs a night)", style = "font-size: 15px"),
                    br(),
                      p("Limiting alcohol consumption", style = "font-size: 15px"),
                    br(),
                      p("Limiting exposure to chemicals or radiation", style = "font-size: 15px"),
                    br(),
                     p("You may have a higher risk of getting breast cancer if you have a family history of breast cancer and/or inherited changes in your BRCA1 and BRCA2 genes. In these cases, contact your doctor to learn about more ways to lower your risk.", style = "font-size: 15px"), 
                  tags$b("How Can I Get Checked for Breast Cancer?", style = "font-size: 20px"), 
                  
                  p("Breast Cancer Screening", style = "font-size: 18px"),
                     p("Screening for breast cancer is a method of checking a woman's breasts for the cancer before any signs or symptoms present themselves. Consult with your health care provider on the best screening options for you. The United States Preventative Services Task Force (USPSTF) is an excellent organization that will provide women with information regarding screening for breast cancer. It has a number of doctors and disease experts willing to help, who will recommend ways in which doctors can find the disease early, or prevent them entirely.", style = "font-size: 15px"),
                     p("For more information on breast cancer screening, prevention and treatment, visit:", style = "font-size: 15px"), 
                       br(),
                         a("CDC - Breast Cancer.html", href = "https://www.cdc.gov/cancer/breast/", style = "font-size: 15px"),
                      br()
                    )),
                  
          tabItem(tabName = "bargraphs",
                  
    #ui for incidence histogram
                  fluidPage(
                    tags$head(
                      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
                      
                      tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                          h1{
                                            color: #e83e8c;
                                          }
                    "))
                    ), 
                    headerPanel("Breast Cancer By Area and Ethnicity in 2014"),
                    
                    br(),
                    br(), 
                    br(), 
                   
           titlePanel("Incidence Per 100,000"), 
           
                    # Sidebar with a slider input for number of bins
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = 'state',
                                    label = 'Select an Area',
                                    choices = sort(unique(gathered_data$Area)),
                                    selected = 1
                        )
                      ),
                      
                      mainPanel(
                        plotOutput(outputId = "RacePlot")
                        
                        
                      )
                    ), 
          
    #ui for mortality histogram        
          titlePanel("Deaths Per 100,000"),
            
    # Sidebar with a slider input for number of bins
               sidebarLayout(
                 sidebarPanel(
                  selectInput(inputId = 'Area',
                               label = 'Select an Area',
                               choices = sort(unique(gathered_death2$Area)),
                               selected = 1
            
                                )
                           ),
            
    #Panelplot for breast cancer mortality line graph
             mainPanel(
               plotOutput(outputId = "DeathPlot")
            
                 )
               )
            )),
    
    #new tab for line graphs
           tabItem(tabName = "linegraphs",
                   fluidPage(tags$head(
                     tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
                     
                     tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                          h1{
                                            color: #e83e8c;
                                          }
                    "))
                   ), 
                   headerPanel("Breast Cancer Over Time"),
                   
                   br(),
                   br(), 
                   br(), 
                     
    # Breast cancer mortality application title           
           titlePanel("Mortality Rate"), 
                    
    # Sidebar with a slider input for number of bins
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId = 'Age of mortality',
                                    label = 'Select an Age Category',
                                    choices = sort(unique(gathered_death_fixed$Age)),
                                    selected = 1)
                      ),
                      
    #Panelplot
             mainPanel(
                       plotOutput(outputId = "MortalityPlot")
                        
                      )
                    ),
               
   # incidence over time application title
               titlePanel("Incidence Rate"),
               
   # Sidebar with a slider input for number of bins
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = 'Age of incidence',
                               label = 'Select an Age Category',
                               choices = sort(unique(gathered_incidence_line$Age)),
                               selected = 1
                   )
                 ),
                 
    #Panelplot
                 mainPanel(
                   plotOutput(outputId = "IncidencePlot")
                   
                 )
               )
             )),
             
   #ui for counties map 
          tabItem("map",
             fluidPage(
                  titlePanel(""), 
                  tags$head(
                    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
                    
                    tags$style(HTML("
                                          @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                          h1{
                                            color: #e83e8c;
                                          }
                    "))
                  ), 
                  headerPanel("Breast Cancer by County"), 
           # read.table("Final Breast Cancer2"),
   #PanelMap
             mainPanel(
               leafletOutput(outputId = "mymap", width = 1000, height = 1000)
               
             )
          )
       ), 
   
     #sources page
    tabItem("references", 
            fluidPage(
            titlePanel(""), 
            
            tags$head(
              tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
              
              tags$style(HTML("
                               @import url('//fonts.googleapis.com/css?family=News+Cycle:400,700');
                                   h1{
                                       color: #e83e8c;
                                      }
                    "))
             ),
            headerPanel("Thank You to Our Sponsors!"), 
            p("We would like to thank the following sources for allowing us to use their data:", style = "font-size: 15px"),
            br(),
            a("United States Cancer Race Incidence s.html", href = "https://nccd.cdc.gov/uscs/cancersbystateandregion.aspx", style = "font-size: 15px"),
            br(),
            a("Line Graph Death Data.html", href = "https://seer.cancer.gov/csr/1975_2014/browse_csr.php?sectionSEL=4&pageSEL=sect_04_table.09.html", style = "font-size: 15px"),
            br(),
            a("Line Graph Incidence.html", href = "https://seer.cancer.gov/csr/1975_2014/browse_csr.php?sectionSEL=4&pageSEL=sect_04_table.08.html", style = "font-size: 15px"),
            br(),
            a("Map By County Data.html", href = "https://statecancerprofiles.cancer.gov/incidencerates/index.php?stateFIPS=99&cancer=055&race=00&age=001&type=incd&sortVariableName=rate&sortOrder=default#results", style = "font-size: 15px"),
            br(),
            br(), 
            p("We would also like to give a shoutout to Gregg Whitworth who answered all of our questions in a timely manner!", style = "font-size: 15px"), 
            br(),
            br(), 
            img(src= "Gregg.jpg", height = 400, width = 300, align= "center")
            
            )

            
            
            )
          )
        )
     )
      
          
        
           
      
 





  
 



    

  
  






   








   
  




