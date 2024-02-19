box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, tableOutput,
        renderTable, reactive, req, observeEvent, fluidPage, actionButton],
  shiny.router[router_server, route, router_ui],
  shiny.fluent[fluentPage, Text, ThemeProvider],
  tibble,
  shinyauthr
)

box::use(
  app/view/home_page,
  app/view/monitoring_page,
  app/view/validation_page,
  app/view/more_insights_page,
  app/view/assessment_page,
  app/view/data_lineage_page,
  app/view/data_quality_page,
  app/view/components/layouts,
  app/view/components/common/panel,
  app/view/components/common/button
)

# dataframe that holds usernames, passwords and other user data
user_base <- tibble::tibble(
  user = c("user1", "user2"),
  password = c("pass1", "pass2"),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)

#' @export
ui <- function(id) {

  ns <- NS(id)

  fluentPage(
    # add logout button UI
    div(class = "pull-right", shinyauthr::logoutUI(id = ns("logout"))),
    # add login panel UI function
    shinyauthr::loginUI(id = ns("login")),

    router_ui(
      route("home", layouts$main_layout(home_page$home_ui(ns("home")))),
      route("monitoring", layouts$main_layout(monitoring_page$monitoring_ui(ns("monitoring")))),
      route("validation", layouts$main_layout(validation_page$validation_ui(ns("validation")))),
      route("more-insights", layouts$main_layout(more_insights_page$ui(ns("insights")))),
      route("assessment", layouts$main_layout(assessment_page$assessment_ui(ns("assessment")))),
      route("data_lineage", layouts$main_layout(data_lineage_page$data_lineage_ui(ns("data_lineage")))),
      route("data_quality", layouts$main_layout(data_quality_page$data_quality_ui(ns("data_quality"))))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    # call login module supplying data frame,
    # user and password cols and reactive trigger
    credentials <- shinyauthr::loginServer(
      id = "login",
      data = user_base,
      user_col = user,
      pwd_col = password,
      log_out = reactive(logout_init())
    )

    # call the logout module with reactive trigger to hide/show
    logout_init <- shinyauthr::logoutServer(
      id = "logout",
      active = reactive(credentials()$user_auth)
    )

    router_server("home")
    home_page$home_server("home")
    monitoring_page$monitoring_server("monitoring")
    validation_page$validation_server("validation")
    more_insights_page$server("insights")
    assessment_page$assessment_server("assessment")
    data_quality_page$data_quality_server("data_quality")
    data_lineage_page$data_lineage_server("data_lineage")

  })
}
