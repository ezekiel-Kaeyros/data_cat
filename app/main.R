rm(list = ls()) # activate the step before execution !!!!!!
cat("\f")

box::use(
  shiny[bootstrapPage, div, moduleServer, NS, renderUI, tags, uiOutput, textOutput,
        renderText, reactive, req, observeEvent, enableBookmarking, actionButton,
        reactiveValuesToList, observe],
  shiny.router[router_server, route, router_ui],
  shiny.fluent[fluentPage, Text, ThemeProvider, Link],
  shinyjs,
  tibble,
  shinymanager,
  shinyDarkmode,
  keyring
)

box::use(
  app/view/home_page,
  app/view/monitoring_page,
  app/view/more_insights_page,
  app/view/documentation_page,
  app/view/data_lineage_page,
  app/view/data_quality_page,
  app/view/browse_page,
  app/view/components/layouts,
  app/view/components/common/panel,
  app/view/components/common/button
)

box::use(
  app/logic/sendMail,
  app/logic/data_csv_process,
)

# ############## creation du keyring and connect
#keyring::key_set("R-shinymanager-key", "datacatalogapp")
#keyring::key_set_with_value("R-shinymanager-key", "datacatalogapp", password = "Kaeyros@data@237@key")

######### Define Credential
# credentials <- data.frame(
#   user = c("admin","admin_kaeyros", "datacat_user", "datacat_user_2","datacat_user_3", "datacat_user_4", "datacat_user_5"),
#   password = c("admin","Kaeyros@data@237@key","CSV@datacat@2024@key",
#                "CSV@datacat@2024@key", "CSV@datacat@2024@key", "CSV@datacat@2024@key", "CSV@datacat@2024@key"),
#   # password will automatically be hashed
#   admin = c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE),
#   grade = c("user","super_admin","simple_admin","admin","admin","user","simple_admin"),
#   stringsAsFactors = FALSE
# )
# ###############" Creation de la DB SQLite
# shinymanager::create_db(
#   credentials_data = credentials,
#   sqlite_path = "app/data/database.sqlite", # will be created
#   #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
#   passphrase = "passphrase_wihtout_keyring"
# )

ui <- function(id) {
  #ns <- NS(id) ne pas utilisé dans cet .env - rhino.yml

  fluentPage(
    ######## initialize upload xlsx file function
    shinyjs::useShinyjs(),
    div(
      style = "
          visibility: hidden;
          height: 0;
          width: 0;
        ",
      shiny::fileInput("uploadFile", label = NULL)
    ),

    router_ui(
      route("browse", layouts$main_layout(browse_page$browse_page_ui("browse"))),
      route("home", layouts$main_layout(home_page$home_ui("home", textOutput("username")))),
      route("monitoring", layouts$main_layout(monitoring_page$monitoring_ui("monitoring"))),
      route("more-insights", layouts$main_layout(more_insights_page$ui("insights"))),
      route("documentation", layouts$main_layout(documentation_page$ui("documentation"))),
      route("data_lineage", layouts$main_layout(data_lineage_page$data_lineage_ui("data_lineage"))),
      route("data_quality", layouts$main_layout(data_quality_page$data_quality_ui("data_quality"))),
    ),

    ######## initialize Darkmode
    shinyDarkmode::use_darkmode(),
  )
}

#Change labels
shinymanager::set_labels(
  language = c("en"),
  "Please authenticate" = "Login"
)

#' @export
ui <- shinymanager::secure_app(ui,
  tags_top =
    tags$div(
      tags$head(
          tags$link(rel = "stylesheet", type="text/css", href ="login.css"),
          tags$link(rel = "stylesheet",
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"),
             ),
     tags$img(src = "logo.png", width = 100)
  ),
 tags_bottom = tags$div(
    tags$a(
      href = "https://kaeyros-analytics.com",
      target="_blank", "Forgot password ?"
    )
),
    enable_admin = TRUE, fab_position = "bottom-right") #choose_language = TRUE,



#' @export
server <- function(id, input, output, session) {

  res_auth <- shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(
      "app/data/database.sqlite",
      #passphrase = keyring::key_get("R-shinymanager-key", "datacatalogapp")
      passphrase = "passphrase_wihtout_keyring"
    ),
    #session = shiny::getDefaultReactiveDomain()
  )

  data <- reactive({
    reactiveValuesToList(res_auth)
  })
  ########### Darkmode function
  observeEvent(input$dark_mode, {
    print("dark")
  })

  shinyDarkmode::darkmode_toggle(session, inputid = 'dark_mode', autoMatchOsTheme = FALSE,
                                 saveInCookies = FALSE)

  router_server("browse")
  home_page$home_server("home")
  browse_page$browse_page_server("browse")
  monitoring_page$monitoring_server("monitoring")
  more_insights_page$server("insights")
  documentation_page$server("documentation")
  data_quality_page$data_quality_server("data_quality")
  data_lineage_page$data_lineage_server("data_lineage")

  ####### envoie un mail apres la connexion
  #observeEvent(data()$user,{ sendMail$send_mail_login(data()$user)})

  ######### The Grade of person login
  observeEvent(data()$user,{ print(paste(data()$user," Un auth de type :",data()$grade,
                                         " C'est connecté", sep = ""))})

  ########## The Username of the person login
  output$username <- renderText({
    data()$user
  })

  observeEvent(input$uploadFileButton, {
    shinyjs::click("uploadFile")
  })

  ####### Upload New File
  observe({
    if (is.null(input$uploadFile)) return()
    print(input$uploadFile$name)
    unlink("app/data/wait/csv_data_catalog.xlsx")
    file.copy(input$uploadFile$datapath, "app/data/wait/csv_data_catalog.xlsx")

    output$upload_file <- renderText({

      if(data_csv_process$upload_file() == "Done!"){
        ############# After 5s application restart
        shinyjs::delay(5000, session$reload())
        paste(data_csv_process$upload_file(), " / App restart in 5 seconds", sep = "")

      }else{
        shinyjs::delay(3000, sprintf(""))
        data_csv_process$upload_file()
      }
    })
  }) ### End Upload New File

}
