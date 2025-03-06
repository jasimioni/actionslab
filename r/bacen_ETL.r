# CLEAR ENVIRONMENT ############################################################

# Remove all objects from the environment
rm(list = ls())

# Run garbage collection
gc()

# INSTALL AND LOAD PACKAGES ####################################################

# packages = c(
#   'GetBCBData',
#   'openxlsx',
#   'tidyverse')
# 
# 
# for (pkg in packages) {
#   if (!require(pkg, character.only = TRUE)) {
#     install.packages(pkg, repos = "https://cran.rstudio.com/", method = "libcurl")
#   } 
#   library(pkg, character.only = TRUE)
# }

# LOAD PACKAGES ################################################################

packages = c(
  'GetBCBData',
  'openxlsx',
  'dplyr', 'tidyr'
  )

for (pkg in packages) {
  library(pkg, character.only = TRUE)
}

# TIME CONTROL #################################################################


# Record the start time
start_time <- Sys.time()

# PARAMETERS ####

file_name = "credito"

tema = "Crédito"

output_folder = "lake/"

data_ini = '1995-01-01'

# LIBRARY ####

# # Carregar glossário:
# library_bacen_PT = read_xlsx("library/library_bacen_PT.xlsx", sheet = "library")
# 
# # Converter as colunas 'Início' para data
# library_bacen_PT <- library_bacen_PT %>%
#   mutate(across(c(`Início`), as.Date))
# 
# # Filtrar e selecionar `Código` das séries:
# ids_bacen = library_bacen_PT %>% filter(Tema %in% tema) %>% select("Código") %>% pull()
# 
# source("./scripts/ids_credito.R")
# ids_bacen = ids_credito

ids_bacen = c(28183, 28184)

# DOWNLOAD SIMPLES ####

# comando:
df = gbcbd_get_series(
  id = ids_bacen,
  first.date = data_ini,
  last.date  = Sys.Date(),
)

# Delete column:
df$series.name = NULL

# Rename colnames:
df <- df %>%
  rename(
    data = ref.date,
    `Código` = id.num,
    valor = value
  )

# Spread the dataframe:
df <- df %>%
  spread(key = `Código`, value = valor)

# Sort the dataframe by the data column:
df <- df %>%
  arrange(data)

save(df, file = paste0(output_folder, file_name, ".rdata"))

# TIME CONTROL ####
# Record the end time:
end_time <- Sys.time()

# Calculate the duration:
duration <- end_time - start_time

# Extract hours, minutes, and seconds:
hours <- as.numeric(duration, units = "hours") %/% 1
minutes <- as.numeric(duration, units = "mins") %/% 1 %% 60
seconds <- as.numeric(duration, units = "secs") %/% 1 %% 60

# Format the duration as hh:mm:ss:
duration <- sprintf("%02d:%02d:%02d", hours, minutes, seconds)

# TEMPO DE EXECUÇÃO:
print(duration)

# END ####
