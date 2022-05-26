# source AUX
source("./Misc/Auxilliary.R")
source("./Misc/btab_text.R")
source("./Misc/btab_tbl_ext.R")

# load
get.package(c("pdftools", "tabulizer", "stringr"))

## 2015 ##
paths_2015 <- paste0("./../Data/Bid Tab PDFs/2015/", 
                     list.files("./../Data/Bid Tab PDFs/2015"))

# over files 2015
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2015)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2015, 1:length(paths_2015)) -> int_2015

# names
nome <- sapply(int_2015, \(x) x$Text["Contract ID"]) 
names(int_2015) <- nome

# remove "C17136" (special auction format)
# int_2015["C17136"] <- NULL

# write to RDS
# saveRDS(int_2015, "./../Data/Bid Tab RDS/Bid_Tab_2015.RDS")

## 2016 ## 
paths_2016 <- paste0("./../Data/Bid Tab PDFs/2016/", 
                     list.files("./../Data/Bid Tab PDFs/2016"))
# over files 2016
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2016)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2016, 1:length(paths_2016)) -> int_2016

# names
nome <- sapply(int_2016, \(x) x$Text["Contract ID"]) 
names(int_2016) <- nome

# write to RDS
# saveRDS(int_2016, "./../Data/Bid Tab RDS/Bid_Tab_2016.RDS")

## 2017 ## 
paths_2017 <- paste0("./../Data/Bid Tab PDFs/2017/", 
                     list.files("./../Data/Bid Tab PDFs/2017"))
# over files 2017
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2017)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2017, 1:length(paths_2017)) -> int_2017

# names
nome <- sapply(int_2017, \(x) x$Text["Contract ID"]) 
names(int_2017) <- nome

# write to RDS
# saveRDS(int_2017, "./../Data/Bid Tab RDS/Bid_Tab_2017.RDS")

## 2018 ## 
paths_2018 <- paste0("./../Data/Bid Tab PDFs/2018/", 
                     list.files("./../Data/Bid Tab PDFs/2018"))
# over files 2018
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2018)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2018, 1:length(paths_2018)) -> int_2018

# names
nome <- sapply(int_2018, \(x) x$Text["Contract ID"]) 
names(int_2018) <- nome

# rm failed cases
ind_del <- sapply(int_2018, \(x) class(x$Table)) == "try-error"
int_2018[ind_del] <- NULL

# write to RDS
# saveRDS(int_2018, "./../Data/Bid Tab RDS/Bid_Tab_2018.RDS")

## 2019 ## 
paths_2019 <- paste0("./../Data/Bid Tab PDFs/2019/", 
                     list.files("./../Data/Bid Tab PDFs/2019"))
# over files 2019
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2019)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2019, 1:length(paths_2019)) -> int_2019

# names
nome <- sapply(int_2019, \(x) x$Text["Contract ID"]) 
names(int_2019) <- nome

# rm failed cases
ind_del <- sapply(int_2019, \(x) class(x$Table)) == "try-error"
int_2019[ind_del] <- NULL

# write to RDS
# saveRDS(int_2019, "./../Data/Bid Tab RDS/Bid_Tab_2019.RDS")

## 2020 ## 
paths_2020 <- paste0("./../Data/Bid Tab PDFs/2020/", 
                     list.files("./../Data/Bid Tab PDFs/2020"))
# over files 2020
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2020)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2020, 1:length(paths_2020)) -> int_2020

# names
nome <- sapply(int_2020, \(x) x$Text["Contract ID"]) 
names(int_2020) <- nome

# rm failed cases
ind_del <- sapply(int_2020, \(x) class(x$Table)) == "try-error"
int_2020[ind_del] <- NULL

# write to RDS
# saveRDS(int_2020, "./../Data/Bid Tab RDS/Bid_Tab_2020.RDS")

## 2021 ## 
paths_2021 <- paste0("./../Data/Bid Tab PDFs/2021/", 
                     list.files("./../Data/Bid Tab PDFs/2021"))
# over files 2020
Map(\(x, i){
  
  # text 
  text <- btab_text_ext(x, print = TRUE) |> try()
  
  # table
  tbl <- btab_tbl_ext(x, print = TRUE) |> try()
  
  # print counter
  print(paste0("Docuemnt: ", i, "/", length(paths_2021)))
  
  # return
  list("Text" = text,
       "Table" = tbl)
  
}, paths_2021, 1:length(paths_2021)) -> int_2021

# names
nome <- sapply(int_2021, \(x) x$Text["Contract ID"]) 
names(int_2021) <- nome

# rm failed cases
ind_del <- sapply(int_2021, \(x) class(x$Table)) == "try-error"
int_2021[ind_del] <- NULL

# write to RDS
# saveRDS(int_2021, "./../Data/Bid Tab RDS/Bid_Tab_2021.RDS")





