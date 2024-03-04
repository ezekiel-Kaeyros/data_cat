box::use(
  shiny[tagList, tags, img, NS, icon, div, actionButton, observeEvent, textOutput],
  shiny.fluent[Text, fluentPage, Image, DefaultButton.shinyInput, Link],
  shinyjs,
)

header <- tagList(
  div( class = "header_page",
       ############ Button for light and DarkMode
      actionButton("dark_mode", label = img (src="./icons/sun.svg", width="20", height="20"),
       style = "width: 20px; height: 20px; background-size: cover; background-color: #fff;
              	border: none; display: inline-block; float: right; margin-right: 100px;
                background-position: center;"),

      ############# Search Button
      Link(id = "search", href = "#!/browse", "", class = "fa fa-search",
           style = "float: right; margin: 5px; width: 20px; height: 20px;
         display: inline-block; background-position: center;"),

#      DefaultButton.shinyInput("dark_mode", iconProps = list(iconName = "Light"),
#                   style = "background-size: cover; background-color: #fff;
#               	border: none; float: right; margin-right: 100px; background-position: center;"),

     tags$style("
                #uploadFileButton{
                  color: white;
                  border: none;
                  background-color: #FF5733;
                }
                #search{
                  color: black;
                  border: none;
                  text-decoration: none;
                }
                "),
    ########### Button for upload XLSX FILE
     DefaultButton.shinyInput("uploadFileButton", text = "Upload New XLSX",
       iconProps = list(iconName = "Upload")
     ),
    textOutput("upload_file"),
  )
)

#' @export
header_ui <- fluentPage(
  header
)
