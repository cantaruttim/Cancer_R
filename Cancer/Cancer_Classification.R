#setwd("C:/Users/Matheus/OneDrive/Área de Trabalho/FATEC - BD Negócios/Projetos/R/Cancer")

#install.packages("partykit")
#install.packages("party")
#install.packages('caret')
library(partykit)
library(dplyr)
library(caret)
library(party)

cancer <- read.csv("Cancer_Data.csv", header = TRUE, sep=",")
str(cancer)
attach(cancer)

#Retirando a coluna id e X 
cancer <- cancer[ c(2:32) ]
# Convertendo diagnosis para numérico
cancer$diagnosis <- as.factor(cancer$diagnosis)
View(cancer)
str(cancer)

diagnosis
#B = Benigno
#M = Maligno

set.seed(1234)
ind <- sample(2, nrow(cancer), replace=TRUE, prob=c(0.8,0.2))

# TRAIN AND TEST DATA
train.data <- cancer[ind==1,]
test.data <- cancer[ind==2,]

str(train.data)
str(test.data)


dim(cancer)
dim(train.data) # [1] 400  31
dim(test.data) # [1] 169  31

myFormula <- diagnosis ~ .
#myFormula

cancer_ctree <- ctree(myFormula, scores = c("B", "M"), data=train.data)
print(cancer_ctree)
table(predict(cancer_ctree),train.data$diagnosis)

#    B   M
#B 248  11
#M   6 127

plot(cancer_ctree)

# PREVISÕES
pred = predict(cancer_ctree, test.data)
pred
str(pred)

# ACCURACY

accuracy = (285 + 152) /(285 + 152 + 7 + 12)
accuracy
# [1] 0.9583333