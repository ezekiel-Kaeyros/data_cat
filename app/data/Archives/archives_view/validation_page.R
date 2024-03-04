box::use(
  shiny[div, reactive, tags, tagList, NS, renderUI, moduleServer, uiOutput, textOutput,
        renderText, renderDataTable, dataTableOutput, verbatimTextOutput,
        renderPrint, req, reactiveVal, observeEvent, observe, icon, hideTab, callModule],
  shiny.fluent[DetailsList, Text, fluentPeople, fluentSalesDeals, fluentPage,
               Dropdown.shinyInput, Stack, DefaultButton.shinyInput,
               reactOutput, renderReact, Panel, Pivot, PivotItem, Label],
  shinyWidgets[actionBttn],
  dplyr,
  reactable,
  htmlwidgets[JS],
  magrittr[`%>%`],
  DT[datatable],
  htmltools[HTML]
)

box::use(
  app/view/components/common/button,
  app/view/components/common/panel,
)

box::use(
  app/view/modules/validation_graph_view,
  app/view/modules/validation_table_view
)

box::use(
  app/logic/convert_format,
  app/logic/data_csv_process,
  app/logic/function_file
)

## variable d'input select
data_catalog_select <- data_csv_process$output_select("Validation")

############### List of node for select button
opt1 <- list(key = c(data_catalog_select$InputDataBusinessProcess),
             text = c(data_catalog_select$InputDataBusinessProcess))
############# Generation of Option for Select Button
options <- mapply(function(i, x, y) list(ind = i, key = x, text = y),
                  seq.int(opt1$key), opt1$key, opt1$text,SIMPLIFY = FALSE)

# Tab navigation goes here

#' @export
validation_ui <- function(id) {

  ns <- NS(id)
  div(class = "monitoring",

      div(class = "monitoring__header",
          div(class = "monitoring__dropdown",
              Dropdown.shinyInput(
                inputId = ns("dropdown"),
                value = opt1$text[1],
                defaultSelectedKeys = "A",
                placeHolder = opt1$text[1],
                options = options
              ),
          ),
          div(class = "monitoring__pivot",
              Pivot(linkFormat = "tabs",
                    PivotItem(headerText = "Input", itemIcon = "Down",
                              Label("")),
                    PivotItem(headerText = "Output", itemIcon = "Up",
                              Label(""))
              )
          ),
      ),
      div(class = "monitoring__viewToggle", Pivot(linkFormat = "tabs",
                                                  PivotItem(headerText = "Graph View", itemIcon = "GitGraph",
                                                            validation_graph_view$ui(ns("graph"))),
                                                  PivotItem(headerText = "Table View", itemIcon = "Table",
                                                            validation_table_view$ui(ns("tableview")))
      ))
  )
}

#' @export
validation_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    observeEvent(input$dropdown, validation_graph_view$server("graph", input$dropdown))
    observeEvent(input$dropdown, validation_table_view$server("tableview", input$dropdown))
  })
}
