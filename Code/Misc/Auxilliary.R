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


