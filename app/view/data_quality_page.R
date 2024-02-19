box::use(
  shiny[div, reactive, tags, tagList, NS, h3, moduleServer],
  shiny.fluent[reactOutput],
  reactable,
  validate,
  lubridate,
)

box::use(
  app/view/components/common/button,
  app/view/components/common/panel,
)

box::use(
  app/logic/rules_FullModel_ELIA
)


# Tab navigation goes here

#' @export
data_quality_ui <- function(id) {

  ns <- NS(id)
  div(class = "monitoring",
      h3(" Data_Quality Coming Soon..."),
      h3(" Data for FullModel_ELIA_indicative"),
      reactable$reactableOutput(ns("table"))
  )
}

#' @export
data_quality_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$table <- reactable$renderReactable({

      reactable$reactable(rules_FullModel_ELIA$df, resizable = TRUE, selection = "single",
                          onClick = "select", pagination = FALSE,
                          #searchable = TRUE,
                          wrap = FALSE,
                          striped = FALSE,
                          highlight = FALSE,
                          bordered = TRUE,
                        ) # End Reactable
    })

  })
}
