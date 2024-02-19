box::use(
  shiny[div, NS, moduleServer, img, h1, tagList],
  shiny.fluent[Text]
)

box::use(
  app/view/components/cards
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(

    div(class = "data_lineage_cards__list",
        h1(class = "data_lineage_cards__title", "Data Lineage Overview"),
       div(class = "data_lineage_cards__single" ,cards$catalog_overview_card("Last update",
                                img(src = "calendar.svg"), Sys.Date())),
        div(class = "data_lineage_cards__subsection",
        cards$catalog_overview_card("Transformation steps",
                                    img(src = "transformationSteps.svg"), "542"),
        cards$catalog_overview_card("Recent Activities",
                                    img(src = "connectedDatasets.svg"), "2")))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){
  })
}
