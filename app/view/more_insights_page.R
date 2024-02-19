box::use(
  shiny[div, moduleServer, tagList, NS, img, a, h1, h3, renderUI, uiOutput,
        insertUI, reactive, reactiveFileReader, observeEvent],
  stringr[str_detect],
)

box::use(
  app/view/components/cards,
  app/view/components/common/panel
)


#' @export
ui <- function(id) {
  ns <- NS(id)

  uiOutput(ns("insight"))
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session){

    ns <- session$ns

    insights <- reactiveFileReader(1000, NULL,
                                   'app/data/insights/insights.rds', readRDS)

    subtitle <- reactive({
      subtitle <- insights()$`DataName`
      subtitle
    })
    back_url <- reactive({
      back_url <- insights()$`back_url`
      back_url
    })

    output$insight <- renderUI({
      ############# Vérification de l'extension du process: Final, Real, ou Provisional
      if(str_detect(subtitle(), "_final")){
        ext <- "final"
      }else if(str_detect(subtitle(), "real-final")){
        ext <- "real"
      }else if(str_detect(subtitle(), "provisional")){
        ext <- "provisional"
      }else{
        ext <- "indicative"
      }
      type <- "ELIA"

      # Liste de tous les HTML appartenant au Type avec le mot ext dans sa chaîne
      report_files_list <- list.files(pattern=paste(type,"_",ext,"\\.html", sep = ""), path='www/', full.names=TRUE)
      # Nombre de files HTML appartenant au Type avec le mot ext dans sa chaîne
      nbre_report_files <- length(report_files_list)
      ################" On récupère juste les noms de ses fichiers
      report_files_no_extension <- tools::file_path_sans_ext(basename(report_files_list))

      tagList(
        div(class = "more_insights_page",
            h1(class = "more_insights_page__title", "See More Insights"),
            div(class = "more_insights_page__link",
                img(src = "./icons/leftIcon.svg"),
                a("Go Back", href = paste("#!/", back_url(), sep = "")),
            ),
            div(
              h1(class = "more_insights_page__subtitle", subtitle()),
              h3(class = "more_insights_page__description", "Click link to generate report"),

              div(class = "more_insights_page__list",
                  items <- lapply(1:nbre_report_files, function(i) {
                    print(paste("rapport :", i, sep = ""))
                    cards$more_insights_card("", paste("", report_files_no_extension[i],".html", sep = ""),
                                             paste("/_", report_files_no_extension[i], sep = ""))
                  }),
              )

            )
        )
      )

    })

  })
}
