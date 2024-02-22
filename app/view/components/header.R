box::use(
  shiny[tagList, tags, img, NS, div, actionButton],
  shiny.fluent[Text, fluentPage],
)


header <- tagList(
  div( class = "header_page",
        #actionButton("mode", "DarkMode")

    )
)

#' @export
header_ui <- fluentPage(
  header
)
