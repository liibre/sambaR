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
googleLanguageR::gl_auth("glkey.json")
#devtools::load_all()
if (!require(sambaR)) remotes::install_github("andreasancheztapia/sambaR")
library(sambaR)
# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("sambaR: translate the samba songs for our carnaval 2021"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("Artist",
                      "Artist (capitalization does not matter, spelling does)",
                      placeholder = "caetano veloso"),
            textInput("Song",
                      "Song (capitalization does not matter, spelling does)",
                      placeholder = "é hoje"),
            textInput("Target",
                      "Target language code",
                      placeholder = "en"),
            actionButton(inputId = "Search",
                         label = "Search",
                         icon = icon("music"))
        ),

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
        # generate bins based on input$bins from ui.R
     
      
      results <- translate_lyrics(artist = input$Artist,
                                  song = input$Song,
                                  target = input$Target)   
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)
