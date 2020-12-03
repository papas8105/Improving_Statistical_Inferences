#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme('darkly'),
  
  # Application title
  title = "P-Values Histrogram Of One Sample Two Sided Tests",
  
  # siderbar inputs
  sidebarLayout(
    sidebarPanel(
      numericInput('nSims',
                   'Number of Simulations:',
                   min = 10,
                   max = 1e5,
                   value = 1e3,step=10),
      numericInput('n',
                   'Enter the sample size:',
                   min = 10,
                   max = 120,
                   value = 26,
                   step = 1),
      sliderInput('M',
                   'Enter the mean of the population (target):',
                   min = 80,
                   max = 120,
                   value = 100,
                   step  = 1
      ),
      sliderInput('s',
                  'Enter the sd of the population (target):',
                  min = 1,
                  max = 30,
                  value = 15,
                  step  = 1
      ),
      sliderInput('bars',
                  'Enter the number of bars of the histogram:',
                  min = 20,
                  max = 100,
                  value = 20,
                  step  = 10
                  ),
      sliderInput('alpha',
                  'Enter the alpha level (Type I error rate):',
                  min = 0.01,
                  max = 0.05,
                  value = 0.05,
                  step  = 0.01
                  ),
      checkboxInput('zoom',
                  'Zoom graph to p < 0.05 area.',
                  value = F
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      br(),
       plotOutput("distPlot"),
      br(),
       textOutput('text1')
       
    )
  )
))
