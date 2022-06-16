# files 
files <- list.files("./../Data/Bid Tab RDS/Colab Transfer")
files <- files[stringr::str_detect(files, ".RDS")]
file_names <- stringr::str_remove(files, ".RDS")
  
# loop over dfs and create csv
Map(\(x, n){
  
  # import
  imp <- readRDS(paste0("./../Data/Bid Tab RDS/Colab Transfer/", x))

  # if data.frame then
  if(class(imp)[3] == "data.frame"){

    # write csv
    write.csv(imp, 
              paste0("./../Data/Bid Tab RDS/Colab Transfer/csv/", n, ".csv"),
              row.names = FALSE)
    
    # excel
    openxlsx::write.xlsx(imp, 
                         paste0("./../Data/Bid Tab RDS/Colab Transfer/csv/", n, 
                                ".xlsx"))
  }
  
}, files, file_names)


