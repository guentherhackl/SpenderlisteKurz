#a function to check if the ascending and descending data sets are equal
#if they are equal it is ensured that there are neither double entries or
#missing entries
checkEqual <- function(){
  kleinspendenASC <- read.csv("csv/kleinspendenASC.csv")
  kleinspendenDSC <- read.csv("csv/kleinspendenDSC.csv")
  
  klein <- isTRUE(all.equal(kleinspendenASC,kleinspendenDSC))
  
  grossspendenASC <- read.csv("csv/grossspendenASC.csv")
  grossspendenDSC <- read.csv("csv/grossspendenDSC.csv")
  
  gross <- isTRUE(all.equal(grossspendenASC,grossspendenDSC))
  
  gross & klein
}