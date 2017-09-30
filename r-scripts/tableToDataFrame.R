library("XML")
source("r-scripts/getMaxPageCount.R")

#a function to read the the tables from the website to a data.frame
tableToDataFrame <- function(page, asc = T){
  
  maxCount <- getMaxPageCount(page)
  
  #creating vector for going through the pages either ascending or descending
  if(asc) {
    vec <- 1:maxCount
  } else {
    vec <- maxCount:1
  }
  
  spenden <- character()
  datum <- character()
  
  #counter for how many pages have been downloaded
  pageCount <- 1
  
  #loading html from each page and reading the table into a data.frame
  #and combinig all the data.frames in dat
  #The combinig process depends on the asc option. It is ensured that both ascending
  #and descending produce the exact same data.frames, if the raw data doesn't change
  for(count in vec) {
    curpage <- url(paste(page, count, sep =""))
    curhtml <- readLines(curpage)
    close(curpage)
    temp <- readHTMLTable(curhtml, header=F, which=1,stringsAsFactors=F)
    if(asc) {
      spenden <- c(spenden, temp$V2)
      datum <- c(datum, temp$V3)
    } else {
      spenden <- c(temp$V2, spenden)
      datum <- c(temp$V3, datum)
    }
    writeLines(paste("Page",pageCount,"of",maxCount,"finished", sep = " "))
    pageCount <- pageCount + 1
  }
  
  #preparing the final data.frame, with types correctly casted (getting rid of Euro-sign etc.)
  tempList <- strsplit(spenden, " ")
  tempList <- lapply(tempList, function(x) x[-1])
  spende <- as.numeric(sub(".", "", unlist(tempList), fixed = TRUE))
  datum <- as.Date(datum, format = "%d.%m.%Y")
  
  dat.final <- data.frame(spende, datum)
}