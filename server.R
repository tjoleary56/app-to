

library(shiny)
library(xlsx)

shinyServer(function(input, output) {
  
  rawData <- reactive({
    filet <- input$file1
    if(is.null(filet)) return()
    data <- read.xlsx2(filet$datapath, sheetIndex = 4)
  })
  
  a <- reactive({
    a <- subset(rawData(), AssertionString == "10046")
    a
  })
  
  b <- reactive({
    b <- subset(rawData(), AssertionString == "10074")
    b
  })
  
  c <- reactive({
    c <- subset(rawData(), AssertionString == "10179")
    c
  })

  output$contents <- renderTable({
    rawData()
  })
  
  output$a <- renderTable({
    a()
  })
  
  output$b <- renderTable({
    b()
  })
  
  output$c <- renderTable({
    c()
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste("file_name", '.xlsx', sep='') },
    content = function(file) {
      write.xlsx2(rawData(), file, sheetName = "sheet1")
      write.xlsx2(a(), file, sheetName = "sheet2", append = T)
      write.xlsx2(b(), file, sheetName = "sheet3", append = T)
      write.xlsx2(c(), file, sheetName = "sheet4", append = T)
    }
  )
  
})