library(dplyr)


netflix_data <- read.csv("netflix1.csv", header = TRUE, sep = ",")
head(netflix_data)
summary(netflix_data)

# Identificando missing values - metodo 1
apply(netflix_data, 2, anyNA)
colnames(netflix_data)[apply(netflix_data, 2, anyNA)]# Nao foi encontrado missing values

# Identificando missing values - metodo 2
is.na(netflix_data)
colSums(is.na(netflix_data))
which(colSums(is.na(netflix_data)) >0)
names(which(colSums(is.na(netflix_data))>0)) # codigo longo, método 1 é preferivel

# Removendo potenciais linhas duplicadas
netflix_data <- distinct(netflix_data)

# Removendo colunas desnecessarias: 'show_id', 'date_added', 'listed_in' e
# trocando o nome da coluna 'release_year' p/ 'year'
new_netflix_data <- netflix_data %>%
                    rename(year = release_year) %>%
                    select(-1, -6, -10)


# Agrupando por ano de lancamento e tipo de programa e 
# Numero de lancamento por pais em cada ano
media_per_country <- new_netflix_data %>%
                    group_by(type, country) %>%
                   count(year)

# Encontrando quais paises possuem producoes no catalogo
countries <- new_netflix_data %>%
            group_by(country) %>%
            count(country) %>%
            arrange(desc(n))
countries
# Foram encontrados 86 paises no catalogo
# EUA, India e Uk possuem os maiores titulos representados no catalogo

# Uma observacao importante, foi encontrado que os 'missing values' foram embutidos como 'Not Given', nomenclatura incomum
new_netflix_data[new_netflix_data == "Not Given"] <- NA
apply(new_netflix_data, 2, anyNA)
# Foi visto entao que as colunas 'director', 'country' possuem NA

colSums(is.na(new_netflix_data))
# Na = 2588 para 'director' e NA=287 para 'country
# Remover NAs da coluna 'director' prejudicara a analise
clean_netflix <- new_netflix_data[complete.cases(new_netflix_data$country), ]

# Analise grafica dos dados
library(ggplot2)

# Quantidade de producoes na Netflix por classificao etaria

clean_netflix %>%
  count(rating) %>%
  slice_max(order_by = n, n = 10) %>%
  ggplot() +
  geom_col(aes(x= rating, y = n), color = "red", fill = "red") +
  labs(title = "Films and series per rating", x = "rating", y = "number of observations") +
  geom_label(aes(rating, n, label=n), position = position_dodge(width = 1)) +
  theme_bw()


# Producao por ano entre filme e serie

clean_netflix %>%
group_by(year) %>%
  count(type) %>%
  slice_max(order_by = n, n = 10) %>%
  ggplot() +
  geom_col(mapping = aes(x=year, y = n, color = type, fill= type)) +
  labs(title = "Films and series per year", x = "year", y = "number of observations") +
  theme_light()






                  




