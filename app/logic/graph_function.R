box::use(
  shiny[fluidPage, NS, moduleServer, div],
  ggplot2,
  magrittr[`%>%`],
  dplyr,
  plotly[plotlyOutput, renderPlotly],
)

#' @export
accuracy_ui <- function(id){
  ns <- NS

  plotlyOutput(ns("graph"), width = "80%", height = "200px",)
}

#' @export
accuracy_server <- function(id) {
  moduleServer(id, function(input, output, session) {

  output$graph <- renderPlotly({
    labels <- c("Groupe A", "Groupe B")
    values <- c(25, 75)

    datas <- data.frame(labels, values)

    df <- datas

    fig <- plot_ly(df, labels = ~df$labels, values = ~df$values,
                          marker = list(colors = c("#68539c","#4e2d6b")), type ="pie")
    # fig <- fig %>% layout(title = "Accuracy",  showlegend = F,
    #                       xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
    #                       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    fig
    })

  })
}
