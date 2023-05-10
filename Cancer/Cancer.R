#setwd("C:/Users/Matheus/OneDrive/Área de Trabalho/FATEC - BD Negócios/Projetos/R/Cancer")

cancer <- read.csv("Cancer_Data.csv", header = TRUE, sep=",")
View(cancer)

attach(cancer)

plot(symmetry_se, area_se)
     