box::use(
  shiny[div, reactive, tags, tagList, NS, renderUI, moduleServer, uiOutput, textOutput,
        renderText, renderDataTable, dataTableOutput, verbatimTextOutput,
        renderPrint, req, reactiveVal, observeEvent, observe, icon, hideTab, callModule],
  shiny.fluent[DetailsList, Text, fluentPeople, fluentSalesDeals, fluentPage,
               Dropdown.shinyInput, Stack, DefaultButton.shinyInput,
               reactOutput, renderReact, Panel, Pivot, PivotItem, Label],
  shinyWidgets[actionBttn],
  shiny.router,
  dplyr,
  reactable,
  htmlwidgets[JS],
  magrittr[`%>%`],
  DT[datatable],
  htmltools[HTML],
)

box::use(
  app/view/components/common/button,
  app/view/components/common/panel,
)

box::use(
  app/view/modules/monitoring_graph_view,
  app/view/modules/monitoring_table_view
)

box::use(
  app/logic/convert_format,
  app/logic/data_csv_process,
  app/logic/function_file
)


#' @export
monitoring_ui <- function(id) {

  ns <- NS(id)

  div(class = "monitoring",

    div(class = "monitoring__header",
      uiOutput(ns("select")),
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
                monitoring_graph_view$ui(ns("graph"))),
      PivotItem(headerText = "Table View", itemIcon = "Table",
                monitoring_table_view$ui(ns("tableview")))
    ))
  )
}

#' @export
monitoring_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    observeEvent(input$dropdown, monitoring_graph_view$server("graph", input$dropdown))
    observeEvent(input$dropdown, monitoring_table_view$server("tableview", input$dropdown))

    current_page <- reactive({
      page <- shiny.router::get_query_param("layer", session)
      if(is.null(page)){
        page <- "Validation"
      }
      page
      page
    })
    data_catalog_select <- reactive({
      data_csv_process$output_select(current_page())
      })

    ############### List of node for select button
    opt1 <- reactive({list(key = c(data_catalog_select()$InputDataBusinessProcess),
                 text = c(data_catalog_select()$InputDataBusinessProcess))
            })
    ############# Generation of Option for Select Button
    options <- reactive({ mapply(function(i, x, y) list(ind = i, key = x, text = y),
                      seq.int(opt1()$key), opt1()$key, opt1()$text,SIMPLIFY = FALSE)
            })

    output$select <- renderUI({
      div(class = "monitoring__dropdown",
          style = "width: 130%",
          Dropdown.shinyInput(
            inputId = ns("dropdown"),
            value = opt1()$text[1],
            defaultSelectedKeys = "A",
            placeHolder = opt1()$text[1],
            options = options()
          ))
    })

  })
}
