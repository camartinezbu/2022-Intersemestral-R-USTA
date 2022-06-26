# Clase 1 - 21 de junio de 2022
# Módulo 1: Rudimentos de R

# Vectores atómicos: El tipo de datos básico en R ----

## Logical: Verdaderos y Falsos ----

mi_logical <- TRUE

### Se escriben con las palabras...
TRUE # Si se utiliza en operaciones aritméticas es igual a 1.
FALSE # Es igual a 0

### O también con las iniciales
T
F

TRUE + TRUE + TRUE

### Operadores:

#### Se puede "invertir" el logical usando el operador de negación: !
!mi_logical

#### Operador de Y

TRUE & FALSE

#### Operador de O

TRUE | FALSE

## Integer: Números enteros ----
mi_integer <- 13L

## Double: Números decimales ----
mi_double <- 13
14.5
76.89

### Doubles especiales
-Inf
Inf
NaN

### Operaciones con numéricos

#### Operaciones tradicionales: + - * /
45/20

#### Operación floor division: %/%
#### Devuelve el cociente de una división (parte entera)
45 %/% 20

#### Operación módulo: %%
#### Devuelve el residuo de una división
45 %% 20

#### Operación de exponenciación: ^
2 ^ 4

## Character: Texto ----
mi_texto <- "Hola Mundo!"

## Missing values: NA ----
### Un tipo de valor especial para mostrar los valores faltantes
### Tienen interacciones especiales con los operadores y otros tipos de datos
NA

### Devuelven NA...
NA > 5
10 * NA
!NA

### No devuelven NA...
NA ^ 0
NA | TRUE
NA & FALSE

# Concatenando o combinando vectores: c() ----

mi_vector <- c(1, 5, 7, 9, 20)

mi_vector_nuevo <- c(TRUE, 4, 8, "hola")

## Nota: Los índices en R comienzan en 1

## Extrayendo elementos de un vector: [] ----

### Con el índice de un elemento específico
mi_vector[2]

### Varios elementos a la vez
mi_vector[2:4]

## Extraer la longitud de un vector: length() ----
length(mi_vector_nuevo)

## Comparaciones para los elementos de un vector ----

mi_vector > 10

x <- c(NA, 5, NA, 10, 20)

### Para identificar si los elementos son NA
is.na(x)

## Extracción de elementos basada en reglas ----

mi_vector <- c(1:20)

### Se define una condición (vecctor de logicals)
mi_regla <- mi_vector > 3

### Se incluye al interior del operador []
mi_seleccion <- mi_vector[mi_regla]

# Vectores de más dimensiones ----

## Dos dimensiones: Matrix ----

mi_matriz <- matrix(1:6, nrow = 3, ncol = 2)
mi_matriz_nueva <- matrix(1:6, nrow = 3, ncol = 2, byrow = TRUE)

## Tres o más: Array----

y <- array(1:12, c(2, 3, 2))

## dim
dim(mi_matriz)

dim(y)

# Listas ----

mi_lista <- list(TRUE, 4, 8, "hola")

l1 <- list(
  1:3,
  "a",
  c(TRUE, FALSE, TRUE),
  c(2.3, 5.9)
)

## Extracción de elementos de las listas: [[]] vs [] ----

### Si se hace con paréntesis cuadrados dobles, se extrae el elemento como tal
### Si se hace con paréntesis cuadrados simples, se extrae una lista con el 
### elemento seleccionado

objeto1 <- l1[1]

objeto2 <- l1[[1]]

#typeof
typeof(objeto1)
typeof(objeto2)

## str: Estructura de la lista
str(l1)

# Dataframe ----
## Creación: data.frame ----

df1 <- data.frame(
  x = 1:3,
  y = c("a", "b", "c")
)

str(df1)

df1[2, "x"]

colnames(df1) <- c("Primera", "Segunda")

df1[3, "Primera"]

# Factores: Son un tipo de vector atómico con valores predefinidos ----

mi_factor <- factor(c("a", "b", "c", "b", "a"))
typeof(mi_factor)

attributes(mi_factor)

# Factores ordenados
mi_factor_2 <- ordered(c("medio", "medio", "alto", "bajo"),
                       levels = c("bajo", "medio", "alto"))

attributes(mi_factor_2)


# Estructuras de control: if, for, while ----

## If ----
nota <- 2.5

#### Ejemplo 1
if (nota >= 4.0) {
  print("Felicitaciones, tuviste un desempeño excelente")
} else if (nota >= 3.0 & nota < 4.0){
  print("Bien, aprobaste la materia")
} else {
    print("Lo siento, tienes que repetir")
}

#### Ejemplo 2
nota <- 4.5

if (nota >= 3.0) {
  print("Bien, aprobaste la materia")
  if (nota >= 4.0) {
    print("Felcitaciones, tuviste un desempeño excelente")
  }
} else {
  print("Lo siento, tienes que repetir")
}


## For ----
nombres <- c("Camilo", "Andrea", "Juan", "María")
apellidos <- c("Rodríguez", "Martínez", "Rojas", "Perez")

### Ejemplo 1
for (nombre in nombres) {
  print(nombre)
  for (apellido in apellidos) {
    print(apellido)
  }
}

paste("Camilo", "Martínez")

### Ejemplo 2
for (nombre in nombres) {
  for (apellido in apellidos) {
    print(paste(nombre, apellido))
  }
}

### Ejemplo 3: break

for (nombre in nombres) {
  if (nombre == "Juan") {
    break
  } else {
    print(nombre)
  }
}

### Ejemplo 4: next

for (nombre in nombres) {
  if (nombre == "Juan") {
    next
  } else {
    print(nombre)
  }
}

## while ----

velocidad <- 0

while (velocidad <= 60) {
  print(paste("Voy a", velocidad, "km/h"))
  velocidad <- velocidad + 5
} 

accion <- "d"
velocidad <- 30

if (accion == "a") {
  # Acelerar
  while (velocidad <= 60) {
    print(paste("Acelero. Voy a", velocidad, "km/h"))
    velocidad <- velocidad + 5
  } 
} else if (accion == "d") {
  # Desacelerar
  while (velocidad >= 0) {
    print(paste("Desacelero Voy a", velocidad, "km/h"))
    velocidad <- velocidad - 5
  }
}

