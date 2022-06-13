## Aux ##

# packages
get.package <- function(package){
  
  lapply(package, function(x){
    if(!require(x, character.only = T)){
      install.packages(x)
    }
    library(x, character.only = T)     
  })
  
}

# invis plot
invis.Map <- function(f, ...) invisible(Map(f, ...))
invis.lapply <- function(x, f) invisible(lapply(x, f))
invis.rapply <- function(object, f, classes = "ANY", deflt = NULL, 
                         how = c("unlist", "replace", "list"), ...){
                         invisible(rapply(object, f, classes = "ANY", deflt = NULL,
                         how = c("unlist", "replace", "list"), ...))}

## Handling Auction Data ##

# function for pulling variables across all desired years and auctions
pull_varT <- \(auctions, var, years = as.character(2015:2019)){
  
  # pull
  do.call(c, 
          
    # over years      
    lapply(auctions[years], \(x){

      # over auctions
      sapply(x, \(y) y[["Text"]][var])
    
  }))
  
}

# function for altering a specific variable across all desired years and auctions
alt_varT <- \(auctions, var, years = as.character(2015:2019), Fun){
  
  # over years
  for(i in seq_along(years)){
    
    # over contract ID
    for(j in seq_along(auctions[[i]])){

      # alter
      auctions[[i]][[j]][["Text"]][var] <- Fun(auctions[[i]][[j]][["Text"]][var])
      
      
    }
    
  }

  # return
  return(auctions)
  
}

## Data Transformations ##

# data transformation for winning bid prediction
d_transform <- \(auc){
  
  # winning bid
  auc[["Table"]][, "Win"] <- (auc[["Table"]][, "Rank"] == 1) 
  
  # remove unused vars
  auc[["Table"]][, c("Rank", "Percent_of_Low_Bid", "Percent_of_Estimate")] <- NULL
  
  # remove engineers estimate
  ind_eng <- auc[["Table"]][, "Vendor_ID"] == "-EST-"
  auc[["Table"]] <- auc[["Table"]][!ind_eng, ]
  
  # paste 
  cbind("Contract_ID" = auc[["Text"]]["Contract ID"] |> unname(), 
        "County" = auc[["Text"]]["Counties"]|> unname(),
        "Letting_Month" = lubridate::month(as.Date(auc[["Text"]]["Letting Date"]))|> unname(),
        "Letting_Year" = lubridate::year(as.Date(auc[["Text"]]["Letting Date"]))|> unname(),
        "Contract_Time" = auc[["Text"]]["Contract Time"]|> unname(),
        "N_Comp" = nrow(auc[["Table"]]) - 1,
        auc[["Table"]]) -> res
  
  # return
  return(res)
}

# data transformation for eng bid spread
# transform on a bid basis
d_transform_2 <- \(auc){
  
  # winning bid
  win_ind <- (auc[["Table"]][, "Rank"] == 1) 
  win <- auc[["Table"]][win_ind, "Total_Bid"]
  
  
  # engineers estimate
  eng_ind <- (auc[["Table"]][, "Rank"] == 0) 
  eng <- auc[["Table"]][eng_ind, "Total_Bid"]
  
  if(all(eng_ind == FALSE)){
    
    # return NA
    return(rep(NA, 9))
    
  } else {
    
    # diff between win and estimate
    diffest <- (win - eng) 
    
    # second place
    if(nrow(auc[["Table"]]) > 2){
      
      # second place
      sec_ind <- (auc[["Table"]][, "Rank"] == 2)
      sec <- auc[["Table"]][sec_ind, "Total_Bid"]
      
      # spread
      diff12 <- (sec - win) 
      
      # money left on table
      mlot <- diff12 / eng
      
    } else{ 
      
      # NA
      sec <- NA
      diff12 <- NA
      mlot <- NA
      
    }
    
    # bind
    c("Contract_ID" = auc[["Text"]]["Contract ID"] |> unname(), 
      "County" = auc[["Text"]]["Counties"]|> unname(),
      "Letting_Month" = lubridate::month(as.Date(auc[["Text"]]["Letting Date"]))|> unname(),
      "Letting_Year" = lubridate::year(as.Date(auc[["Text"]]["Letting Date"]))|> unname(),
      "Contract_Time" = auc[["Text"]]["Contract Time"]|> unname(),
      "N_Firm" = nrow(auc[["Table"]]) - 1,
      "Eng_Est" = eng,
      "Winning_Bid" = win,
      "EW_Diff" = diffest,
      "MLOT" = mlot) -> res
    
    # return
    return(res)
    
  }
  
}

## Plotting ##

# Normal plots
Dens_norm_plot <- \(data = dat_bids, y, bg_alt = FALSE){
  
  # init. plot
  ggplot(data, aes(.data[[y]])) +
    
    # hist
    geom_histogram(aes(y = ..density..), fill = "cornflowerblue", col = "deepskyblue4") +
    
    # fit normal
    stat_function(fun = dnorm, 
                  args = list(mean = mean(data[[y]], na.rm = TRUE), 
                              sd = sd(data[[y]], na.rm = TRUE)),
                  col = "darkblue", lwd = 1, lty = "dashed") +
    theme_bw() +
    
    # add colored grid optionally
    {if(bg_alt) theme(panel.background = element_rect(fill = "#90EE90",
                                                      size = 2, linetype = "solid"),
                      panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                                      colour = "white"), 
                      panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                                      colour = "white"))}
  
}



