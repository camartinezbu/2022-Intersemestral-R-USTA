# Clase 3 - 23 de junio de 2022
# Módulo 2: Tidyverse

# install.packages("tidyverse")
library(tidyverse)

# Working directory: getwd, setwd
getwd()
setwd("../")

# Cargando una base de datos en formato csv: Kaggle ----
pokemon <- read_csv("Módulo 2 Tidyverse /Datos/Pokemon/pokedex_(Update_04.21).csv")

# Si quiero definir manualmente el tipo de columna
# pokemon <- read_csv("Módulo 2 Tidyverse /Datos/Pokemon/pokedex_(Update_04.21).csv",
#                     col_types = cols(pokedex_number = col_character(),
#                                      generation = col_character()))

# Más verbos de dplyr: count, arrange, group_by, summarise, top_n ----

# Vimos ayer varios verbos del tidyverse:
# select, slice, filter, mutate, rename, transmute

# Select
pokemon %>%
  select(-c(japanese_name, name, german_name))

# Slice
pokemon %>%
  slice(1:10)

pokemon %>%
  head(15)

pokemon %>%
  tail(20)

# Filter

pokemon %>%
  filter(generation == 2, type_1 == "Grass")

# Mutate

pokemon %>%
  mutate(nueva = height_m / weight_kg)

# Rename
pokemon %>%
  rename(nombre = name)

# Transmute
pokemon %>%
  transmute(nombre = name, nueva = height_m / weight_kg)

# Count: Me permite contar los elementos de una columna

# Quiero saber cuántos pokemon hay en cada generación y según status

prueba <- pokemon %>%
  count(generation, status)

# Arrange: Ordenar los datos según los valores de una columna

# Cuál es el pokemon que tiene el mayor peso

pokemon %>%
  arrange(desc(weight_kg)) %>%
  select(name, weight_kg)

# Cuál es el pokemon con mayor peso en cada generación
pokemon %>%
  arrange(desc(weight_kg)) %>%
  select(name, weight_kg) %>%
  head(1)

# Top_n
pokemon %>%
  select(name, weight_kg) %>%
  top_n(1, weight_kg)

# Para cada generación
# Para la generación 1

pokemon %>%
  filter(generation == 1) %>%
  arrange(desc(weight_kg)) %>%
  select(name, weight_kg) %>%
  head(1)

pokemon %>%
  filter(generation == 2) %>%
  arrange(desc(weight_kg)) %>%
  select(name, weight_kg) %>%
  head(1)

pokemon %>%
  filter(generation == 3) %>%
  arrange(desc(weight_kg)) %>%
  select(name, weight_kg) %>%
  head(1)

# ...

# Group_by

# Cuál es el pokemon con mayor peso en cada generación

prueba <- pokemon %>%
  group_by(generation) %>%
  top_n(1, weight_kg)

# Summarise

# Cuál es el peso promedio de los pokemones de todas las generaciones

prueba <- pokemon %>%
  group_by(generation) %>%
  summarise(peso_promedio = mean(weight_kg)) %>%
  arrange(desc(peso_promedio))

# Ver los pokemon con NA en la columna weight
peso_na <- pokemon %>%
  filter(is.na(weight_kg))

# Argumento na.rm
prueba <- pokemon %>%
  group_by(generation) %>%
  summarise(peso_promedio = mean(weight_kg, na.rm = TRUE)) %>%
  arrange(desc(peso_promedio))

# Cambiar la forma de un dataframe: pivot_longer, pivot_wider ----

prueba <- pokemon %>%
  count(generation) %>%
  rename(generacion = generation, numero = n)

# Pivot Wider

prueba_wider <- prueba %>%
  pivot_wider(names_from = generacion, values_from = numero)

# Pivot Longer

prueba_longer <- prueba_wider %>%
  pivot_longer(c(`1`:`8`), names_to = "generacion", values_to = "valores") %>%
  mutate(generacion = as.numeric(generacion))

# Un ejemplo más complicado

cuenta <- pokemon %>%
  count(generation, status)

cuenta_longer <- cuenta %>%
  pivot_wider(names_from = status, values_from = n)

# Fundamentos de ggplot ----

library(ggplot2)

# Aesthetics: La fuente de los datos
# Geometrias: Cómo lo voy a pintar
# Coordenadas: Cómo van a estar los ejes del gráfico
# Stats, themes...


