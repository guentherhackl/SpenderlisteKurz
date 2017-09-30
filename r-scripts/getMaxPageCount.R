#a function to read the maximum pageCount from the website
getMaxPageCount <- function(page){
  
  #opening the first page, which contains the maximum pageCount in the pagination
  page.1.con <- url(paste(page, 1, sep =""))
  page.1 <- readLines(page.1.con)
  close(page.1.con)
  
  #extracting maximum pageCount and returning it
  pagination <- page.1[grepl(".*pagination__currentpage.*",page.1)]
  temp <- unlist(strsplit(pagination, " "))
  as.numeric(unlist(strsplit(temp[length(temp)], "<"))[1])
}