#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(googleLanguageR)
#if (!require(sambaR)) remotes::install_github("andreasancheztapia/sambaR")
devtools::load_all()
#library(sambaR)
# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("sambaR"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("Artist",
                      "Artist (capitalization does not matter, spelling does)",
                      value = "caetano veloso"),
            textInput("Song",
                      "Song (capitalization does not matter, spelling does)",
                      value = "é hoje"),
            fluidRow(
            column(width = 6,
            textInput("Target",
                      "Target language code",
                      value = "en",
                      width = "300px"
                      )
            
            ),
            column(width = 6,
                   
            actionButton(inputId = "Search",
                         label = "Search",
                         icon = icon("music"),
                         )
            ))),

        # Show a plot of the generated distribution
        mainPanel(
          div(tableOutput("results"), style = "font-size:120%")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
observeEvent(input$Search,
    output$results <- renderTable({
      results <- isolate(translate_lyrics(artist = input$Artist,
                                  song = input$Song,
                                  target = input$Target))   
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)
