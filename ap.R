library(dplyr)
library(reshape2)
#library(ggplot2)

# Daten einlesen und umformen
# Einlesen von meinem Beispieldatensatz ist umständlich, eigentlich muss nur 1 Datei eingelesen werden
# Musst du noch auf Excel-Datei anpassen (das kann ich nicht testen)
aa <- read.csv("dat1.csv", header = TRUE, sep = ";")
ab <- read.csv("dat2.csv", header = TRUE, sep = ";")
ac <- inner_join(aa, ab, by = "Experiment")

b <- arrange(melt(ac, id.vars="Experiment"), Experiment) # Umformung sodass 1 Spalte alle Werte enthält

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