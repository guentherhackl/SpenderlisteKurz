source("r-scripts/tableToDataFrame.R")

getData <- function(ASC = T) {
  
  #set which postfix is appended to filenames
  if(ASC) {
    post <- "ASC"
  } else {
    post <- "DSC"
  }
  
  #Grosspender
  
  page <- "https://www.sebastian-kurz.at/ausweispflichtige_spenden?page="
  
  writeLines("--------------------\nGroßspenden\n--------------------")
  
  grossspenden <- tableToDataFrame(page,ASC)
  
  write.csv(grossspenden, file = paste("csv/grossspenden",post,".csv", sep =""), row.names = F)
  
  
  #Kleinspender
  
  page <- "https://www.sebastian-kurz.at/spendenuebersicht?page="
  
  writeLines("--------------------\nKleinspenden\n--------------------")
  
  kleinspenden <- tableToDataFrame(page,ASC)
  
  write.csv(kleinspenden, file = paste("csv/kleinspenden",post,".csv", sep =""), row.names = F)
}
