box::use(
  shiny[div, reactive, tags, moduleServer, tagList, NS, h3],
)

box::use(
  app/view/components/common/button,
  app/view/components/common/panel,
)


# Tab navigation goes here

#' @export
data_lineage_ui <- function(id) {

  ns <- NS(id)
  div(class = "monitoring",
      h3("Data_Lineage Coming Soon...")
  )
}

#' @export
data_lineage_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

  })
}
