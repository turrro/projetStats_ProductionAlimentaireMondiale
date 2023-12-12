---
title: "Production agricole mondiale code R uniquement"
author: "Ewen Lecoeur, Alice Sartre, Arthur Payen"
date: "2023-12-12"
---
  
## Source
# <https://www.kaggle.com/datasets/patelris/crop-yield-prediction-dataset>, Richi Patel, [*Crop Yield Prediction Dataset (2021)*]{.underline}


## Préparation des données et packages
rm(list=ls())
library(knitr)
library(ggplot2)
library(cowplot)
library(FactoMineR)
library(factoextra)
library(corrplot)
library(ppcor)
library(emmeans)
library(car)
library(plyr)


## read tables
agri = read.table("Yield.csv", sep= ' ', row.names=1)
head(agri)
sommaire = summary(agri)
kable(sommaire)
str(agri)

agripays = read.table("Yieldbycountry.csv", sep = ' ', row.names=1)
head(agripays)


# liens rendements agricoles autres facteurs
correlation = cor(agri[,c(3:dim(agri)[2])])
kable(correlation,digits=2)
corrplot(correlation)

# analyse 1
ggplot(agri[agri$Item=="Potatoes",], aes(x=temp, y=yield)) + theme_bw() 
+ geom_point(aes(y=yield,color=rain))

# analyse 2
ggplot(agri, aes(y=yield, x=Area)) + theme_bw() + geom_bar()

# comptage des cultures
table(agri$Item)

# rendement = f(pesticides, culture)
ggplot(agri, aes(y=yield, x=pest, color=Item)) + geom_point() + theme_bw()

On peut réaliser une Analyse en Composantes Principales pour voir s'il n'y a pas des liens entre les variables quantitatives :

# ACP
```{r ACP france 1}
# j'ai testé un truc mais c'est pas encore fonctionnel là...
agrifrance = agripays[agripays$Area == "France", ]
agrifrance2 = agrifrance[seq(1,6),]
agrifrance2
#res.pca = PCA(agrifrance, scale.unit = TRUE, graph = FALSE, ncp=7)
#fviz_eig(res.pca, addlabels=TRUE, ylim = c(0,50))
#agrifrance
```
