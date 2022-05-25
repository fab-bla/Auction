# source AUX
source("./Misc/Auxilliary.R")

# load
get.package(c("rvest", "pdftools"))

# read link list prev generated
pdf_links <- readRDS("./../Data/PDF_links.RDS")

# generate folders for PDFs
dir.create("./../Data/Bid Tab PDFs")

# generate subfolders
years <- 2015:2021
lapply(years, \(x) dir.create(paste0("./../Data/Bid Tab PDFs/", x)))

# download PDFs
Map(\(link, year){
  
  # over links in each year
  lapply(link, \(x){
  
    # convert link to filename 
    fnom <- sapply(strsplit(x, "/", fixed = TRUE), tail, 1)

    # some links already contain ".pdf" ending others don't 
    # add .pdf if it is not present to generate a valid filename

    if(!grepl(".pdf", fnom, fixed = TRUE)){
      
      # paste to name
      fnom <- paste0(fnom, ".pdf")
      
    }

    # download file 
    download.file(x, 
                  destfile = paste0(getwd(), "./../Data/Bid Tab PDFs/", year, "/", fnom), 
                  mode = "wb")
    
  })
  
}, pdf_links, years)








