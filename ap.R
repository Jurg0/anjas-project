library(dplyr)
library(reshape2)
#library(ggplot2)

# Daten einlesen und umformen
a <- read.csv("dat.csv", header = TRUE, sep = ";") # Einlesen von meinem Beispieldatensatz, muss ggf. noch auf Excel-Datei angepasst werden
b <- melt(a, id.vars="Experiment")

x <- rep(c(1,2,3,4), each = 96) %>% # Kreiert einen Vektor als Index für die Samples, je 96 Datenpunkte
  rep(times = 20) # Die Zahl muss angepasst werden an die Anzahl deiner Zeilen im Datensatz
b <- mutate(b, sample = x) # Fügt dem Datensatz den Sample Index hinzu

# Plotting funktioniert noch nicht so gut ^^'
# experiment1 <- subset(b, Experiment == 1) 
# ggplot(experiment1) +
#   geom_quasirandom(aes(x = variable, y = value)) +
#   #facet_wrap(~ variable) +
#   xlab("well") +
#   ylab("value")