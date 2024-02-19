box::use(
  shiny[tagList, img, NS, div, icon, actionButton],
  shiny.fluent[Text, fluentPage],
  shinyWidgets[actionBttn],
)

button_graph_view <- shiny::a(
    inputId = "inputInBtnId",
    #label = "Graph View",
    class = "ButtonInClick",
    style = "    background-color: #030987;
      cursor: pointer;
      color: #fff;
      border: none;
      border-radius: 1rem;
      padding: 0.5rem 1rem;
      text-decoration: none;",
    icon = shiny::icon("minus"),
    href = "#!/graphview",
    "Graph View",
    name = "buttonName"

)

button_table_view <-shiny::actionButton(
    inputId = "inputOutBtnId",
    #label = "Table View",
    class = "ButtonOutClick",
    style = "background-color: #000; cursor: pointer; color: #fff;
    border: none; border-radius: 1rem; padding: .5rem 1rem;",
    icon = shiny::icon("minus"),
    href = "#!/monitoring",
    "Table View",
    name = "buttonName"
)

button_input <- shiny::actionButton(
    inputId = "inputInBtnId",
    label = "Input Data",
    class = "ButtonInClick",
    style = "background-color: #030987; cursor: pointer; color: #fff; border: none; border-radius: 1rem; padding: .5rem 1rem;",
)

button_output <- shiny::actionButton(
    inputId = "inputOutBtnId",
    label = "Output Data",
    class = "ButtonOutClick",
    style = "background-color: #fff; cursor: pointer; color: #000; border: none; border-radius: 1rem; padding: .5rem 1rem;",
    icon = shiny::icon("minus")
)

#' @export
button_input_ui <- fluentPage(
  button_input
)

#' @export
button_output_ui <- fluentPage(
  button_output
)

#' @export
button_graph_view_ui <- fluentPage(
  button_graph_view
)

#' @export
button_table_view_ui <- fluentPage(
  button_table_view
)

#' @export
# bottom_btn <- div (
#   class = "ButtomDIv",
#   div (
#     class = "leftSideBtn",
#     style = "    display: flex;
#       width: 300px;
#       gap: 5px;",
#     actionBttn(
#       inputId = ns("graphLayout"),
#       label = "Graph View",
#       color = "primary",
#       style = "material-flat",
#       icon = icon("area-chart"),
#       size = "sm",
#       block = TRUE
#     ),
#     actionBttn(
#       inputId = ns("tableLayout"),
#       label = "Table View",
#       color = "danger",
#       style = "material-flat",
#       icon = icon("minus"),
#       size = "sm",
#       block = TRUE
#     ),
#   ),
#   div (
#     class = "rightSideEmpty"
#   )
# )
