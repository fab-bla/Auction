# files 
setwd("C:/Users/blasc/OneDrive/Documents/GitHub/Auction/Code")
dat_aucs <- readRDS("./../Data/Bid Tab RDS/Aucs_df_feateng.RDS")
split_ind <- readRDS("./../Data/Bid Tab RDS/Colab Transfer/split_indices.RDS")

# write csvs
write.csv(dat_aucs, "./../Data/Bid Tab RDS/Colab Transfer/csv/dat_aucs_feateng.csv",
          row.names = FALSE)

# indices
Map(\(x, n){
  
  # write
  write.csv(x, paste0("./../Data/Bid Tab RDS/Colab Transfer/csv/", n, ".csv"),
            row.names = FALSE)

  
}, split_ind, names(split_ind))



# loop over dfs and create csv
# Map(\(x, n){
#   
#   # import
#   imp <- readRDS(paste0("./../Data/Bid Tab RDS/Colab Transfer/", x))
#   
#   # if data.frame then
#   if(class(imp) == "data.frame" | class(imp)[3] == "data.frame"){
# 
#     # write csv
#     write.csv(imp, 
#               paste0("./../Data/Bid Tab RDS/Colab Transfer/csv/", n, ".csv"),
#               row.names = FALSE)
#     
#     # excel
#     openxlsx::write.xlsx(imp, 
#                          paste0("./../Data/Bid Tab RDS/Colab Transfer/csv/", n, 
#                                 ".xlsx"))
#   }
#   
# }, files, file_names)


