box::use(
  shiny[div, reactive, tags, tagList, NS, renderUI, moduleServer, uiOutput, textOutput,
        renderText, renderDataTable, downloadButton, downloadHandler,
        renderPrint, req, reactiveVal, observeEvent, observe, icon, hideTab, callModule],
  shiny.fluent[DetailsList, Text, fluentPage,Dropdown.shinyInput, Stack,
               DefaultButton.shinyInput, reactOutput, renderReact, Panel],
  dplyr, shinyjs,
  reactable, utils,
  shiny.react,
  fontawesome,
  htmlwidgets[JS],
  magrittr[`%>%`],
  htmltools[HTML],
)

box::use(
  app/logic/convert_format,
  app/logic/data_csv_process,
  app/logic/function_file
)

box::use(
  app/view/components/common/panel,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  shinyjs::useShinyjs()
  div(
    div(class = "monitoring_table_view",
        div(
          class = "seletected_text",
          textOutput(ns("tableText")),
          shiny::br(),
          tags$style("
                #monitoring-tableview-downloadB{
                  color: white;
                  border: none;
                  background-color: #5547AC;
                }
                "),
          DefaultButton.shinyInput(ns("downloadB"),
                                   text = "Download as CSV",
                                   iconProps = list(iconName = "Download")
          ),
          tags$aside( class = "hover-popup",
                      tags$p("Download this table as CSV")
          )
        ),

        ########## Display Data Table
        reactable$reactableOutput(ns("tableview")),

        #####code pour le Panel
        reactOutput(ns("reactPanel")),
    )
  )
}

#' @export
server <- function(id, dropdown) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    current_page <- reactive({
      page <- shiny.router::get_query_param("layer", session)
      if(is.null(page)){
        page <- "Validation"
      }
      page
    })

    datas_value <- reactive({
      data <- data_csv_process$output_data(current_page())
      data
    })

    ############## Add hidden download button
    shiny::insertUI('body', 'beforeBegin', session = session,
                    ui = tagList(
                      div(
                        style = 'visibility: hidden; display: none',
                        downloadButton(ns("download_csv"), label = "")
                      )
                    ))

    ############## Reactive data for table view
    table_data <- reactive({
      datas_value() %>%
        dplyr::filter(InputDataBusinessProcess == dropdown
        )
    })

    ##### Take the position of the row Selected
    state <- reactive(reactable$getReactableState("tableview", "selected"))

    ##### Display DATATABLES
    output$tableText <- renderText({
      paste(current_page(), " / ", dropdown, sep = "")
    })

    output$tableview <- reactable$renderReactable({
      data_s <- table_data() %>%
        dplyr::distinct(DataName,Description,Format,Source,
                        Storage,Size,TimeSerieRange,deliveryFrequency,
                        Remarks,pathString)

      reactable$reactable(data_s, resizable = TRUE, selection = "single",
                          onClick = "select", pagination = FALSE,
                          #searchable = TRUE,
                          wrap = FALSE,
                          striped = FALSE,
                          highlight = FALSE,
                          bordered = TRUE,
                          defaultColDef = reactable$colDef(
                            header = function(value) gsub(".", " ", value, fixed = TRUE),
                            cell = function(value) format(value, nsmall = 1),
                            align = "left",
                            minWidth = 50,
                            headerStyle = list(background = "#f0f5f9")
                          ),
                          theme = reactable$reactableTheme(
                            stripedColor = "#f6f8fa",
                            highlightColor = "#5547AC",
                            cellPadding = "8px 12px",
                            style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI,
          Helvetica, Arial, sans-serif"),
                            searchInputStyle = list(width = "100%"),
                            headerStyle = list(
                              "&:hover[aria-sort]" = list(background = "hsl(0, 0%, 96%)"),
                              "&[aria-sort='ascending'], &[aria-sort='descending']"
                              = list(background = "hsl(0, 0%, 96%)"),
                              borderColor = "grey"
                            ),
                            rowSelectedStyle = list(backgroundColor = "#eee",
                                                    boxShadow = "inset 2px 0 0 0 #ffa62d")

                          )

      ) # End Reactable
    }) #End RenderReactable


    ############################ Stock as CSV
    shinyjs::onclick("downloadB", shinyjs::runjs(paste("Reactable.downloadDataCSV(",
                                                       "'",ns('tableview'),"'",
                                                       ", ","'",
                                                       dropdown,".csv","')",sep = "")))


    ######injection des datas
    data_panel <- reactive({
      data_panel <- table_data()
      data_panel$back_url <- tolower(current_page())
      data_panel <- data_panel %>%
        dplyr::filter( DataName == table_data()$`DataName`[state()])

      data_panel
    })

    ############################ Code pour afficher le panel

    ######### is_panel_open to control the display Panel
    is_panel_open <- reactiveVal(FALSE)
    observeEvent(reactable$getReactableState("tableview", "selected"),
                 {
                   is_panel_open(TRUE)
                   panel$dynamic_panel_server(input, output, session, data_panel(), is_panel_open)})
    observeEvent(input$hidePanel, is_panel_open(FALSE))

  })

}
