# source AUX
source("./Misc/Auxilliary.R")
source("./Misc/btab_text.R")

# load
get.package(c("pdftools", "tabulizer", "stringr"))

### first the text based data that is not tabularized ##

# example file 
fn <- "./../Data/Bid Tab PDFs/2015/im-0705-079.pdf"

# pdf data 
pdf_dat <- pdftools::pdf_data(fn)
pdf_text <- pdftools::pdf_text(fn)
pdf_info <- pdftools::pdf_info(fn)

# text extraction test over 10 raondom files
sam <- paste0("./../Data/Bid Tab PDFs/2015/", list.files("./../Data/Bid Tab PDFs/2015")  |> sample(size = 10))
lapply(sam, btab_text_ext)

## tabularized data ##

# test
tabulizer::extract_tables(fn, pages = 1)
sessionInfo()



