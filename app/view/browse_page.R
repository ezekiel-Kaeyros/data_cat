box::use(
  shiny.fluent[Text, fluentPage, SearchBox.shinyInput, Link],
  shiny[div, a, tags, NS, moduleServer, h1, observe, observeEvent, renderText,
        textOutput, reactive, uiOutput, renderUI],
)

#' @export
browse_page_ui <- function(id) {
  ns <- NS(id)
  fluentPage(
    div( class ="browse",
         div( class = "searchBar",
            h1("Find and Resquest access to DATA."),
            #textOutput(ns("searchValue")),
            SearchBox.shinyInput(ns("search"), placeholder = "Search for data"),
            Text(Link(href = "#!/home", "Home page "), "what did you find?")
         ),
    )
  )
}

#' @export
browse_page_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    observeEvent(input$search,{
      print(paste("Votre recherche : ", input$search, sep =""))

    })

    filtered_data <- reactive({
      req(input$search)
      #subset(data, grepl(input$search, Name, ignore.case = TRUE))
    })

    output$searchValue <- renderText({
      sprintf("Value: %s", input$search)
    })

  })
}
