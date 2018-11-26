library(dplyr)
library(reshape2)
library(ggplot2)

# Daten einlesen und umformen
# Einlesen von meinem Beispieldatensatz ist umständlich, eigentlich muss nur 1 Datei eingelesen werden
# Musst du noch auf Excel-Datei anpassen (das kann ich nicht testen)
aa <- read.csv("dat1.csv", header = TRUE, sep = ";")
ab <- read.csv("dat2.csv", header = TRUE, sep = ";")
ac <- inner_join(aa, ab, by = "Experiment")

b <- arrange(melt(ac, id.vars="Experiment"), Experiment) # Umformung sodass 1 Spalte alle Werte enthält

sample_index <- rep(c(1,2,3,4), each = 96) %>% # Kreiert einen Vektor als Index für 4 Samples, je 96 Datenpunkte
  rep(times = 20) # Die Zahl muss angepasst werden an die Anzahl der Zeilen in deinem Datensatz
b <- mutate(b, sample = sample_index) # Fügt dem Datensatz den Sample Index hinzu
b$sample <- factor(b$sample) # Kategorisches Datenformat macht sich besser beim Plot

kackvektor <- seq(1, 381, by = 4) + rep(0:3, each = 96) # Vorbereitung für Plotten der Samples 1-4 nebeneinander
#b <- mutate(b, plotting_order = kackvektor) # Die Reihenfolge in der geplottet wird dem Datensatz hinzufügen ist nicht unbedingt sinnvoll (nur für Verständniszwecke)

# Plotting
ggplot(filter(b, Experiment == 1)) + # Erstmal nur Experiment 1 (erste Zeile) plotten
  geom_quasirandom(aes(x = variable[y], y = value[kackvektor], color = sample), groupOnX = TRUE) +
  facet_wrap(~ Experiment) +
  xlab("well no.") +
  ylab("value")
