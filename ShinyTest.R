
if(require(shiny)){
library(wordcloud2)
library(tm)
# Global variables can go here

ref <- sample (reviews$Ref,1)

# Define the UI
ui <- bootstrapPage(numericInput('ref', 'Enter T2T code', ref), wordcloud2Output('wordcloud2'))


# Define the server code
  server <- function(input, output) {
    output$wordcloud2 <- renderWordcloud2({
      # wordcloud2(demoFreqC, size=1)
      wordcloud2(demoFreq, size=input$size)
    })
  }
# Return a Shiny app object
# Sys.setlocale("LC_CTYPE","chs") #if you use Chinese character

## Do not Run!
shinyApp(ui = ui, server = server)
}