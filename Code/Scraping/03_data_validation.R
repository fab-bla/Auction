# source AUX
source("./Misc/Auxilliary.R")

# load and merge data
years <- 2015:2021

# load all files
lapply(years, \(x){
  
  # load
  readRDS(paste0("./../Data/Bid Tab RDS/Bid_Tab_", x, ".RDS"))
  
}) |> setNames(years) -> Bid_Tabs

# check for NAs in tables
sapply(Bid_Tabs, \(x){
  
  sapply(x, \(y){
    
    # check table for NAs
    (sapply(y$Table, \(col) any(is.na(col))) |> sum()) > 0
    
  })
  
}) -> NA_check

# NAs
sapply(NA_check, sum)

# look at NA cases
tmp1 <- Bid_Tabs[[1]][NA_check[["2015"]]]

# Nas caused by two line 
# remove the line 
lapply(tmp, \(x) x$Table <- x$Table[complete.cases(x$Table), ]) -> tmp2

# assign
Map(\(x, y){
  
  # assign
  x$Table <- y
    
  # return 
  x
  
}, tmp1, tmp2) -> cor

# asssign into orig list
Bid_Tabs[[1]][NA_check[["2015"]]] <- cor

# save
# saveRDS(Bid_Tabs, "./../Data/Bid Tab RDS/Bid_Tabs.RDS")



