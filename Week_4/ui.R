
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Dynamic Yield Curve"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("date",
                   "Date to choose:",
                   min = firstday,
                   max = lastday,
                   timeFormat="%F",
                   animate=TRUE,
                   value = lastday)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("dynamicyieldcurve"),
       plotOutput("market")
    )
  )
))
