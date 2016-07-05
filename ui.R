

library(shiny)
library(xlsx)

shinyUI(fluidPage(
  
  titlePanel("Tim O'Leary"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose File', accept = ".xlsx"),
                
      downloadButton('downloadData', 'Download'),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      #radioButtons('sep', 'Separator',
      #             c(Comma=',',
      #               Semicolon=';',
      #               Tab='\t'),
      #             ','),
      #radioButtons('quote', 'Quote',
      #             c(None='',
      #               'Double Quote'='"',
      #               'Single Quote'="'"),
      #             '"')
      selectInput("headerNames", "Choose Filter", choices=c()),
      #numericInput("sheetNumber", "Choose Sheet Number", value = 1),
      textInput("fileName", "Type in Name for File"),
      textInput("table1Filter", "Table 1 Filter"),
      textInput("table2Filter", "Table 2 Filter"),
      textInput("table3Filter", "Table 3 Filter")
      
    ),
    mainPanel(
      
      tabsetPanel(
        tabPanel("RawTable", tableOutput('contents')),
        tabPanel("Table1", tableOutput('a')),
        tabPanel("Table2", tableOutput("b")),
        tabPanel("Table3", tableOutput("c"))
        
      )
    )
  )
))
 
