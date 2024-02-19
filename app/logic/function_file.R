box::use(
  ggplot2,
  magrittr[`%>%`],
  dplyr,
  xml2
)

box::use(
  app/view/monitoring_page
)

box::use(
  app/logic/data_csv_process,
  app/logic/convert_format,
  app/logic/data_xml_process[dataProcess],
)

#### Reading ALL XML Files ##########
xml_files_list <- list.files(pattern="\\.xml", path='app/data/xml/', full.names=TRUE)

##### All detect XML FILES
print(paste("Fichiers XML detecter: ", xml_files_list))

##### Size of xml_files_list
xml_files_size <- length(xml_files_list)

xml_files_no_extension <- tools::file_path_sans_ext(basename(xml_files_list))

chaine <- xml_files_no_extension


####### Praitraitement des fichier XML : On retire tout les commentaires
remove_comment <- function(dir){
  # Lire le fichier XML
  doc <- xml2::read_xml(dir)

  # Supprimer les commentaires
  xml_comments <- xml2::xml_find_all(doc, ".//comment()")  # Trouver tous les commentaires
  for (comment in xml_comments) {
    xml2::xml_remove(comment)  # Supprimer chaque commentaire
  }

  # Écrire le nouveau contenu dans un nouveau fichier
  xml2::write_xml(doc, dir)
}

############## Process data XML
for (i in 1:xml_files_size) {

  ############### remove all comment
  remove_comment(xml_files_list[i])

  ######## detection des mots exemple: mot1 - ELIA, mot de fin - provisional
  mots <- unlist(strsplit(chaine[i], "_"))
  ####### Process data XML
  dataProcess(paste("", xml_files_list[i], sep = ""), paste("_", mots[1], sep = ""),
              paste("_", mots[length(mots)], sep = ""))
}

################ convertion des types des colonnes des dataFrames
convert_format$convert_format()

############### genration automatique des reports
html_files_list <- list.files(pattern="\\.html", path='www/', full.names=TRUE)
if(length(html_files_list) > 0){
  print("rapports déjà générés")
}else{
  convert_format$make_report()
}

############ Suppression des rapport dans le www/
del_reports <- function(){
  dossier <- "www/"

  fichiers_a_supprimer <- list.files(dossier, pattern = "\\.html$")

  # Suppression des fichiers
  sapply(fichiers_a_supprimer, function(fichier) file.remove(file.path(dossier, fichier)))
}


############ Suppression des datasets au format RDS
del_datasets_rds <- function(){
  dossier <- "app/data/rds/"

  fichiers_a_supprimer <- list.files(dossier, pattern = "\\.rds$")

  # Suppression des fichiers
  sapply(fichiers_a_supprimer, function(fichier) file.remove(file.path(dossier, fichier)))
}



