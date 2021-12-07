#install.packages('rsconnect')

library(shiny)
library(shinydashboard)
library(rsconnect)
library(lubridate)
# 

id <- "1nl5Z3aotIb8dNzI1tdiyfWkM4PmQ3dZT"
variants <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id))

# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(title = "Genomic surveillance", 
    dashboardHeader(title = "GenSurv", 
      dropdownMenuOutput("msgOutput")
    ),
    dashboardSidebar(
      sidebarMenu(
        sidebarSearchForm("searchText", "buttonSearch", "Search"),
        menuItem("Dashboard",tabName ="dashboard", icon = icon("dashboard")),
          menuSubItem("Country profile", tabName ="country_profile"),
        menuItem("Raw Data",tabName ="rawdata", icon = icon("dashboard"))
     )
   ),
   dashboardBody(
      tabItems(
        tabItem(tabName ="dashboard", 
          #begin page
          shiny::bootstrapPage(
            div(div(h2("Genomic surveillance in West African region")),
                div(column(12, 
                  fluidRow(
                    valueBox(15*200, "XXX 15 xxx", icon = icon("hourglass-3")),
                    valueBox(214/200, "XXX 10 xxx", icon = icon("microscope")),
                    valueBox(15/200, "XXX 10 xxx", icon = icon("chart-pie"))
                  )
                 #valueBoxOutput("itemRequested"))
                 )),
                div(column(12, 
                  fluidRow(
                    infoBox("Variants", 10, icon = icon("virus")),
                    infoBox("Sub lineages", 10, icon = icon("viruses")),
                    infoBox("Labs", 10, icon = icon("flask"))
                )))
            ),
            div(
              fluidRow(
                tabBox(
                  tabPanel(title ="Graph 1",status = "primary", 
                    solidHeader = TRUE,background = "aqua", 
                    plotOutput("histogram1")
                  ),
                  tabPanel(title ="Graph 2",status = "warning", 
                    solidHeader = TRUE,background = "aqua",
                    plotOutput("histogram2")
                  ),
                  tabPanel(title ="Graph 3",status = "warning", 
                    solidHeader = TRUE,background = "aqua" , 
                    plotOutput("histogram3")
                  )
                ),
                tabBox(
                  tabPanel(title ="Map 1",status = "primary", 
                    solidHeader = TRUE,background = "aqua" , 
                    plotOutput("Map1")
                  ),
                  tabPanel(title ="Map 2",status = "warning", 
                    solidHeader = TRUE,background = "aqua" ,  
                    plotOutput("Map2")
                  )
               )
              )
            )
          ), #Dashboard page
        ),
        tabItem(tabName ="rawdata", 
          shiny::bootstrapPage(h3("Here we put raw data info"))
        ),
        tabItem(tabName ="country_profile", 
          shiny::bootstrapPage(h3("Country profile "),
            div(
              div(
                column(4,
                  selectInput(inputId = "country", 
                    label = "Select country", 
                    choices = unique(variants$country) |> sort())
                ),
                column(4,shiny::actionButton(inputId = "btnSearch",label = "Search")),
                column(4,)
              ),
              div(
                fluidRow(
                  tabBox(
                    tabPanel(title ="Country graph",status = "primary", 
                             solidHeader = TRUE,background = "aqua", 
                             plotOutput("histogram01")
                    )
                  ),
                  tabBox(
                    tabPanel(title ="Country map",status = "primary", 
                             solidHeader = TRUE,background = "aqua" , 
                             plotOutput("Map01")
                    )
                  )
                )
              )
            ),
            div(class = "container",
              shiny::uiOutput("dynamic_tabs")
            )
          )
       )# ,
                    # tabItem(tabName ="sales",
                    #         h2("Sales Dashboard")
                    # )
                  )
                )
  )
)

