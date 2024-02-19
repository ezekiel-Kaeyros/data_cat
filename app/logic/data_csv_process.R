box::use(
  dplyr,
  utils,
  magrittr[`%>%`],
)

########## EXCEL file input ########
path_data <- "app/data/data_xl/csv_data_catalog.xlsx"
# 2. load meta input  ---- #

## 2.1 load meta file for data catalog ----
file.data <- path_data
data_catalog_init <- as.data.frame(readxl::read_excel(file.data))

#library(stringr)
# Replace One String with New String
# data_catalog_init <- data_catalog_init %>%
#   dplyr::mutate(across('InputDataBusinessProcess', str_replace, 'RD volumes and costs\r\nDE internal processes vs. Core',
#                        'RD volumes and costs DE internal processes vs. Core'))


## 2.2 remove empty variables ----
colnames_df <- colnames(data_catalog_init)
removed_cols <- c("Remarks","OutputData","OutputDataName",
                  "OuputDataDescription", "OutputDataType",
                  "OutputDataFormat", "OutputDataSourceSystem",
                  "OutputDataStorageSystem", "Remark")

data_catalog <- data_catalog_init[, !(colnames_df %in% removed_cols)]

###### Number of process
nbre_process <- length(unique(data_catalog$InputDataBusinessProcess))
###### create new dataFrame
data_catalog_final <-data.frame()

#### ADD col to final dataFrame: DataName, Description, Size, deliveryFrequency, TimeSerieRange, Format, SOurce, Remark

data_catalog_final <- data_catalog

for (data in data_catalog_final$InputData) {
  size <- c(format(utils::object.size(data), unit='kB', standard = "SI")) ### stocker la size des inputsDatas
}
#size <- 120
remarks <- c("None")
TimeSerieRange <- c(paste(as.Date(Sys.time())-1, " to ", Sys.Date(), sep = ""))
deliveryFrequency <- c("Weekly")

data_catalog_final$Size <- size
data_catalog_final$TimeSerieRange <- TimeSerieRange
data_catalog_final$deliveryFrequency <- deliveryFrequency
data_catalog_final$Remarks <- remarks

####### Add missing Variables
data_catalog_final <- data_catalog_final %>%
  dplyr::rename(DataName = InputDataName,
         Description = InputDataDescription,
         Source = InputDataSourceSystem,
         Format = InputDataFormat,
         Storage = InputDataStorageSystem)


##############  Process of DATA for select input
output_select <- function(input){

  data_catalog_select <- data_catalog %>%
    dplyr::distinct(InputDataBusinessLayer, InputDataBusinessProcess) %>%
    dplyr::filter(InputDataBusinessLayer == input )

  return(data_catalog_select)
}


##############  Process of DATA
output_data <- function(input){

  data_catalog_process <- data_catalog_final %>%
    dplyr::filter(InputDataBusinessLayer == input )

  data_catalog_process$pathString <- paste(data_catalog_process$InputDataBusinessLayer, data_catalog_process$InputDataBusinessProcess,
                                           data_catalog_process$DataName, sep = "/")

  ############## Remove Columns
  colnames_df <- colnames(data_catalog_process)
  removed_cols_final <- c("InputData")

  ############## Data for TabaleView
  datas_value <- data_catalog_process[, !(colnames_df %in% removed_cols_final)]
  return(datas_value)
}

#Liste de ligne de notre fichier CSV XML ou Datasets
nbre_datasets <- nrow(data_catalog_init)
