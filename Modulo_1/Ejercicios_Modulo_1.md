# Ejercicios Módulo 1

Los siguientes ejercicios corresponden al Módulo 1 de rudimentos de R y su calificación equivale al 10% de la calificación de talleres.

Estos deben ser resueltos en grupos de 3 y entregados en formato de script de R. El archivo de solucíon debe subirse a un repositorio de Github para su calificación, donde se indique claramente los integrantes del grupo.

Cada punto tendrá un puntaje de 1. Para la calificación sólo se tendrá en cuenta el commit más reciente antes del viernes 1 de julio a las 12:00 m.

## Punto 1. Vectores y listas

Responda las siguientes preguntas:

a. ¿Cuál es la principal diferencia entre los vectores creados con la función `c()` y las listas creadas con la función `list()`?. <br>
b. Suponga que tiene una lista de n elementos llamada `mi_lista`. ¿Cuál es la diferencia entre ejecutar `mi_lista[0]` y `mi_lista[[0]]`?

## Punto 2. Extracción de elementos

Teniendo en cuenta la matriz descrita en el siguiente bloque de código, escriba los comandos para extraer:

a. La segunda columna únicamente.<br>
b. La tercera fila únicamente.<br>
c. De la fila 3 a la fila 7.<br>
d. Las columnas 2 a 4 de las filas 1 y 2.

```r
matriz <- matrix(rep(1:7, 4), ncol = 4, nrow = 7, byrow = TRUE)

# Solución:
## Literal a.

## Literal b.

## Literal c.

## Literal d.

```

## Punto 3. If

Usando un loop `if` y condicionales, escriba una serie de comandos que determinen si un número específico es par o impar.

```r
Estructura
numero <- 5

# Solución:
if (________) {
    ________
} else if () {
    ________
}
```

## Punto 4. For

Usando un vector con una serie de nombres, escriba el código correspondiente para un loop `for` que imprima en consola el mensaje `Bienvenido {nombre}` para cada nombre.

```r
nombres <- c("Andrea", "Carlos", "Juan", "Carolina", "Fernando", "Laura")

# Solución:
for (__________) {
    ____________
}
```

## Punto 5. Funciones

Escriba una función que reciba dos argumentos - el número a y el número b -, que devuelva el número a elevado al número b. Por ejemplo, si a = 2, y b = 3, la función devería devolver 8.

Además, si el usuario no define el número b, la función debería asignar un valor por defecto de 1 a esta variable.

```r
# Solución:
mi_funcion <- function(__________) {
    return(__________)
}

respuesta <- mi_funcion(__________)
```
