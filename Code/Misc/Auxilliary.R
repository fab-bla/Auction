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




