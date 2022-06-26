# Clase 2 - 22 de junio de 2022
# Módulo 1: Rudimentos de R

# Funciones en R ----

## Creación de funciones
saludar <- function() {
  print("¡Hola!")
}

saludar()

## Argumentos
duplicar <- function(numero) {
  numero*2
}

modificar <- function(numero) {
  x <- numero *2
  x <- x ^ 3
  x <- x / 10
  return(x)
}

mi_numero_modificado <- modificar(2)

## Valor por defecto

duplicar_v2 <- function(numero = 2) {
  return(numero * 2)
}

duplicar_v2(4)
duplicar_v2()

saludo_personalizado <- function(nombre = "Camilo") {
  print(paste("¡Hola", nombre, "!"))
}

saludo_personalizado("Laura")
saludo_personalizado()

# Familia de apply en R ----

# apply
m1 <- matrix(rep(1:10, 3), nrow = 5, ncol = 6)

apply(m1, 1, mean)

# lapply

apellidos <- c("Rodríguez", "Martínez", "Rojas", "Perez")

apellidos_mayuscula <- lapply(apellidos, toupper)

apellidos_mayuscula


# sapply

apellidos <- c("Rodríguez", "Martínez", "Rojas", "Perez")

apellidos_minuscula <- sapply(apellidos, tolower)

apellidos_minuscula


# Instalar y cargar paquetes ----

## install.packages()

install.packages("tidyverse")

## library()
library(tidyverse)

## Cargar nuestro primer dataframe: mtcars
data <- as_tibble(mtcars)

# Nombre de las columnas
colnames(data)

# Número de columnas
length(data)

# Número de observaciones
nrow(data)

data[1:10, "am"]

# Verbos de dplyr

# Select: Selecccionar las columnas
select(data, am) # Equivalente a data[, "am"]

select(data, hp, cyl, am, gear) # Equivalente a data[, c("hp", "cyl", "am", "gear")]

# Slice: Seleccionar las filas según el índice
slice(data, 19:30)

## Head: Me devuelve las primeras n filas
head(data, 15)

## Tail: Me devuelve las últimas n filas
tail(data, 5)

# Filter: Selecccionar las filas según un criterio
filter(data, am == 1, gear == 5, hp > 150)

# Rename: Renombrar las columnas de mi dataframe
rename(data, "cilindro" = cyl, "peso" = wt)

# Mutate: Crear nuevas columnas
mutate(data, "hp/wt" = hp/wt * 100, "mpg*carb" = mpg*carb/2)

# Transmute: select y mutate
transmute(data, cyl, "hp/wt" = hp/wt)


# Pipe: %>%
data %>%
  head(10) %>%
  select(am) %>%
  mutate(am = case_when(
    am == 0 ~ "Automatico",
    am == 1 ~ "Manual"
  ))
