# Unfortunately, tabulizer has issues to identify tables with little rows, since
# the rows in the table represent the amount of bidders we may not ignore this 
# as the missingness of the auctions will not be random but more likely for auctions 
# with a small number of bidders.
# This function combines exrtract_table() and extract areas whenever the extraction 
# does not work because of detection issues.

btab_tbl_ext <- \(file, page = 2, method = "stream", print = FALSE){
  
  # try to extract without area specification
  tab <- tabulizer::extract_tables(file, pages = page, 
                                   method = method) |> as.data.frame()
  
  # if table is empty continue via extract_areas
  if(length(tab) == 0){
    
    # extr area
    tab <- tabulizer::extract_areas(file, pages = page) |> as.data.frame()
    
  }
  
  # remove first two rows 
  tab <- tab[-c(1, 2), ] 
  
  # check if a column contains only empty strings
  col_ind <- sapply(tab, \(col) all(col == ""))
  
  # remove cols
  tab <- tab[, !col_ind]
  
  # assign correct col names 
  colnames(tab) <- c("Rank", "Vendor_ID", "Vendor_Name", "Total_Bid", 
                     "Percent_of_Low_Bid", "Percent_of_Estimate")
  
  ## convert classes ##

  # Total bid
  tab[, "Total_Bid"] <- stringr::str_remove_all(tab[, "Total_Bid"], "(\\$|,)") |> 
                        as.numeric()
  
  # % of low bid and estimate
  lapply(tab[, c("Percent_of_Low_Bid", "Percent_of_Estimate")], \(x){
    
    # remove %
    (stringr::str_remove_all(x, "%") |> as.numeric()) / 100
    
  }) -> tab[, c("Percent_of_Low_Bid", "Percent_of_Estimate")]
  
  # class of rank
  tab[, "Rank"] <- as.numeric(tab[, "Rank"])
  
  # fix multi-row names 
  tab <- tab[complete.cases(tab), ]
  
  # return
  if(print) print(tab)
  return(tab)
}



