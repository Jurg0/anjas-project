library(dplyr)
library(reshape2)

a <- read.csv("dat.csv", header = TRUE, sep = ";")
b <- melt(a, id.vars="Experiment")