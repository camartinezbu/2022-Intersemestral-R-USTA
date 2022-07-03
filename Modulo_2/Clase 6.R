# Clase 6 - 29 de junio de 2022
# Módulo 2: Tidyverse

# Hablemos de Characters y Factores
library(tidyverse)
library(readxl) # install.packages("readxl")

# Cuáles son las posibilidades para crear characters

a <- "Hola Mundo"
b <- 'Hola Mundo'

c <- "Y entonces Juan dijo: 'Hola'"

d <- "Y entonces Juan dijo: \"Hola\"" 

# Paste: paste(), paste0()
## paste: Me permite unir varios strings en uno solo y me permite definir el separado

paste("Hola", "Mundo", "!", sep = "A")

## paste0: paste(..., sep = "")

paste0("Hola ", "Mundo", "!")

# nchar: Número de caracteres que tiene un string

nombre <- "Sebastian"

if (nchar(nombre) > 6) {
  print("El nombre es muy largo")
} else {
  print("El nombre es corto")
}

# Cambiar de mayúsculas a minúsculas: tolower, toupper

nombre <- "Sebastian"

tolower(nombre)

toupper(nombre)

# Extraer elementos del string: substring

substring("Universidad", 1, 3)

"2022-12-06-reportefinal"

## Stringr: el paquete del tidyverse

## Cargar la base de datos generada en Mockaroo

datos <- read_excel("Modulo_2/Datos/Mockaroo/MOCK_DATA.xlsx")

## Detectar la presencia de un patrón en un string ----

str_detect(datos$nombre_completo, "Grayce")

# Detectar si el nombre contiene la palabra Ryun
datos_prueba <- datos %>%
  mutate(hay_ryun = str_detect(nombre_completo, "Ryun"))

# Detectar si la dirección contiene la palabra Lane
datos %>%
  filter(str_detect(residencia, "Lane"))

# Crear una columna de logical que indica si el nombre empieza con A
datos_prueba <- datos %>%
  mutate(empieza_con_a = str_starts(nombre_completo, "A"))

# Crear una columna que cuenta el número de 'a' dentro del string
# OJO: Esto no incluye la 'A'
datos_prueba <- datos %>%
  mutate(numero_a = str_count(nombre_completo, "a"))

# Modificar strings ----

# str_replace
# Cambiar todas las veces que aparece Way por Via
datos_prueba <- datos %>%
  mutate(residencia = str_replace(residencia, "Way", "Via"))

# Cambiar todos los elementos 'A' a minuscula
# OJO: Solo para el primer match
datos_prueba <- datos %>%
  mutate(nombre_nuevo = str_replace(nombre_completo, "A", "a"))

# Este lo hace para todas las ocurrencias
datos_prueba <- datos %>%
  mutate(nombre_nuevo = str_replace_all(nombre_completo, "A", "a"))

# Cambiar de mayúsculas, minúsculas, etc...
# Mínúsculas: str_to_lower()
# Mayúsculas: str_to_upper()
# Título: str_to_title()
# Sentence case: str_to_sentence()

datos_prueba <- datos %>%
  select(oracion) %>%
  mutate(lower = str_to_lower(oracion),
         upper = str_to_upper(oracion),
         title = str_to_title(oracion),
         sentence = str_to_sentence(oracion))

## Extraer partes de un string: Subset

## Extraer un n número de caracteres: str_sub()
## Extraer los primeros 3 caracteres del hex
datos_prueba <- datos %>%
  mutate(mi_busqueda = str_sub(hex, 1, 3))

## Extraer los últimos 3 caracteres del correo
datos_prueba <- datos %>%
  mutate(mi_busqueda = str_sub(email, -3))

## De acuerdo con un patrón específico.
# OJO: Me extraer únicamente los elementos que cumplen con el patrón
# Me puede generar error en mutate.
str_subset(datos$email, ".com")

## str_match: Si me lo devuelve para cada fila
datos_prueba <- datos %>%
  mutate(mi_busqueda = str_match(email, ".com"))

## Trabajar con la longitud de los strings
divipola_medellin <- "050001"

# Ver la longitud: str_length()
str_length(divipola_medellin)

# Pad: Añadir o eliminar strings al inicio o final del elemento
str_pad(divipola_medellin, 8, pad = "-", side = "both")

# Trim: Voy a quitar espacios en blanco.
mi_string <- "  Nombre: Camilo       "

str_trim(mi_string, side = "both")

## Expresiones regulares
## Sigamos los ejercicios de la página https://regexone.com

mi_vector <- c("abcdefg", "abcdef", "abc")

str_detect(mi_vector, "abc")

# Wildcards: Son unos caracteres especiales que me van a permitir acceder a un
# número indetermidado de caracteres
# ? cero o uno
# * cero o más
# + 1 o más
# . cualquier cosa

mi_vector <- c("Camilo", 
               "camiloooo",
               "Camil",
               "122213",
               "    sdja32542351", 
               "andres@gmail.com.co",
               "")

str_detect(mi_vector, ".")

# Si el string empieza o termina con un caracter especial
# Si ese elemento contiene al menos una a
str_detect(mi_vector, "a")

# Para saber si un string empieza con un caracter: ^
str_detect(mi_vector, "^a")

# Para saber si el string termina con unos caracteres: $
str_detect(mi_vector, "co$")

# Hablemos del operador o: []
str_detect(mi_vector, "^[c1]")

str_detect(mi_vector, "[13]$")

mi_vector <- c("can", "man", "fan", "dan", "ran", "pan")

str_detect(mi_vector, "[drp]an")

# Si yo quiero seleccionar:
# Letras en mayúscula: [A-Z]
# Letras en minúscula: [a-z]
# Cualquier letra : [A-Za-z], \\w
# Cualquier caracter de espacio: \\s
# Dígitos: [0-9], \\d
# Cualquier caracter que no sea letra: \\W
# Cualquier caracter que no sea digito: \\D
# Cualquier caracter que no sea espacio: \\S

# Si quiero separar los numeros de las direcciones
datos_prueba <- datos %>%
  mutate(str_split(residencia, " "))

datos_prueba <- datos %>%
  separate(residencia, " ", into = c("1", "2", "3", "4"))

datos_prueba <- datos %>%
  mutate(numero = str_extract(residencia, "^\\d*"))

# Extraer las palabras
datos_prueba <- datos %>%
  mutate(calles = str_extract_all(residencia, "[A-Za-z]+\\s?"))

datos_prueba <- datos %>%
  mutate(calles = str_extract(email, "(?<=@)([a-zA-Z]*)(?=\\.)"))


