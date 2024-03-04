box::use(
  shiny.fluent[Text, fluentPage],
  shiny[div, tags, NS, moduleServer, observe, observeEvent, h3, h5],
)

#' @export
ui <- function(id, username) {
  ns <- NS(id)
  fluentPage(
    h3("Documentation"),
    h5("To update the xlsx file, your file must respect the basic formalism.
       Columns must be of type InputDataBuisnessLayer, InputDataBuinessProcess,
       InputDataName, etc..."),
    h5("once the data has been updated, the application will restart")
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {


  })
}
