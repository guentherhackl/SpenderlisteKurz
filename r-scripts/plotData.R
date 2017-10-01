source("r-scripts/checkEqual.R")
library("ggplot2")
library("svglite")

#a function to create two pie charts and saving them to a svg file
plotData <- function(grossspenden, kleinspenden) {
  #preparing plot data
  spenden <- c(sum(grossspenden$spende), sum(kleinspenden$spende))
  spendenRel <- spenden/(sum(spenden))
  
  anzahlSpenden <- c(NROW(grossspenden$spende), NROW(kleinspenden$spende))
  anzahlSpendenRel <- anzahlSpenden/(sum(anzahlSpenden))
  
  tp <- factor(c("Großspenden", "Kleinspenden", "Großspenden", "Kleinspenden"))
  cat<- factor(c("Spendengelder", "Spendengelder", "Anzahl Spenden", "Anzahl Spenden"))
  plotData <- data.frame(Summary = c(spendenRel, anzahlSpendenRel), type = tp, category = cat)
  
  #styling ggplot
  plotAesthetics <- aes(x=factor(""), y=Summary, fill = factor(type))
  p <- ggplot(data=plotData, plotAesthetics) 
  p <- p + geom_bar(width = 1, stat = "identity") + 
        facet_grid(facets = . ~ category) +
        coord_polar(theta="y") + 
        xlab('') + ylab('') + 
        labs(fill='Spendertyp') + 
        scale_fill_manual(values=c("#62c2d0","#9af0fd")) + 
        theme(axis.ticks=element_blank(), axis.text.x=element_blank(), axis.text.y=element_blank()) + 
        theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
        theme(panel.background = element_rect(fill = "white")) +
        theme(strip.text.x = element_text(size = rel(1.8)))
  
  #saving ggplot as svg
  ggsave(plot = p, file="output/plot.svg", width=20, height=10, units = "cm")
}