# Ejercicios Módulo 2

Los siguientes ejercicios corresponden al Módulo 2 del Tidyverse y su calificación equivale al 20% de la calificación de talleres.

Estos deben ser resueltos en grupos de 3 y entregados en formato de script de R. El archivo de solucíon debe subirse a un repositorio de Github para su calificación, donde se indique claramente los integrantes del grupo.

Cada punto tendrá un puntaje de 1. Para la calificación sólo se tendrá en cuenta el commit más reciente antes del lunes 25 de julio a las 11:59 pm.

## Fuente de datos

Vamos a usar un dataset con los precios del internet en el mundo durante 2022, que pueden encontrar en este [link](https://www.kaggle.com/datasets/ramjasmaurya/1-gb-internet-price?select=all_csv+sorted.csv). Usaremos el arrchivo llamado `all_csv sorted.csv`.

## Punto 1. Cargar y explorar la base de datos

Cargue la base de datos a su entorno de trabajo, imprima en consola la estructura de la base de datos e imprima las primeras 10 filas, usando las funciones incluidas en el tidyverse.

## Punto 2. Datos faltantes

Usando las funciones del paquete naniar, cree un dataframe que muestre el número de datos faltantes para cada una de las columnas de la base de datos.

## Punto 3. Manipulación de datos pt. 1

Cree una nueva columna que contenga el cambio porcentual en el precio del internet entre 2020 y 2021 y ordene la base de datos según esa columna. ¿Cuáles son los 10 países en los que el precio incrementó más?

## Punto 4. Manipulación de datos pt. 2

Encuentre la velocidad promedio de internet en Megabits para cada una de las regiones incluidas en la variable `Continental region`. ¿Cuál es la región con el internet más lento?

## Punto 5. Gráfico en ggplot2

Usando el paquete ggplot2, elabore un gráfico de dispersión con las variables de velocidad promedio y porcentaje de usarios de internet. ¿Se podría afirmar que hay una correlación entre las dos variables?
