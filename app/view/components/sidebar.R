box::use(
  shiny.fluent[Nav, Stack, fluentPage],
  shiny[NS, div, img]
)
box::use(
  app/logic/data_csv_process,
)

sidebar_nav <- Nav(
  groups = list(
    list(links = list(
                      list(name = "Home", url = "#!/home", key = "home", icon = "Home"),
                      list(name = "Catalog", icon = "",
                           expandAriaLabel = "Expand Catalog section",
                           collapseAriaLabel = "Collapse Catalog section",
                           links = items <- lapply(1:3, function(i) {
                               list(
                                 name = paste(data_csv_process$layer[i,], sep = ""),
                                 url = paste("#!/", "monitoring",
                                             "?layer=", paste(data_csv_process$layer[i,], sep = ""),sep = ""),
                                 key = paste(tolower(data_csv_process$layer[i,]), sep = ""),
                                 icon = "WaitlistConfirmMirrored"
                               )
                             }),
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
                           icon = "Filter"),
                      list(name = "Documentation",
                           url = "#!/documentation",
                           disbled = TRUE,
                           key = "documentation",
                           icon = "Dictionary")))
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
