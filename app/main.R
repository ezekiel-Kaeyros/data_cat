box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, textOutput,
        renderText, reactive, req, observeEvent, enableBookmarking, actionButton,
        reactiveValuesToList],
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

box::use(
  app/logic/sendMail
)

# ############## creation du keyring and connect
#keyring::key_set("R-shinymanager-key", "datacatalogapp")
#keyring::key_set_with_value("R-shinymanager-key", "datacatalogapp", password = "Kaeyros@data@237@key")

########### Define Credential
# credentials <- data.frame(
#   user = c("admin","admin_kaeyros"),
#   password = c("Kaeyros@data@237@key","Kaeyros@data@237@key"),
#   # password will automatically be hashed
#   admin = c(FALSE, TRUE),
#   stringsAsFactors = FALSE
# )
################" Creation de la DB SQLite
# shinymanager::create_db(
#   credentials_data = credentials,
#   sqlite_path = "app/data/database.sqlite", # will be created
#   #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
#   passphrase = "passphrase_wihtout_keyring"
# )

ui <- function(id) {
  #ns <- NS(id) ne pas utilisé dans cet .env - rhino.yml

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

#Change labels
shinymanager::set_labels(
  language = c("en"),
  "Please authenticate" = "Authenticate"
)

#' @export
ui <- shinymanager::secure_app(ui,
theme = shinythemes::shinytheme("cerulean"),
  tags_top =
    tags$div(
      tags$head(
          tags$link(rel = "stylesheet", type="text/css", href ="login.css")
             ),
     tags$img(
     src = "logo.png", width = 100
    )
  ),
 tags_bottom = tags$div(
    tags$a(
      href = "google.com",
      target="_blank", "Forget password ?"
    )
),
    enable_admin = TRUE, choose_language = TRUE)

#' @export
server <- function(id, input, output, session) {

  res_auth <- shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(
      "app/data/database.sqlite",
      #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
      passphrase = "passphrase_wihtout_keyring"
    ),
    session = shiny::getDefaultReactiveDomain()
  )

  data <- reactive({
    reactiveValuesToList(res_auth)
  })

  router_server("home")
  home_page$home_server("home")
  monitoring_page$monitoring_server("monitoring")
  validation_page$validation_server("validation")
  more_insights_page$server("insights")
  assessment_page$assessment_server("assessment")
  data_quality_page$data_quality_server("data_quality")
  data_lineage_page$data_lineage_server("data_lineage")

  ####### envoie un mail apres la connexion
  #observeEvent(data()$user,{ sendMail$send_mail_login()})
}
