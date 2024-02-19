box::use(
  shiny[div, img, h1, tagList, a]
)


# home page cards

#' @export
catalog_overview_card <- function(title, icon, content) {
  div(class = "catalog_overview_card",
    tagList(
      div(class = "catalog_overview_card__header",
        h1(class = "catalog_overview_card__title", title),
        icon
      ),
      h1(class = "catalog_overview_card__content", content)
    )
  )
}


#' @export
catalog_quality_metrics_card <- function(content) {
  tagList(
    div(class = "catalog_quality_metrics__wrapper",
        h1(class = "catalog_quality_metrics__title", "Data quality Metrics"),
        div(class = "catalog_quality_metrics_card",
          tagList(
            div(class = "catalog_quality_metrics_card__header",
              h1(class = "title", "Meter"),
              img(src = "qualityIcon.svg", class = "icon")
            ),
            div(class = "catalog_quality_metrics_card__content", content)
          )
        ))
  )
}

# Cards inside panel

#' @export
monitoring_panel_card <- function(title, icon, content) {
  div(class = "monitoring_panel_card",
    tagList(
      h1(class = "monitoring_panel_card__title", title),
      div(class = "monitoring_panel_card__content",
        content,
        icon
      )
    )
  )
}


# More insights card

#' @export
more_insights_card <- function(title, url, link_title) {
  a(href = url,target = "_blank", class = "more_insights_card",
    tagList(
      div(class = "more_insights_card__wrapper",
        h1(class = "more_insights_card__title", title),
        div(class = "more_insights_card__content",
          img(src = "./icons/linkIcon.svg", class = "icon"),
          h1(class = "description", link_title)
        )
      ),
      img(src = "./icons/rightIcon.svg", class = "icon")
    )

  )
}
