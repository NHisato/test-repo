##
library(shiny)
shinyUI(pageWithSidebar(
  titlePanel(" Acceptance Sampling"),

          sidebarPanel(
              numericInput("N",
                           "lot size; N", min=0,value=10000),
              numericInput("AQL",
                           "Acceptance quality level (AQL)" ,min=0,max=1,step=.01,value=0.15),
              numericInput("RQL",
                           "Rejectable quality level (RQL)" ,min=0,max=1,step=.01, value=0.35),
              numericInput("a",
                           "Type I Error, Producer's risk (%)" ,min=0,max=100,step=1,value=5),
              numericInput("b",
                           "Type II Error, Consumers's risk (%)"  ,min=0,max=100,step=1,value=10) ,
              submitButton("Calculate")
              ),
          mainPanel(
                h4("acceptance number c / sample size n"),
                plotOutput("distPlot")
         )
))

