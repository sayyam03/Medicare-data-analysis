library(pdftools)
library(tidyverse)
text<- pdf_text("Hospital_Revised_Flatfiles.pdf") %>%
  readr::read_lines()
start<-grep("Outcome of Care Measures.csv", text)[2]
stop<- grep("20. Outpatient Imaging Efficiency Measures – National.csv", text)[2] - 1
varlist<- text[start:stop]

write.table(varlist,file = "Variable_list.txt")
rm(start, stop, text, varlist)
