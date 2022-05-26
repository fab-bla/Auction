# source AUX
source("./Misc/Auxilliary.R")

# load
get.package(c("rvest"))

# Obtaining Links
links <- readLines("./Scraping/Archive_Links_Year.txt")

# over websites to scrape hrefs
lapply(links, \(x){
  
  # set page
  pg <- read_html(x)
  
  # extract href of node discovered via selector gadget
  pdf_href <- pg |> html_nodes("td a") |> html_attr("href")
  
  # remove "reject" links 
  pdf_href[grep("/reject", pdf_href, fixed = TRUE, invert = TRUE)]
  
}) |> setNames(2015:2021) -> pdf_links

# write link list into data folder
saveRDS(pdf_links, "./../Data/PDF_links.RDS")


