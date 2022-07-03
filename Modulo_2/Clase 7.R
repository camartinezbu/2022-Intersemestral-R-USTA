# Clase 7 - 30 de junio de 2022
# Módulo 2: Tidyverse

library(tidyverse)

# Factores, Assertions y Missing Value:

# Crear un factor: factor()

mi_vector <- c("a", "b", "c", "a", "a", "b")

mi_factor <- factor(mi_vector)

# Hablemos de los argumentos de factor:

## Levels: Definir manualmente los niveles del factor

mi_factor <- factor(mi_vector, levels = c("a", "b", "c"))

## Ordered: Definir si existe un ordenamiento de los elementos del vector

mi_factor_ordenado <- factor(
  c("alto", "medio", "medio", "alto", "bajo"),
  levels = c("bajo", "medio", "alto"),
  ordered = TRUE
)

levels(mi_factor)

levels(mi_factor_ordenado)

# Forcats: Paquete del tidyverse para factores ----
# Todas las funciones de forcats van a empezar por fct_

## Inspeccionar factores: Ver qué elementos tienen

fct_count(mi_factor_ordenado, sort = TRUE)

fct_match(mi_factor, "a")

## Diferencia entre levels() y fct_unique()
prueba <- levels(mi_factor)
prueba2 <- fct_unique(mi_factor)

## Cargar el dataset de Mockaroo

datos <- read_csv("Modulo_2/Datos/Mockaroo/MOCK_DATA_2.csv")

datos_limpio <- datos %>%
  mutate(marca = factor(marca),
         pais = factor(pais),
         cilindros = factor(cilindros)) %>%
  mutate(manual = as.logical(manual))

# Paréntesis: operaciones que puedo hacer con logicals
sum(datos_limpio$manual) / nrow(datos_limpio) * 100

# O definiendo explicitamente el tipo de las columnas
# 
# datos_listos <- read_csv("Modulo_2/Datos/Mockaroo/MOCK_DATA_2.csv",
#                          col_types = cols(marca = col_factor(),
#                                           pais = col_factor(),
#                                           cilindros = col_factor(),
#                                           manual = col_logical()))

fct_count(datos_limpio$marca)

fct_unique(datos_limpio$pais)

## Reordenar los niveles de un factor

## fct_relevel: de manera manual
datos_reducido <- datos_limpio %>%
  filter(cilindros %in% c("4", "6", "8", "10"))

datos_reducido <- datos_reducido %>%
  mutate(cilindros = fct_relevel(cilindros, c("10", "6", "4", "8"))) %>%
  mutate(cilindros = fct_drop(cilindros))

## fct_infreq: de acuerdo con la frecuencia en que aparecen

fct_count(datos_reducido$cilindros, sort = TRUE)

datos_reducido <- datos_reducido %>%
  mutate(cilindros_frecuencia = fct_infreq(cilindros))

## fct_inorder: de acuerdo con el orden en el que aparecen en el dataset
datos_reducido <- datos_reducido %>%
  mutate(cilindros_orden = fct_inorder(cilindros))

## fct_rev(): Reversar el orden de los factores
datos_reducido <- datos_reducido %>%
  mutate(cilindros_freq_rev = fct_rev(cilindros_frecuencia))

## fct_reorder(): Reordenar los niveles según otra variable
datos_reducido <- datos_reducido %>%
  mutate(cilindros_año = fct_reorder(cilindros, año, mean))

# Modificar los niveles de un factor ----

## fct_recode: Modificar los valores manualmente
datos_reducido <- datos_reducido %>%
  mutate(cilindros_letras = fct_recode(cilindros,
                                       diez = "10",
                                       cuatro = "4",
                                       seis = "6",
                                       ocho = "8"))

## fct_anon: Anonimizar los factores con integers aleatórios
datos_reducido <- datos_reducido %>%
  mutate(cilindros_anon = fct_anon(cilindros_letras))

## fct_collapse: Colapsar niveles de factores en grupos predefinidos
datos_reducido <- datos_reducido %>%
  mutate(marca_collapse = fct_collapse(marca,
                                       grupo_1 = c("Chevrolet",
                                                   "Lincoln"),
                                       grupo_2 = c("Isuzu", "Lexus",
                                                   "Toyota")))

# fct_other: Colapso niveles en unos que quiero conservar y "other".
datos_reducido <- datos_reducido %>%
  mutate(pais_redux = fct_other(pais, keep = c("Colombia",
                                               "China",
                                               "United States")))

# Assertive
# install.packages("assertive")
library(assertive)

duplicar <- function(numero) {
  assert_is_a_number(numero)
  return(numero * 2)
}

duplicar("hola")

duplicar <- function(numero) {
  assert_is_a_number(numero)
  assert_any_are_even(numero, severity = "message")
  return(numero * 2)
}

duplicar(3)

## assertthat
library(assertthat)

numero <- 10

assert_that(numero %% 5 == 0, 
            msg = "Ojo! El número ingresado no es múltiplo de 5")

# Naniar: Missing values y un par de funciones adicionales ----
library(naniar)

base_na <- read_csv("Modulo_2/Datos/Mockaroo/MOCK_DATA_3.csv")

## En forma de tablas ----
### Número de celdas con valores vaciós
n_miss(base_na)

### Número de celdas con valores completos
n_complete(base_na)

### miss_var_summary: Resumen por variable
miss_var_summary(base_na)

### miss_case_summary: Resumen por casos
miss_case_summary(base_na)

### miss_var_table: Representación alternativa para variables
miss_var_table(base_na)

### miss_case_table: Representación alternativa para casos
miss_case_table(base_na)

## En forma de gráficos ----

# Visualización básica
vis_miss(base_na)

# Ordenando o agrupando los valores vacíos
vis_miss(base_na, cluster = TRUE)

# gráficas hechas con ggplot
# Para ver los NA en las columnas
gg_miss_var(base_na)

# Para ver los NA en los casos
gg_miss_case(base_na)

# Para ver si los NA se correlacionan con una variable
gg_miss_var(base_na, facet = gender)

## Hacer transformaciones relacionadas con NA
# replace_na: Cambiar NA por un valor específico

base_na <- base_na %>%
  mutate(email_nuevo = replace_na(email, "Error")) %>%
  mutate(nombre_nuevo = replace_na(last_name, "XXXXXXXXX"))

# na_if: Cambiar un valor específico por NA
base_na <- base_na %>%
  mutate(email_restaurado = na_if(email, "Error")) %>%
  mutate(nombre_restaurado = na_if(last_name, "XXXXXXXXX"))

# Filtrando con el tidyverse
base_na %>%
  filter(is.na(first_name), is.na(email), is.na(last_name))