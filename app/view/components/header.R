box::use(
  shiny[tagList, tags, img, NS, icon, div, actionButton, observeEvent],
  shiny.fluent[Text, fluentPage, Image],
)


header <- tagList(
  div( class = "header_page",
     actionButton("dark_mode", label = img (src="./icons/sun.svg", width="20", height="20"),
     style = "width: 20px; height: 20px; background-size: cover; background-color: #fff;
              	border: none; display: inline-block; float: right; margin-right: 100px;
                background-position: center;"),
    )
)

#' @export
header_ui <- fluentPage(
  header
)
