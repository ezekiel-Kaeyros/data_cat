box::use(
  shiny[div, NS, moduleServer, img],
  shiny.fluent[Text]
)

box::use(
  app/view/components/cards,
  app/logic/convert_format,
  app/logic/data_csv_process
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(class = "cards_catalog_overview__list",
    cards$catalog_overview_card("Total Datasets",
                                img(src = "totalDatasets.svg"),
                                data_csv_process$nbre_datasets),
    cards$catalog_overview_card("Data Business Processes",
                                img(src = "dataBusinessProcess.svg"),
                                data_csv_process$nbre_process),
    cards$catalog_overview_card("Recent Activities",
                                img(src = "recentActivities.svg"), "+15%"),
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){
  })
}
