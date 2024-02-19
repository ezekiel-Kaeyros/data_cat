box::use(
  shiny[tagList, img, NS, div],
  shiny.fluent[Text, fluentPage]
)

button_input <- shiny::actionButton(
  inputId = "inputInBtnId",
  label = "Input Data",
  class = "ButtonInClick",
  style = "background-color: #030987; color: #fff; border: none; border-radius: 1rem; padding: .5rem 1rem;",
)

button_output <- shiny::actionButton(
  inputId = "inputOutBtnId",
  label = "Output Data",
  class = "ButtonOutClick",
  style = "background-color: #fff; color: #000; border: none; border-radius: 1rem; padding: .5rem 1rem;",
  icon = shiny::icon("minus")
)

#' @export
button_input_ui <- fluentPage(
  button_input
)
