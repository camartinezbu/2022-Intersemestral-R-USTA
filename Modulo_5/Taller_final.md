---
output:
  html_document: default
  pdf_document: default
---
# Taller Final

Los siguientes ejercicios corresponden al Taller Final del Curso de Análisis de Datos con R y su calificación equivale al 30% de la nota total. Estos compilan los materiales vistos en clase a lo largo de todos los módulos. 

El taller final debe ser resuelto en grupos de 3 y entregados en formato de script de R. El archivo de solucíon debe subirse a un repositorio de Github para su calificación, donde se indique claramente los integrantes del grupo.

Cada punto tiene una calificación de 0.5. Para la calificación sólo se tendrá en cuenta el commit más reciente antes del sabado 30 de julio a las 11:59 pm.

Además, se revisará la respuesta satisfactoria de **TODOS** los elementos descritos en los enunciados. Si el punto pide responder una pregunta, no basta con escribir las líneas de código correspondientes en R.

## Parte 1. Fundamentos de R

### Punto 1.1. Loop If

Usted está diseñando un programa que devuelva mensajes automatizados a un restaurante, de acuerdo con la calificación de sus clientes en una escala de 0 a 30. Para ello, se le pide implementar un loop de R que:

- Imprima en consola "¡Hay mucho por mejorar!" si la calificación está entre 0 y 10 (excluyendo el 10).
- Imprima en consola "¡Bien! Pero podría ser excelente." si la calificación está entre 10 y 20 (sin incluir el 20).
- Imprima en consola "¡Excelente Servicio! Sigue así." si la calificación está entre 20 y 30.

### Punto 1.2. Funciones

Posteriormente, le indican que hubo un cambio en el sistema de calificaciones, que permite desagregar la calificación del restaurante en 3 elementos: calidad de la comida, decoración y servicio, cada uno en escala de 0 a 30.

Sin embargo, es necesario que se mantenga un indicador de calificación conjunto. Para ello, implemente una función en R que reciba 3 argumentos -calidad, decoracion, servicio- y devuelva la suma de los 3.

Además, esta función debe incluir valores por defecto para las variables en caso de que el usuario no las incluya. Los valores por defecto deben ser:

- Calidad: 10
- Decoración: 5
- Servicio: 15

## Parte 2. Tidyverse

Luego de realizar las operaciones anteriores, se le entrega información sobre los precios y calificaciones de 168 restaurantes italianos en Manhattan, separada en dos archivos: `price_ratings.csv` y `restaurant_locations.csv`.

La primera tabla contiene un identificador único para los restaurantes (`Id`), una columna que incluye varias medidas asociadas al restaurante (`Variable`) y el valor específico de dichas medidas (`Value`).

La segunda tabla contiene un identificador único para los restaurantes (`Id_restaurant`), el nombre del Restaurante (`Restaurant`), y una variable que indica si el restaurante se ubica al este o al oeste de 5th Avenue (`East`).

### Punto 2.1. Cargar datos

Usando la función `read_csv()` cargue ambos archivos en su entorno de trabajo. Posteriormente imprima en consola la estructura de ambos dataframes y las primeras 8 filas.

¿Ambos dataframes cumplen con que cada fila es una observación y cada columna es una variable?

> Nota: Para imprimir la estructura no basta con escribir las funciones `colnames()` o `nrows()`.

### Punto 2.2. Pivot

Utilizando las funciones vistas en clase y que hacen parte del tidyverse, convierta el dataframe del archivo `price_ratings.csv` en formato wide. Es decir, que `Price`, `Food`, `Decor` y `Service` sean columnas individuales.

> Nota: Esto implica que el dataframe resultante debe tener 168 filas y 5 columnas.

### Punto 2.3. Joins

Usando las funciones vistas en clase, una las dos tablas con base en las columnas que identifican los restaurantes: `Id` y `Id_restaurant`.

> Nota: Utilice la función `inner_join()` para resolver el punto.

### Punto 2.4. Select y arrange

Con base en el dataframe completo que resulta del punto anterior, escriba la secuencia de comandos que devuelve un dataframe que contenga las columnas de nombre, precio y servicio, ordenados según la variable precio. 

¿Cuál es el restaurante más caro? ¿Cuál es el más barato?

### Punto 2.5. Group_by y Summarise

Usando el dataframe completo, construya un dataframe que agrupe los restaurantes de acuerdo con la variable `East` y calcule el precio promedio de la comida.

¿La comida es más cara en el lado Este o el lado Oeste de Manhattan?

## Parte 3. Análisis estadístico

### Punto 3.1. Regresión lineal

Usando la función `lm()` de R, construya una regresión lineal de la variable `Price` contra `Food`, `Decor`, `Service` y `East` y guarde el resultado en un objeto llamado `regresion`.

Posteriormente, ejecute el comando `summary(regresion)`.

¿Todas las variables son estadísticamente significaticas? ¿Qué variable parece influir más en el precio de la comida?

## Parte 4. Visualización de datos

### Punto 4.1. Gráfico de Densidad

Cree un gráfico con la estimación de la función de densidad para la variable `Service`, con el atributo `linetype` asociado a la variable `East`. Añada un título de su elección y cambie los nombres de los ejes y la leyenda para que aparezcan en español.

¿Cuál zona de Manhattan tiende a tener mejor calificación de servicio?

> Nota: Para hacer este gráfico, no olvide convertir la variable `East` a factor.

### Punto 4.2. Gráfico de Dispersión

Cree un gráfico de dispersión entre las variables `Price` y `Decor`, donde el color de los puntos esté asociado a la variable `East`. Modifique la escala de color de tal forma que:

- El color de `0` sea azul y de `1` sea verde.
- La etiqueta de `0` sea `Oeste` y de `1` sea `Este`.

Según el gráfico, ¿A qué zona de Manhattan pertenece el restaurante con menor precio?

> Nota: Para hacer este gráfico, no olvide convertir la variable `East` a factor.
