# CLEAR ENVIRONMENT ####

# FUNCTIONS ####################################################################

source(
  "functions.R"
)

# INSTALL AND LOAD PACKAGES ####

install_and_load_packages('GetBCBData', 'dplyr', 'tidyr')

# TIME CONTROL ####

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
