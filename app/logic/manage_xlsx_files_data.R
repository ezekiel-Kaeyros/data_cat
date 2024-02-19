box::use(
  shiny,
)

shinyApp(
  ui=shinyUI(bootstrapPage(
    fileInput("upload", "Upload", multiple = FALSE)
  )),

  server=shinyServer(function(input, output, session){
    observe({
      if (is.null(input$upload)) return()
      print(input$upload$name)
      file.copy("app/data/csv_data_catalog.xlsx", "app/data/Archives/csv_data_catalog.xlsx")
      unlink("app/data/csv_data_catalog.xlsx")
      file.copy(input$upload$datapath, "app/data/csv_data_catalog.xlsx")
    })
  })
)
