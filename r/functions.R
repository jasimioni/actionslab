# INSTALL AND LOAD PACKAGES ----------------------------------------------------

install_and_load_packages <- function(...) {
  # Capture the arguments as a character vector
  packages <- c(...)
  
  # Check if all inputs are strings
  if (!all(sapply(packages, is.character))) {
    stop("All input arguments must be strings representing package names.")
  }
  
  for (pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
      install.packages(pkg, method = "wget")
    } 
    library(pkg, character.only = TRUE)
  } 
}

# END --------------------------------------------------------------------------

# GET FOLDER AND FILE NAMES ----------------------------------------------------

get_folder_and_file_names <- function(folder = getwd()) {
  
  # Get all file names and folder names in the folder and its subfolders
  all_items <- list.files(path = folder, recursive = TRUE, full.names = TRUE, include.dirs = TRUE)
  
  # Separate files and folders
  files <- all_items[!file.info(all_items)$isdir]
  folders <- all_items[file.info(all_items)$isdir]
  
  # Get relative paths for files without extensions
  files <- gsub(folder, "", files)
  folders <- gsub(folder, "", folders)
  folders = c(getwd(), folders)
  
  # Save variables to the global environment
  assign("files", files, envir = .GlobalEnv)
  assign("folders", folders, envir = .GlobalEnv)
  
  # Print the relative file names
  cat("The files are:\n")
  print(files)
  
  # Print the folder names
  cat("The folders are:\n")
  print(folders)
  
  }

# Run the function
get_folder_and_file_names()


# END --------------------------------------------------------------------------

# LOAD XLSX TO LIST ------------------------------------------------------------

load_xlsx_to_list <- function(folder = "./", file_name, list_name) {
  
  # Packages
  packages = c('readxl')
  
  for (pkg in packages) {
    if (!require(pkg, character.only = TRUE)) {
      install.packages(pkg, method = "wininet")
    } 
    library(pkg, character.only = TRUE)
  }
  
  # Create the path
  path <- file.path(folder, file_name)
  
  # Get the names of all sheets in the Excel file
  sheet_names <- excel_sheets(path)
  
  # Read all sheets into a named list of data frames
  xlsx_list <- setNames(lapply(sheet_names, function(sheet) {
    read_excel(path, sheet = sheet)
  }), sheet_names)
  
  # Assign the list to the global environment
  assign(list_name, xlsx_list, envir = .GlobalEnv)
  
  # Print the list names to check
  print(names(get(list_name)))
}

# END --------------------------------------------------------------------------

# CLEAR ENVIRONMENT ------------------------------------------------------------
  
  clear_environment = function(){
    
    # Remove all objects from the environment
    rm(list = ls())
    
  }

# END --------------------------------------------------------------------------

# SAVE IN F1 LIST --------------------------------------------------------------

# # Get all objects in the environment
# all_objects <- ls()
# 
# # Filter only functions
# functions <- all_objects[sapply(all_objects, function(x) is.function(get(x)))]
# 
# # Create a list with these functions, naming each element after its respective function name
# f1 = list()
# f1 <- setNames(lapply(functions, function(x) get(x)), functions)
# 
# # Print the list to verify
# print(f1)
# 
# save(f1, file = "f1.rdata")


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------


