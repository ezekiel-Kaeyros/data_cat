box::use(
  shiny.fluent[Text, fluentPage],
  shiny[div, tags, NS, moduleServer, observe, observeEvent],
)

box::use(
  app/view/components/layouts,
  app/view/modules/home_data_lineage_overview,
  app/view/modules/home_data_catalog_overview,
  app/view/modules/home_data_quality_metrics,
)

#' @export
home_ui <- function(id) {
  ns <- NS(id)
  fluentPage(
    div(
      tags$style("
                    .shiny-input-container:not(.shiny-input-container-inline) {
                          width: 150px;
                          max-width: 100%;
                      }
                      .shiny-input-container{
                      float: right;
                        background: #5547ac;
                      	-webkit-border-radius: 15px;
                      	-moz-border-radius: 15px;
                      	border-radius: 15px;
                      	color: #fff;
                      	font-size: 1em;
                      	font-weight: bold;
                      	overflow: hidden;
                      	position: relative;
                      	text-align: center;
                      	width: 70px;
                        cursor: pointer;
                      }
                      .shiny-bound-input {

                      }
                       "),
      #shiny::fileInput(ns("upload"), "Choose CSV File", accept = ".xlsx", multiple = FALSE),
    ),
    layouts$home_layout(
      home_data_catalog_overview$ui(ns("catalog_overview")),
      home_data_quality_metrics$ui(ns("quality_metrics")),
      home_data_lineage_overview$ui(ns("lineage_overview"))
    )
  )
}

#' @export
home_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    home_data_catalog_overview$server("catalog_overview")
    home_data_quality_metrics$server("quality_metrics")
    home_data_lineage_overview$server("lineage_overview")

    observe({
      if (is.null(input$upload)) return()
      print(input$upload$name)
      file.copy("app/data/data_xl/csv_data_catalog.xlsx", "app/data/Archives/csv_data_catalog.xlsx")
      unlink("app/data/data_xl/csv_data_catalog.xlsx")
      file.copy(input$upload$datapath, "app/data/data_xl/csv_data_catalog.xlsx")
    })
  })
}
