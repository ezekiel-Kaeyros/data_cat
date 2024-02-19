box::use(
  shiny[NS, moduleServer, div, renderUI, uiOutput, reactive,
        tableOutput, renderTable, observeEvent, reactiveVal],
  shiny.fluent[Text, fluentPage, reactOutput],
  magrittr[`%>%`],
  jsonlite[read_json],
  r2d3,
)

box::use(
  app/logic/convert_format,
  app/logic/data_csv_process,
  app/logic/function_file
)
box::use(
  app/view/components/common/panel,
)

datas_value <- data_csv_process$output_data("Validation")

#' @export
ui <- function(id) {
  ns <- NS(id)
  fluentPage(
    div(class = "monitoring_graph_view",
        Text("Graph view here"),
        reactOutput(ns("reactPanel")),
        uiOutput(ns("d3")),
    )
  )
}

#' @export
server <- function(id, dropdown) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    ############ recupération des données
    table_data <- reactive({
      datas_value %>%
        dplyr::filter(InputDataBusinessProcess == dropdown)
    })

    output$d3 <- renderUI({
      r2d3::r2d3(data = read_json("app/data/output_v.json"), d3_version = 4,
                 script = "app/js/dendogram_2.js", width = 1100,
                 height = 400, options = ns("node_name"))
    })

    ##### Insertion des données reactive pour le graph
    data_panel <- reactive({
      datas <- table_data()
      datas$back_url <- "validation"
      datas <- datas %>%
        dplyr::filter( DataName == print(input$node_name) )

      saveRDS(datas, paste(paste0("app/data/insights/","insights",".rds", sep="")))
      datas
    })

    ######### IsPanelOpen to control the display Panel
    isPanelOpen <- reactiveVal(FALSE)
    observeEvent(input$node_name, {
      isPanelOpen(TRUE)
      panel$dynamic_panel_server(input, output, session, data_panel(), isPanelOpen)})
    observeEvent(input$hidePanel, isPanelOpen(FALSE))

    ########### Génération du fichier JSON à Envoyer au Graph
    json <- reactive({
      colname <- c("level2")
      data <- data.frame(
        name = c(table_data()$`InputDataBusinessProcess`[1], table_data()$`DataName`)
      )
      data$colname <- colname
      for (i in 2:print(length(table_data()$`DataName`)+1)) {
        data$colname[i] <- replace(data$colname[i], data$colname[i] == "level2", "level3")
      }

      # Convertir les données du data frame en structure JSON
      json_data <- jsonlite::toJSON(list(
        children = list(
          list(
            name = data$name[1],
            children = lapply(2:print(length(table_data()$`DataName`)+1),
                              function(i) list(name = data$name[i], colname = data$colname[i])),
            colname = data$colname[1]
          )
        ), name = table_data()$`InputDataBusinessLayer`[1] ), pretty = TRUE)

      # Écrire la structure JSON dans un fichier
      writeLines(json_data, "app/data/output_v.json")
    })
    json()

  })
}
