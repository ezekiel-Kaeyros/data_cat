

box::use(
  shiny[div, reactive, tags, NS, renderUI, moduleServer, verbatimTextOutput,
        renderPrint, req, reactiveVal, observeEvent, img, tagList, actionButton,
        actionLink, observe, HTML],
  shiny.fluent[DetailsList, Text, fluentPage,Panel, Link, renderReact],
  shinyjs,
  htmlwidgets[JS],
  htmltools[a],
)

box::use(
  app/view/components/cards,
)


#' @export
dynamic_panel_server <- function(input, output, session, data_panel, val) {
  ns <- session$ns

  is_panel_open <- val
  output$reactPanel <- renderReact({
    Panel(
      headerText = "Detailed Information",
      isOpen = is_panel_open(),
      div(class = "cards_monitoring_panel__list",
        cards$monitoring_panel_card("Data Name",
                                    img(src = "./icons/dataNameIcon.svg"),
                                    data_panel$DataName),
        cards$monitoring_panel_card("Description",
                                    img(src = "./icons/descriptionIcon.svg"),
                                    data_panel$Description),
        cards$monitoring_panel_card("View documentation",
                                    img(src = "./icons/sourceIcon.svg"),
                                    a(href = "https://kaeyros-analytics.com/",
                                      "Documentation", target = "_blank")),
        cards$monitoring_panel_card("Size",
                                    img(src = "./icons/sizeIcon.svg"),
                                    data_panel$Size),
        cards$monitoring_panel_card("Delivery Frequency",
                                    img(src = "./icons/frequencyDelivery.svg"),
                                    data_panel$deliveryFrequency),
        cards$monitoring_panel_card("Time Series Range",
                                    img(src = "./icons/calendar.svg"),
                                    data_panel$TimeSerieRange),
        cards$monitoring_panel_card("Format",
                                    img(src = "./icons/formatIcon.svg"),
                                    data_panel$Format),
        cards$monitoring_panel_card("Source",
                                    img(src = "./icons/sourceIcon.svg"),
                                    data_panel$Source),
        cards$monitoring_panel_card("Remarks",
                                    img(src = "./icons/descriptionIcon.svg"),
                                    data_panel$Remarks),
        div(class = "panel__link",
            id = "openLinkBtn",
            Link(href = "#!/more-insights", "See More Insights", onClick = JS(paste0(
              "function() {",
              "  Shiny.setInputValue('", ns("hidePanel"), "', Math.random());",
              "}"
            ))),
          img(src = "./icons/moreIcon.svg"),
        ),
      ),
      allowTouchBodyScroll = FALSE,
      onDismiss = JS(paste0(
        "function() {",
        "  Shiny.setInputValue('", ns("hidePanel"), "', Math.random());",
        "}"
      )),
    )
  })
}



