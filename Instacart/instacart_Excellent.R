#Instacart 
library(readr)
#1
aisles <- read_csv("C:/Users/vivek/Downloads/Instacart/aisles.csv/aisles.csv")
#View(aisles)
#2
departments <- read_csv("C:/Users/vivek/Downloads/Instacart/departments.csv/departments.csv")

#3
order_products_prior <- read_csv("C:/Users/vivek/Downloads/Instacart/order_products__prior.csv/order_products__prior.csv")

# only 20000 rows
order_products_prior <- read.csv("C:/Users/vivek/Downloads/Instacart/order_products__prior.csv/order_products__prior.csv", nrows = 20000)

#View(head(order_products_prior[1:10,]))
#4
order_products_train <- read_csv("C:/Users/vivek/Downloads/Instacart/order_products__train.csv/order_products__train.csv")
#5 
orders <- read_csv("C:/Users/vivek/Downloads/Instacart/orders.csv/orders.csv")

#6
products <- read_csv("C:/Users/vivek/Downloads/Instacart/products.csv/products.csv")


#trying to reshape data for a simple market basket analysis :
library(reshape)
library(tidyr)
library(reshape2)
# picking up just the two order id and product id, 

data<-order_products_prior[, 1:2]
df<-data
# combining all products per order into a single row per order_id 
dfa = aggregate(df[2], df[-2], FUN = function(X) paste(unique(X), collapse=", "))


# Splitting csv values in product_id column into separate columns : 
library(splitstackshape)
dat<-cSplit(dfa, "product_id", ",")


# install arules package
library(arules)
library(arulesViz)
library(datasets)

