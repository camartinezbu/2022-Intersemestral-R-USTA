# Ejercicios Módulo 4

Los siguientes ejercicios corresponden al Módulo 4 de Visualización de datos y su calificación equivale al 45% de la calificación de talleres.

Estos deben ser resueltos en grupos de 3 y entregados en formato de script de R. El archivo de solucíon debe subirse a un repositorio de Github para su calificación, donde se indique claramente los integrantes del grupo.

Cada punto tendrá un puntaje de 0.33. Para la calificación sólo se tendrá en cuenta el commit más reciente antes del miércoles 27 de julio a las 11:59 pm.

## Fuente de datos

Vamos a usar un dataset con el top 2000 de canciones de Spotify entre 2000 y 2019 que pueden descargar del siguiente [enlace](https://www.kaggle.com/datasets/paradisejoy/top-hits-spotify-from-20002019). Lea atentamente la descripción de las variables en el link indicado. 

Todos los ejercicios deben ser desarrollados usando únicamente las funciones de {ggplot2} salvo que se indique lo contrario. Antes de empezar, cargue el archivo en el entorno de trabajo de R usando la función `read_csv()`.

## Punto 1. Gráfico de Dispersión

Elabore un gráfico de dispersión con las variables `danceability` y `valence`, que tenga los puntos de color azúl y una transparencia de 0.3.

## Punto 2. Boxplot

Elabore un boxplot con la variable `mode` en el eje x y la variable `energy` en el eje y. Asigne el color de las cajas de acuerdo con la variable `mode` y elimine la leyenda.

> Pista: No olvide convertir la variable `mode` en un factor cuando la incluya en la función `aes()`.

## Punto 3. Composición con Patchwork

Usando el paquete {patchwork}, construya una salida gráfica con los 2 gráficos anteriores de tal modo que aparezcan uno al lado del otro.
