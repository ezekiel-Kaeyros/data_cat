box::use(
  shiny[div, NS, tags, tagList, img, h1, a],
  shiny.fluent[fluentPage, ThemeProvider]
)

box::use(
  app/view/components/sidebar,
  app/view/components/header
)


theme <- list(
  palette = list(
    themePrimary = "#5547AC",
    themeLighterAlt = "#f6f6fc",
    themeLighter = "#dedbf2",
    themeLight = "#c3bde6",
    themeTertiary = "#8e84cd",
    themeSecondary = "#6457b5",
    themeDarkAlt = "#4b3f9a",
    themeDark = "#3f3582",
    themeDarker = "#2f2760",
    neutralLighterAlt = "#faf9f8",
    neutralLighter = "#f3f2f1",
    neutralLight = "	#edebe9",
    neutralQuaternaryAlt = "#2c2b2a",
    neutralQuaternary = "#e1dfdd",
    neutralTertiaryAlt = "#c8c6c4",
    neutralTertiary = "#a19f9d",
    neutralSecondary = "#605e5c",
    neutralPrimaryAlt = "#3b3a39",
    neutralPrimary = "#323130",
    neutralDark = "#201f1e",
    black = "#000000",
    white = "#ffffff"
  )
)
theme_dark <- list(
  palette = list(
    themePrimary = "#1e1e1e",
    themeLighterAlt = "#f6f6fc",
    themeLighter = "#dedbf2",
    themeLight = "#c3bde6",
    themeTertiary = "#8e84cd",
    themeSecondary = "#6457b5",
    themeDarkAlt = "#4b3f9a",
    themeDark = "#1e1e1e",
    themeDarker = "#2f2760",
    neutralLighterAlt = "#faf9f8",
    neutralLighter = "#f3f2f1",
    neutralLight = "	#edebe9",
    neutralQuaternaryAlt = "#2c2b2a",
    neutralQuaternary = "#e1dfdd",
    neutralTertiaryAlt = "#c8c6c4",
    neutralTertiary = "#a19f9d",
    neutralSecondary = "#605e5c",
    neutralPrimaryAlt = "#3b3a39",
    neutralPrimary = "#323130",
    neutralDark = "#faf9f8",
    black = "#1e1e1e",
    white = "#1e1e1e"
  )
)


#' @export
main_layout <- function(main_ui) {
  ThemeProvider(
    theme = theme,
    div(class = "container",
      div(class = "sidebar", sidebar$sidebar_ui),
      div(class = "content",
          div(class = "header", header$header_ui),
          div(class = "main", main_ui)),
      div(class = "footer")
    )
  )

}

# Home page layout

#' @export
home_layout <- function(home_data_catalog_overview,home_data_quality_metrics,
                        home_data_lineage_overview, username) {
  fluentPage(
    div(class = "home",
      tagList(
        div(class = "home__header",
          img(src = "hand.png", class = "hand__icon"),
          h1("Welcome Back"),
          h1(class = "title--colored", username),
        ),
        div(class = "home__overview",
          h1(class = "overview__title", "Data Catalog Overview"),
          home_data_catalog_overview,
        ),
        div(class = "home__wrapper",
          home_data_quality_metrics,
          home_data_lineage_overview
        )
      )
    )
  )
}
