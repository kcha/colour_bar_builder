
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("R/color_bar.R")

shinyServer(function(input, output, session) {
  
  observe({
    if (input$limit) {
      updateColourInput(session, "hi", palette = "limited")
      updateColourInput(session, "mid", palette = "limited")
      updateColourInput(session, "lo", palette = "limited")
    } else {
      updateColourInput(session, "hi", palette = "square")
      updateColourInput(session, "mid", palette = "square")
      updateColourInput(session, "lo", palette = "square")
    }
    
    if (input$palette != "Default") {
      mycols <- brewer.pal(3, input$palette)
    } else {
      mycols <- c("red", "white", "blue")
    }
    updateColourInput(session, "hi", value = mycols[3])
    updateColourInput(session, "mid", value = mycols[2])
    updateColourInput(session, "lo", value = mycols[1])
  })

  isHoriz <- reactive({ifelse(input$orientation == "Vertical", FALSE, TRUE)})

  plotHeight <- function() {
    ifelse(isHoriz() == TRUE, 200, 400)
  }
  plotWidth <- function() {
    ifelse(isHoriz() == TRUE, 250, 150)
  }
  
  # Plot -----------------------------------------------------------------------
  output$colourbarPlot <- renderPlot({
  
    color.bar(colorRampPalette(c(input$lo, input$mid, input$hi))(input$numColours),
              min = input$min, max=input$max,
              nticks = input$nticks,
              title = input$title, 
              horiz = isHoriz())    

  }, height = plotHeight, width = plotWidth)
  
  # Save PDF --------------------------------------------------------------------
  output$savepdf <- downloadHandler(
    filename = "colorbar.pdf",
    content = function(file) {
      if (isHoriz() == TRUE) {
        pdf(file, height=2, width=4) 
      } else {
        pdf(file, height=4, width=2)
      } 
      color.bar(colorRampPalette(c(input$lo, input$mid, input$hi))(input$numColours),
                min = input$min, max=input$max,
                nticks = input$nticks,
                title = input$title,
                horiz = isHoriz())  
      dev.off()
    }
  )
})
