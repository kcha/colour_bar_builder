
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyjs)
library(RColorBrewer)


mypalettes <- with(brewer.pal.info, which(category %in% c("div", "seq") & colorblind == TRUE))
mypalettes <- c("Default", rownames(brewer.pal.info)[mypalettes])

shinyUI(fluidPage(

  # Application title
  titlePanel("Colour Bar Builder"),
  
  HTML("This Shiny app generates a custom colour bar. 
                Right-click on the plot to save or copy the image, or download as PDF.
                The code to plot colour bars was adapted from 
                <a href=\"http://www.colbyimaging.com/wiki/statistics/color-bars\">John Colby</a>.
                I also use <a href=\"https://github.com/daattali/shinyjs\">shinyjs</a> for the colour picker.<br/><br/>"),

  fluidRow(
    column(3,
           checkboxInput("limit", "Use limited colour palette"),
           colourInput("hi", "Select high colour:", value = "blue"),
           colourInput("mid", "Select middle colour:", value = "white"),
           colourInput("lo", "Select low colour:", value = "red"),
           selectInput("palette", HTML('<a href="http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/figure/unnamed-chunk-14-1.png" target="_blank">RColorBrewer</a> palettes (sequential and diverging)'), 
                       choices = mypalettes)
    ),
    
    column(3,
           sliderInput("numColours", "Number of colours:", 
                       min = 1, max = 100, value = 100),
           numericInput("min", "Min y-axis:", value = -1, width = "70%"),
           numericInput("max", "Max y-axis:", value = 1, width = "70%"),
           numericInput("nticks", "Number of ticks:", value = 5, width = "70%"),
           radioButtons("orientation", "Orientation", c("Vertical", "Horizontal"), 
                        selected = "Vertical", inline = TRUE)
           
    ),
    
    column(3,
           textInput("title", label = "Plot title:"),
           downloadButton("savepdf", label = "Download PDF")
    ),
    
    column(3,
           plotOutput("colourbarPlot", height="auto", width="auto")
    )
  ),

  wellPanel(
      HTML('Source code: <a href="https://github.com/kcha/colour_bar_builder" target="_blank">GitHub</a>')
  ),
  
  tags$style(type='text/css', "#savepdf { margin-top: 50px; margin-left: 1px; margin-bottom: 30px }")
))
