amazon_sale_dataset.R

library(dplyr)

amazon_sale <- read.csv("Amazon Sale Report.csv", header = TRUE, sep = ",")
head(amazon_sale)


# Summary
summary(amazon_sale)

# Price - min, mean, max
# Pelo summary, min=0; mean= 648.6; max=5584

# Me com o maior volume de vendas, exceto para status cancelado:

# criando coluna 'sales',  coluna 'month' e coluna 'week'
amazon_sale <- amazon_sale %>%
  mutate(sales = Qty * Amount,
         month = format(as.Date(Date, format="%m-%d-%Y"), "%m"),
         week = format(as.Date(Date, format="%m-%d-%Y"), "%V"))


# Removendo NAs
summary(amazon_sale$sales)
amazon_sale <- na.omit(amazon_sale)

# Descobrindo o montante das vendas por mes
amazon_sale %>%
  group_by(month) %>%
  summarise(total_sales = sum(sales))
# Logo, o melhor mes de vendas foi em abril. Para series temporais grande pode ser usado a ordem decrescente em vendas
amazon_sale %>%
  group_by(month) %>%
  summarise(total_sales = sum(sales)) %>%
  arrange(desc(total_sales))
# Em grafico
library(ggplot2)
amazon_sale %>%
  ggplot(aes(month, sales)) +
  geom_col() +
  labs (title= "Number of sales by month", x = "month", y= "sales")

# Descobrindo as categorias mais vendidas
amazon_sale %>%
  group_by(Category) %>%
  summarise(quantities = sum(Qty)) %>%
  arrange(desc(quantities))
# A categoria 'set' foi a mais vendida com 45.214 unidades

# Descobrindo os portos mais utilizados
amazon_sale %>%
  group_by(ship.city) %>%
  summarise(products = sum(Qty)) %>%
  arrange(desc(products))
# O porto de Bengaluru foi o mais movimentado

# Dia com mais pedido
amazon_sale %>%
  group_by(Date) %>%
  summarise(products = sum(Qty)) %>%
  arrange(desc(products))
# O dia com maior volume de pedidos foi 2 de maio de 2022

# Dia com maior montante vendido
amazon_sale %>%
  group_by(Date) %>%
  summarise(total_sales = sum(sales)) %>%
  arrange(desc(total_sales))
# O dia com o maior volume vendido foi 5 de maio de 2022

#  Qual foi a semana com o menor volume de vendas?
amazon_sale %>%
  group_by(week) %>%
  summarise(amount_sale = sum(sales)) %>%
  arrange(amount_sale)
# A semana 26 teve o menor volume arrecadado em vendas.
# Graficamente
amazon_sale %>%
  ggplot(aes(week, sales)) +
  geom_col() +
  labs (title= "Number of sales by week", x = "week", y= "sales")


# Grafico de vendas semanais por categoria de produto
amazon_sale %>%
  ggplot(aes(week, sales, color=amazon_sale$Category)) +
  geom_col() +
  labs (title= "Number of sales by week", x = "week", y= "sales")

# Grafico por categoria
amazon_sale %>%
  ggplot(aes(week, sales, color=amazon_sale$Category)) +
  geom_col() +
  labs (title= "Number of sales by week", x = "week", y= "sales") +
  facet_wrap(~Category, nrow = 3, ncol = 3)
# As categorias mais vendidas semanalmente sao 'set', 'kurta', 'top', 'western dress'.


