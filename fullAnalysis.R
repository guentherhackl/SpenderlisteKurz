source("r-scripts/getData.R")
source("r-scripts/plotData.R")

#data is downloaded via two methods and later compared
#this ensures that no donations were made, while downloading,
#which could cause doble entries and missing entries
getData(T)
getData(F)

if(checkEqual()) {
  writeLines("Datasets equal")
  
  grossspenden <- read.csv("csv/grossspendenASC.csv")
  kleinspenden <- read.csv("csv/kleinspendenDSC.csv")
  
  plotData(grossspenden, kleinspenden)
  
  spenden <- c(sum(grossspenden$spende), sum(kleinspenden$spende))
  spendenRel <- round(spenden/(sum(spenden)), digits = 4)
  
  anzahlSpenden <- c(NROW(grossspenden$spende), NROW(kleinspenden$spende))
  anzahlSpendenRel <- round(anzahlSpenden/(sum(anzahlSpenden)), digits = 4)
  
  typ <- factor(c("grossspenden","kleinspenden"), levels = c("grossspenden","kleinspenden","gesamt"))
  
  dat <- data.frame(typ, spenden, spendenRel, anzahlSpenden, anzahlSpendenRel)
  
  dat <- rbind(dat, c("gesamt", sum(spenden), sum(spendenRel), sum(anzahlSpenden), sum(anzahlSpendenRel)))
  
  capture.output(dat, file = "output/numbers.txt")
  
  combine <- rbind(grossspenden, kleinspenden)
  
  q <- quantile(combine$spende, c(0, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.975, 0.99, 1))
  capture.output(q, file = "output/quantiles.txt")
  
} else {
  writeLines("Datasets not equal")
}