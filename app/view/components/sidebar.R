box::use(
  shiny.fluent[Nav, Stack, fluentPage],
  shiny[NS, div, img]
)

sidebar_nav <- Nav(
  groups = list(
    list(links = list(
                      list(name = "Home", url = "#!/", key = "home", icon = "Home"),
                      list(name = "Catalog", icon = "",
                           expandAriaLabel = "Expand Catalog section",
                           collapseAriaLabel = "Collapse Catalog section",
                           links = list(
                             list(
                               name = "Monitoring",
                               url = "#!/monitoring",
                               key = "monitoring",
                               icon = "TVMonitorSelected"
                             ),
                             list(
                               name = "Assessment",
                               url = "#!/assessment",
                               key = "assessment",
                               icon = "TestSuite"
                             ),
                             list(
                               name = "Validation",
                               url = "#!/validation",
                               key = "validation",
                               icon = "WaitlistConfirmMirrored"
                             )
                           ),
                           isExpanded = TRUE),
                      list(name = "Data Lineage",
                           url = "#!/data_lineage",
                           disbled = TRUE,
                           key = "lineage",
                           icon = "Dataflows"),
                      list(name = "Data Quality",
                           url = "#!/data_quality",
                           disbled = TRUE,
                           key = "quality",
                           icon = "Filter")))
  ),
  initialSelectedKey = "home",
  styles = list(
    root = list(
      height = "100%",
      boxSizing = "border-box",
      overflowY = "auto"
    )
  )
)

#' @export
sidebar_ui <- fluentPage(
  Stack(
    tokens = list(childrenGap = 70),
    div(class = "sidebar__logo", img(src = "logo.svg", class = "logo")),
    div(class = "sidebar__navigation",
      sidebar_nav
    )
  )
)
