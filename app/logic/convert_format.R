box::use(
  shiny[reactive],
  lubridate,
  dataMaid,
  dplyr[filter, distinct],
  magrittr[`%>%`],
)

###################### je convertie les types de variables de mes XML files

############## Suppression des .rmd dans le www/
del_rmd <- function(){
  dossier <- "www/"
  fichiers_a_supprimer2 <- list.files(dossier, pattern = "\\.Rmd$")

  # Suppression des fichiers
  sapply(fichiers_a_supprimer2, function(fichier) file.remove(file.path(dossier, fichier)))
}

######### Cette fonction convertie les types des colonnes (sauf pour indicative)
convert_format <- function(){
  ### File PowerTimePoint_ELIA_final ############
  path_1 <- file.path(getwd(), "app/data/rds/PowerTimePoint_ELIA_final.rds")
  PowerTimePoint_ELIA_final <-readRDS(file = path_1)

  PowerTimePoint_ELIA_final$PowerTimePoint.atTime <- lubridate::ymd_hms(PowerTimePoint_ELIA_final$PowerTimePoint.atTime)
  PowerTimePoint_ELIA_final$PowerTimePoint.activatedP <- as.numeric(PowerTimePoint_ELIA_final$PowerTimePoint.activatedP)
  PowerTimePoint_ELIA_final$PowerTimePoint.activatedPrice <- as.numeric(PowerTimePoint_ELIA_final$PowerTimePoint.activatedPrice)

  # Save a single object to a file
  saveRDS(PowerTimePoint_ELIA_final, paste(paste0("app/data/rds/","PowerTimePoint_ELIA_final.rds", sep="")))

  ### File PowerTimePoint_ELIA_provisional ############
  path_2 <- file.path(getwd(), "app/data/rds/PowerTimePoint_ELIA_provisional.rds")
  PowerTimePoint_ELIA_provisional <-readRDS(file = path_2)

  PowerTimePoint_ELIA_provisional$PowerTimePoint.atTime <- lubridate::ymd_hms(PowerTimePoint_ELIA_provisional$PowerTimePoint.atTime)
  PowerTimePoint_ELIA_provisional$PowerTimePoint.activatedP <- as.numeric(PowerTimePoint_ELIA_provisional$PowerTimePoint.activatedP)
  PowerTimePoint_ELIA_provisional$PowerTimePoint.activatedPrice <- as.numeric(PowerTimePoint_ELIA_provisional$PowerTimePoint.activatedPrice)
  # Save a single object to a file
  saveRDS(PowerTimePoint_ELIA_provisional, paste(paste0("app/data/rds/","PowerTimePoint_ELIA_provisional.rds", sep="")))


  ### File PowerTimePoint_ELIA_real ############
  path_3 <- file.path(getwd(), "app/data/rds/PowerTimePoint_ELIA_real.rds")
  PowerTimePoint_ELIA_real <-readRDS(file = path_3)

  PowerTimePoint_ELIA_real$PowerTimePoint.atTime <- lubridate::ymd_hms(PowerTimePoint_ELIA_real$PowerTimePoint.atTime)
  PowerTimePoint_ELIA_real$PowerTimePoint.activatedP <- as.numeric(PowerTimePoint_ELIA_real$PowerTimePoint.activatedP)
  PowerTimePoint_ELIA_real$PowerTimePoint.activatedPrice <- as.numeric(PowerTimePoint_ELIA_real$PowerTimePoint.activatedPrice)
  # Save a single object to a file
  saveRDS(PowerTimePoint_ELIA_real, paste(paste0("app/data/rds/","PowerTimePoint_ELIA_real.rds", sep="")))


  ### File FullModel_ELIA_real ############
  path_4 <- file.path(getwd(), "app/data/rds/FullModel_ELIA_real.rds")
  FullModel_ELIA_real <-readRDS(file = path_4)

  FullModel_ELIA_real$generatedAtTime <- lubridate::ymd_hms(FullModel_ELIA_real$generatedAtTime)
  FullModel_ELIA_real$startDate <- lubridate::ymd_hms(FullModel_ELIA_real$startDate)
  FullModel_ELIA_real$endDate <- lubridate::ymd_hms(FullModel_ELIA_real$endDate)
  FullModel_ELIA_real$version <- as.numeric(FullModel_ELIA_real$version)
  #### distinction des colonnes
  FullModel_ELIA_real <- FullModel_ELIA_real %>%
    dplyr::distinct(generatedAtTime, startDate, endDate, publisher, version, title)

  saveRDS(FullModel_ELIA_real, paste(paste0("app/data/rds/","FullModel_ELIA_real.rds", sep="")))

  ### File PowerSchedule_ELIA_real ############
  path_5 <- file.path(getwd(), "app/data/rds/PowerSchedule_ELIA_real.rds")
  PowerSchedule_ELIA_real <-readRDS(file = path_5)
  #### distinction des colonnes
  PowerSchedule_ELIA_real <- PowerSchedule_ELIA_real %>%
    dplyr::distinct(IdentifiedObject.description)

  saveRDS(PowerSchedule_ELIA_real, paste(paste0("app/data/rds/","PowerSchedule_ELIA_real.rds", sep="")))


  ### File RedispatchScheduleAction_ELIA_real ############
  path_6 <- file.path(getwd(), "app/data/rds/RedispatchScheduleAction_ELIA_real.rds")
  RedispatchScheduleAction_ELIA_real <-readRDS(file = path_6)
  #### distinction des colonnes
  RedispatchScheduleAction_ELIA_real <- RedispatchScheduleAction_ELIA_real %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID,
                    IdentifiedObject.description, PowerScheduleAction.currency)

  saveRDS(RedispatchScheduleAction_ELIA_real, paste(paste0("app/data/rds/","RedispatchScheduleAction_ELIA_real.rds", sep="")))


  ### File RemedialActionCost_ELIA_real ############
  path_7 <- file.path(getwd(), "app/data/rds/RemedialActionCost_ELIA_real.rds")
  RemedialActionCost_ELIA_real <-readRDS(file = path_7)

  RemedialActionCost_ELIA_real$RemedialActionCost.startupCost <- as.numeric(RemedialActionCost_ELIA_real$RemedialActionCost.startupCost)
  RemedialActionCost_ELIA_real$RemedialActionCost.shutdownCost <- as.numeric(RemedialActionCost_ELIA_real$RemedialActionCost.shutdownCost)
  RemedialActionCost_ELIA_real$RemedialActionCost.otherCost <- as.numeric(RemedialActionCost_ELIA_real$RemedialActionCost.otherCost)
  #### distinction des colonnes
  RemedialActionCost_ELIA_real <- RemedialActionCost_ELIA_real %>%
    dplyr::distinct(RemedialActionCost.startupCost,
                    RemedialActionCost.shutdownCost, RemedialActionCost.otherCost,
                    RemedialActionCost.kind, RemedialActionCost.RemedialActionSchedule)

  saveRDS(RemedialActionCost_ELIA_real, paste(paste0("app/data/rds/","RemedialActionCost_ELIA_real.rds", sep="")))


  ### File RemedialActionSchedule_ELIA_real ############
  path_8 <- file.path(getwd(), "app/data/rds/RemedialActionSchedule_ELIA_real.rds")
  RemedialActionSchedule_ELIA_real <-readRDS(file = path_8)
  #### distinction des colonnes
  RemedialActionSchedule_ELIA_real <- RemedialActionSchedule_ELIA_real %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID)

  saveRDS(RemedialActionSchedule_ELIA_real, paste(paste0("app/data/rds/","RemedialActionSchedule_ELIA_real.rds", sep="")))

  # ### File RemedialActionScheduleGroup_ELIA_real ############
  # path_9 <- file.path(getwd(), "app/data/rds/RemedialActionScheduleGroup_ELIA_real.rds")
  # RemedialActionScheduleGroup_ELIA_real <-readRDS(file = path_9)

  ### File FullModel_ELIA_final ############
  path_10 <- file.path(getwd(), "app/data/rds/FullModel_ELIA_final.rds")
  FullModel_ELIA_final <-readRDS(file = path_10)

  FullModel_ELIA_final$generatedAtTime <- lubridate::ymd_hms(FullModel_ELIA_final$generatedAtTime)
  FullModel_ELIA_final$startDate <- lubridate::ymd_hms(FullModel_ELIA_final$startDate)
  FullModel_ELIA_final$endDate <- lubridate::ymd_hms(FullModel_ELIA_final$endDate)
  FullModel_ELIA_final$version <- as.numeric(FullModel_ELIA_final$version)
  #### distinction des colonnes
  FullModel_ELIA_final <- FullModel_ELIA_final %>%
    dplyr::distinct(generatedAtTime, startDate, endDate, publisher, version, title)

  saveRDS(FullModel_ELIA_final, paste(paste0("app/data/rds/","FullModel_ELIA_final.rds", sep="")))


  ### File RemedialActionCost_ELIA_final ############
  path_11 <- file.path(getwd(), "app/data/rds/RemedialActionCost_ELIA_final.rds")
  RemedialActionCost_ELIA_final <-readRDS(file = path_11)

  RemedialActionCost_ELIA_final$RemedialActionCost.startupCost <- as.numeric(RemedialActionCost_ELIA_final$RemedialActionCost.startupCost)
  RemedialActionCost_ELIA_final$RemedialActionCost.shutdownCost <- as.numeric(RemedialActionCost_ELIA_final$RemedialActionCost.shutdownCost)
  RemedialActionCost_ELIA_final$RemedialActionCost.otherCost <- as.numeric(RemedialActionCost_ELIA_final$RemedialActionCost.otherCost)
  #### distinction des colonnes
  RemedialActionCost_ELIA_final <- RemedialActionCost_ELIA_final %>%
    dplyr::distinct(RemedialActionCost.startupCost,
                    RemedialActionCost.shutdownCost, RemedialActionCost.otherCost,
                    RemedialActionCost.kind, RemedialActionCost.RemedialActionSchedule)

  saveRDS(RemedialActionCost_ELIA_final, paste(paste0("app/data/rds/","RemedialActionCost_ELIA_final.rds", sep="")))


  ### File FullModel_ELIA_provisional ############
  path_12 <- file.path(getwd(), "app/data/rds/FullModel_ELIA_provisional.rds")
  FullModel_ELIA_provisional <-readRDS(file = path_12)

  FullModel_ELIA_provisional$generatedAtTime <- lubridate::ymd_hms(FullModel_ELIA_provisional$generatedAtTime)
  FullModel_ELIA_provisional$startDate <- lubridate::ymd_hms(FullModel_ELIA_provisional$startDate)
  FullModel_ELIA_provisional$endDate <- lubridate::ymd_hms(FullModel_ELIA_provisional$endDate)
  FullModel_ELIA_provisional$version <- as.numeric(FullModel_ELIA_provisional$version)
  #### distinction des colonnes
  FullModel_ELIA_provisional <- FullModel_ELIA_provisional %>%
    dplyr::distinct(generatedAtTime, startDate, endDate, publisher, version, title)

  saveRDS(FullModel_ELIA_provisional, paste(paste0("app/data/rds/","FullModel_ELIA_provisional.rds", sep="")))


  ### File RemedialActionCost_ELIA_provisional ############
  path_13 <- file.path(getwd(), "app/data/rds/RemedialActionCost_ELIA_real.rds")
  RemedialActionCost_ELIA_provisional <-readRDS(file = path_13)

  RemedialActionCost_ELIA_provisional$RemedialActionCost.startupCost <- as.numeric(RemedialActionCost_ELIA_provisional$RemedialActionCost.startupCost)
  RemedialActionCost_ELIA_provisional$RemedialActionCost.shutdownCost <- as.numeric(RemedialActionCost_ELIA_provisional$RemedialActionCost.shutdownCost)
  RemedialActionCost_ELIA_provisional$RemedialActionCost.otherCost <- as.numeric(RemedialActionCost_ELIA_provisional$RemedialActionCost.otherCost)
  #### distinction des colonnes
  RemedialActionCost_ELIA_provisional <- RemedialActionCost_ELIA_provisional %>%
    dplyr::distinct(RemedialActionCost.startupCost,
                    RemedialActionCost.shutdownCost, RemedialActionCost.otherCost,
                    RemedialActionCost.kind, RemedialActionCost.RemedialActionSchedule)

  saveRDS(RemedialActionCost_ELIA_provisional, paste(paste0("app/data/rds/","RemedialActionCost_ELIA_provisional.rds", sep="")))

  ### File PowerSchedule_ELIA_final ############
  path_14 <- file.path(getwd(), "app/data/rds/PowerSchedule_ELIA_final.rds")
  PowerSchedule_ELIA_final <-readRDS(file = path_14)
  #### distinction des colonnes
  PowerSchedule_ELIA_final <- PowerSchedule_ELIA_final %>%
    dplyr::distinct(IdentifiedObject.description)

  saveRDS(PowerSchedule_ELIA_final, paste(paste0("app/data/rds/","PowerSchedule_ELIA_final.rds", sep="")))

  ### File PowerSchedule_ELIA_provisional ############
  path_15 <- file.path(getwd(), "app/data/rds/PowerSchedule_ELIA_provisional.rds")
  PowerSchedule_ELIA_provisional <-readRDS(file = path_15)
  #### distinction des colonnes
  PowerSchedule_ELIA_provisional <- PowerSchedule_ELIA_provisional %>%
    dplyr::distinct(IdentifiedObject.description)

  saveRDS(PowerSchedule_ELIA_provisional, paste(paste0("app/data/rds/","PowerSchedule_ELIA_provisional.rds", sep="")))

  ### File RedispatchScheduleAction_ELIA_final ############
  path_16 <- file.path(getwd(), "app/data/rds/RedispatchScheduleAction_ELIA_final.rds")
  RedispatchScheduleAction_ELIA_final <-readRDS(file = path_16)
  #### distinction des colonnes
  RedispatchScheduleAction_ELIA_final <- RedispatchScheduleAction_ELIA_final %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID,
                    IdentifiedObject.description, PowerScheduleAction.currency)

  saveRDS(RedispatchScheduleAction_ELIA_final, paste(paste0("app/data/rds/","RedispatchScheduleAction_ELIA_final.rds", sep="")))

  ### File RedispatchScheduleAction_ELIA_provisional ############
  path_17 <- file.path(getwd(), "app/data/rds/RedispatchScheduleAction_ELIA_provisional.rds")
  RedispatchScheduleAction_ELIA_provisional <-readRDS(file = path_17)
  #### distinction des colonnes
  RedispatchScheduleAction_ELIA_provisional <- RedispatchScheduleAction_ELIA_provisional %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID,
                    IdentifiedObject.description, PowerScheduleAction.currency)

  saveRDS(RedispatchScheduleAction_ELIA_provisional, paste(paste0("app/data/rds/","RedispatchScheduleAction_ELIA_provisional.rds", sep="")))


  ### File RemedialActionSchedule_ELIA_final ############
  path_18 <- file.path(getwd(), "app/data/rds/RemedialActionSchedule_ELIA_final.rds")
  RemedialActionSchedule_ELIA_final <-readRDS(file = path_18)
  #### distinction des colonnes
  RemedialActionSchedule_ELIA_final <- RemedialActionSchedule_ELIA_final %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID)

  saveRDS(RemedialActionSchedule_ELIA_final, paste(paste0("app/data/rds/","RemedialActionSchedule_ELIA_final.rds", sep="")))


  ### File RemedialActionSchedule_ELIA_provisional ############
  path_19 <- file.path(getwd(), "app/data/rds/RemedialActionSchedule_ELIA_provisional.rds")
  RemedialActionSchedule_ELIA_provisional <-readRDS(file = path_19)
  #### distinction des colonnes
  RemedialActionSchedule_ELIA_provisional <- RemedialActionSchedule_ELIA_provisional %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID)

  saveRDS(RemedialActionSchedule_ELIA_provisional, paste(paste0("app/data/rds/","RemedialActionSchedule_ELIA_provisional.rds", sep="")))

  ### File FullModel_ELIA_indicative ############
  path_22 <- file.path(getwd(), "app/data/rds/FullModel_ELIA_indicative.rds")
  FullModel_ELIA_indicative <-readRDS(file = path_22)

  FullModel_ELIA_indicative$generatedAtTime <- lubridate::ymd_hms(FullModel_ELIA_indicative$generatedAtTime)
  FullModel_ELIA_indicative$startDate <- lubridate::ymd_hms(FullModel_ELIA_indicative$startDate)
  FullModel_ELIA_indicative$endDate <- lubridate::ymd_hms(FullModel_ELIA_indicative$endDate)
  FullModel_ELIA_indicative$version <- as.numeric(FullModel_ELIA_indicative$version)
  #### distinction des colonnes
  FullModel_ELIA_indicative <- FullModel_ELIA_indicative %>%
    dplyr::distinct(generatedAtTime, startDate, endDate, version)

  saveRDS(FullModel_ELIA_indicative, paste(paste0("app/data/rds/","FullModel_ELIA_indicative.rds", sep="")))

  ### File PowerTimePoint_ELIA_indicative ############
  path_23 <- file.path(getwd(), "app/data/rds/PowerTimePoint_ELIA_indicative.rds")
  PowerTimePoint_ELIA_indicative <-readRDS(file = path_23)

  PowerTimePoint_ELIA_indicative$PowerTimePoint.atTime <- lubridate::ymd_hms(PowerTimePoint_ELIA_indicative$PowerTimePoint.atTime)
  PowerTimePoint_ELIA_indicative$PowerTimePoint.activatedP <- as.numeric(PowerTimePoint_ELIA_indicative$PowerTimePoint.activatedP)
  PowerTimePoint_ELIA_indicative$PowerTimePoint.activatedPrice <- as.numeric(PowerTimePoint_ELIA_indicative$PowerTimePoint.activatedPrice)
  # Save a single object to a file
  saveRDS(PowerTimePoint_ELIA_indicative, paste(paste0("app/data/rds/","PowerTimePoint_ELIA_indicative.rds", sep="")))

  ### File PowerSchedule_ELIA_indicative ############
  path_24 <- file.path(getwd(), "app/data/rds/PowerSchedule_ELIA_indicative.rds")
  PowerSchedule_ELIA_indicative <-readRDS(file = path_24)
  #### distinction des colonnes
  PowerSchedule_ELIA_indicative <- PowerSchedule_ELIA_indicative %>%
    dplyr::distinct(IdentifiedObject.description)

  saveRDS(PowerSchedule_ELIA_indicative, paste(paste0("app/data/rds/","PowerSchedule_ELIA_indicative.rds", sep="")))

  ### File RemedialActionSchedule_ELIA_indicative ############
  path_25 <- file.path(getwd(), "app/data/rds/RemedialActionSchedule_ELIA_indicative.rds")
  RemedialActionSchedule_ELIA_indicative <-readRDS(file = path_25)
  #### distinction des colonnes
  RemedialActionSchedule_ELIA_indicative <- RemedialActionSchedule_ELIA_indicative %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID)

  saveRDS(RemedialActionSchedule_ELIA_indicative, paste(paste0("app/data/rds/","RemedialActionSchedule_ELIA_indicative.rds", sep="")))


  ### File RedispatchScheduleAction_ELIA_indicative ############
  path_26 <- file.path(getwd(), "app/data/rds/RedispatchScheduleAction_ELIA_indicative.rds")
  RedispatchScheduleAction_ELIA_indicative <-readRDS(file = path_26)
  #### distinction des colonnes
  RedispatchScheduleAction_ELIA_indicative <- RedispatchScheduleAction_ELIA_indicative %>%
    dplyr::distinct(IdentifiedObject.name, IdentifiedObject.mRID,
                    IdentifiedObject.description, PowerScheduleAction.currency)

  saveRDS(RedispatchScheduleAction_ELIA_indicative, paste(paste0("app/data/rds/","RedispatchScheduleAction_ELIA_indicative.rds", sep="")))

  # ### File RemedialActionScheduleGroup_ELIA_final ############
  # path_20 <- file.path(getwd(), "app/data/rds/RemedialActionScheduleGroup_ELIA_final.rds")
  # RemedialActionScheduleGroup_ELIA_final <-readRDS(file = path_20)

  # ### File RemedialActionScheduleGroup_ELIA_provisional ############
  # path_21 <- file.path(getwd(), "app/data/rds/RemedialActionScheduleGroup_ELIA_provisional.rds")
  # RemedialActionScheduleGroup_ELIA_provisional <-readRDS(file = path_21)

}

#Liste de tous les fichiers RDS
rds_files_list <- list.files(pattern="\\.rds", path='app/data/rds/', full.names=TRUE)
#Nombre de fichiers RDS
nbre_rds_files <- length(rds_files_list)

# Récupérer le nom de fichier sans l'extension
rds_files_no_extension <- tools::file_path_sans_ext(basename(rds_files_list))


### Creation des REPORTS de tous les fichiers##################

make_report <- function(){
  ## Make Repotrts
  ################### chargement des dataFrame
  liste <- list.files(path="app/data/rds/",
                      pattern = '.rds', full.names = TRUE)
  for (fichier in liste){
    nom_variable <- tools::file_path_sans_ext(basename(fichier))
    assign(nom_variable, readRDS(fichier))
  }

  path <- file.path(getwd(), "www//")
  for (i in 1:nbre_rds_files) {
    print(rds_files_no_extension[i])
    dataMaid::makeDataReport(get(rds_files_no_extension[i]), file = paste(path,rds_files_no_extension[i]),
                             output = "html", reportTitle = rds_files_no_extension[i], openResult = FALSE, replace = TRUE)
  }

  del_rmd()
}


