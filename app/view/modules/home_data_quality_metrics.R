box::use(
  shiny[div, NS, moduleServer],
  shiny.fluent[Text],
  plotly[plotlyOutput, renderPlotly, plot_ly, add_pie, layout],
  magrittr[`%>%`]
)

box::use(
  app/view/components/cards
)

box::use(
  app/logic/graph_function
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  cards$catalog_quality_metrics_card(
    plotlyOutput(ns("graph"), width = "70%", height = "270px")
    )

}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){
    #graph_function$accuracy_server("graph")

    output$graph <- renderPlotly({
      labels <- c("Groupe A", "Groupe B")
      values <- c(25, 75)

      datas <- data.frame(labels, values)

      df <- datas
      fig <- plot_ly(df, labels = ~df$labels, values = ~df$values, type = "pie",
                            marker = list(colors = c("#68539c","#4e2d6b")))
      # fig <- fig %>% add_pie(hole = 0.8)
      # fig <- fig %>% layout(title = "",  showlegend = F,
      #                       xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      #                       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      #                       autorange = 'reversed')
    })

  })
}
