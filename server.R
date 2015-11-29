
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

  output$colourbarPlot <- renderPlot({
  
    color.bar(colorRampPalette(c(input$lo, input$mid, input$hi))(input$numColours),
              min = input$min, max=input$max,
              nticks = input$nticks,
              title = input$title)    

  })
  
  output$savepdf <- downloadHandler(
    filename = "colorbar.pdf",
    content = function(file) {
      pdf(file, height=4, width=2)
      color.bar(colorRampPalette(c(input$lo, input$mid, input$hi))(input$numColours),
                min = input$min, max=input$max,
                nticks = input$nticks,
                title = input$title)  
      dev.off()
    }
  )
})
