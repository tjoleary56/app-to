

library(shiny)
library(xlsx)

shinyServer(function(input, output, session) {
  
  rawData <- reactive({
    filet <- input$file1
    if(is.null(filet)) return()
    data <- read.xlsx2(filet$datapath, sheetIndex = 4)
  })
  
  a <- reactive({
    a <- subset(rawData(), AssertionString == input$table1Filter)
    a
  })
  
  b <- reactive({
    b <- subset(rawData(), AssertionString == input$table2Filter)
    b
  })
  
  c <- reactive({
    c <- subset(rawData(), AssertionString == input$table3Filter)
    c
  })
  
  observe({
    dfNames <- names(rawData())
    headerNames <- list()
    headerNames[dfNames] <- dfNames
    
    updateSelectInput(session, "headerNames", choices = headerNames, selected="" )
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
    filename = function() { paste(input$fileName, '.xlsx', sep='') },
    content = function(file) {
      write.xlsx2(rawData(), file, sheetName = "sheet1")
      write.xlsx2(a(), file, sheetName = "sheet2", append = T)
      write.xlsx2(b(), file, sheetName = "sheet3", append = T)
      write.xlsx2(c(), file, sheetName = "sheet4", append = T)
    }
  )
  
})
