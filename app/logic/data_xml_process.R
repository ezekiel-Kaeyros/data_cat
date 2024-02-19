box::use(
  shiny[moduleServer, NS,],
  XML,
  xml2
)

xmldataframe <- data.frame()

# 1. loading XML data   ####

#' @export
dataProcess <- function(dir, ext, name){

  path_data <- dir #paste0(path_input, dir)

  ## 1.1 read required xml file ----
  result <- XML::xmlParse(file = dir)
  #print(result)

  ## 1.2 extract the root node from the xml file ----
  rootnode <- XML::xmlRoot(result)
  #print(rootnode)

  ## 1.3 get number of nodes in the root ----
  rootsize <- XML::xmlSize(rootnode)

  ## 1.4 get the details of the nodes contained in the XML file ----
  # for (i in 1:rootsize) {
  #   print(rootnode[i]) # $ALL_Nodes
  # }


  # ## 1.5 create data frame for all nodes #####

  # select xml file to be converted as a data frame
  # xml_data <- path_data # entire xml file
  # #xml_data <- rootnode[4]
  # xml_data
  #
  # #Convert the input xml file to a data frame.
  # xmldataframe <- XML::xmlToDataFrame(xml_data)
  #
  # ## save data.frame to rds file
  # saveRDS(xmldataframe, paste(paste0("app/data/","xmldataframe_final",".rds", sep="")))

  ## 1.6 create data frame for  single node

  # reading the xml data
  result <- XML::xmlParse(file = path_data)

  # extract the root node from the xml file
  rootnode <- XML::xmlRoot(result)

  # find number of nodes in the root
  rootsize <- XML::xmlSize(rootnode)

  # get names of all nodes contained in the xml file
  nodes_names <- as.vector(names(rootnode))

  # get unique names of all nodes contained in the xml file
  unique_nodes_names <- unique(as.vector(names(rootnode)))

  ########## Filtrage des datas
  filtre <- c("FullModel", "RemedialActionSchedule", "RedispatchScheduleAction",
              "RemedialActionCost", "PowerSchedule", "PowerTimePoint")
  unique_nodes_names <- unique_nodes_names[unique_nodes_names %in% filtre]

  #node_name <- unique_nodes_names[i]
  nbr_nodes <- length(unique_nodes_names)

  # set up some constants
  file_suffix <-  "_50Hertz"
  #j <- 1

  # creating data frames for each node
  for (j in 1:nbr_nodes){

    tryCatch({

      # print status
      print(paste(round((j/nbr_nodes)*100, digits = 2), "%",
                  " of all documents processed", sep=""))
      print(paste("counter_j=", j))

      # extracting node_name
      node_name <- unique_nodes_names[j]

      # get all nodes number having node.name as name
      indice_nodes <- which(nodes_names == node_name)

      # select sample nodes
      xml_data <- rootnode[indice_nodes]

      # extract required data frame
      formulae <- parse(text = paste(paste0(node_name,"_GLSK"
      ), " <- XML::xmlToDataFrame(xml_data)"
      , sep=""))

      # Save to RDS FORMAT
      saveRDS(eval(formulae), paste(paste0("app/data/rds/",node_name,ext,name,".rds", sep="")))

      #make eval of the expression
      eval(formulae)


    },error=function(e){cat("ERROR :",conditionMessage(e), "\n")}

    )

  }

}



