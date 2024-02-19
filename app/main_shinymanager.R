box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, textOutput,
        renderText, reactive, req, observeEvent, enableBookmarking, actionButton],
  shiny.router[router_server, route, router_ui],
  shiny.fluent[fluentPage, Text, ThemeProvider],
  tibble,
  shinymanager,
  keyring
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
# ############## creation du keyring
#keyring::key_set("R-shinymanager-key", "datacatalogapp")
#keyring::key_set_with_value("R-shinymanager-key", "datacatalogapp", password = "Kaeyros@data@237@key")

############ Define Credential
# credentials <- data.frame(
#   user = c("admin","admin_kaeyros"),
#   password = c("Kaeyros@data@237@key","Kaeyros@data@237@key"),
#   # password will automatically be hashed
#   admin = c(FALSE, TRUE),
#   stringsAsFactors = FALSE
# )
#
# shinymanager::create_db(
#   credentials_data = credentials,
#   sqlite_path = "app/data/database.sqlite", # will be created
#   #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
#   passphrase = "passphrase_wihtout_keyring"
# )

ui <- function(id) {
    #ns <- NS(id)
    fluentPage(
      router_ui(
        route("home", layouts$main_layout(home_page$home_ui("home"))),
        route("monitoring", layouts$main_layout(monitoring_page$monitoring_ui("monitoring"))),
        route("validation", layouts$main_layout(validation_page$validation_ui("validation"))),
        route("more-insights", layouts$main_layout(more_insights_page$ui("insights"))),
        route("assessment", layouts$main_layout(assessment_page$assessment_ui("assessment"))),
        route("data_lineage", layouts$main_layout(data_lineage_page$data_lineage_ui("data_lineage"))),
        route("data_quality", layouts$main_layout(data_quality_page$data_quality_ui("data_quality")))
      )
    )
}

#' @export
ui <- shinymanager::secure_app(ui, enable_admin = TRUE, choose_language = TRUE)

########### Authentification Module
auth <- function(){
  # check_credentials directly on sqlite db
  shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(
      "app/data/database.sqlite",
      #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
      passphrase = "passphrase_wihtout_keyring"
    ),
    session = shiny::getDefaultReactiveDomain()
  )
}

#' @export
server <- function(id, input, output, session) {

    auth()
    router_server("home")
    home_page$home_server("home")
    monitoring_page$monitoring_server("monitoring")
    validation_page$validation_server("validation")
    more_insights_page$server("insights")
    assessment_page$assessment_server("assessment")
    data_quality_page$data_quality_server("data_quality")
    data_lineage_page$data_lineage_server("data_lineage")
}

# server <- function(id) {
#   moduleServer(id, function(input, output, session) {
#
#     shinymanager::secure_server(check_credentials)
#
#     router_server("home")
#     home_page$home_server("home")
#     monitoring_page$monitoring_server("monitoring")
#     validation_page$validation_server("validation")
#     more_insights_page$server("insights")
#     assessment_page$assessment_server("assessment")
#     data_quality_page$data_quality_server("data_quality")
#     data_lineage_page$data_lineage_server("data_lineage")
#   })
# }
