library(shiny)

shinyUI(fluidPage(
  
       titlePanel("word cloud"),
       sidebarLayout(
         sidebarPanel(
           fileInput("wc","upload a text file for wordcloud",multiple= FALSE,accept = "text/plain"),
           sliderInput("wordfreq","Select the min frequency of word",1,10,1),
           sliderInput("maxword","Select the min frequency of word",1,500,100),
           checkboxInput("random","Random Order?"),
           radioButtons("color","Select the wordcloud color theme",c("Accent","Dark"),selected = "Accent"),
           actionButton("update","Create Word Cloud")
         ),
         mainPanel(
           plotOutput("wcplot")
           
         )
         )
       )
)