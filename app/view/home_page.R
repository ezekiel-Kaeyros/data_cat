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
home_ui <- function(id, username) {
  ns <- NS(id)
  fluentPage(
    layouts$home_layout(
      home_data_catalog_overview$ui(ns("catalog_overview")),
      home_data_quality_metrics$ui(ns("quality_metrics")),
      home_data_lineage_overview$ui(ns("lineage_overview")),
      username
    )
  )
}

#' @export
home_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    home_data_catalog_overview$server("catalog_overview")
    home_data_quality_metrics$server("quality_metrics")
    home_data_lineage_overview$server("lineage_overview")
  })
}
