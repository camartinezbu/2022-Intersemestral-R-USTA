# Clase 8 y 9 - 14 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

# Cargar el tidyverse y ggplot2
library(tidyverse)
library(ggplot2)

# Cargar la base de datos y la guardamos en un opbjeto llamado data
data <- mpg

# Explorar esa base de datos
glimpse(mpg)

# Pregunta: Cómo ha evolucionado el consumo de combustible en la autopista a
# lo largo del tiempo

data %>%
  group_by(year) %>%
  summarise(promedio = mean(hwy))


data %>%
  group_by(year) %>%
  summarise(promedio = mean(cty))


# Pregunta: Cómo es el consumo de combustible en la ciudad de acuerdo con el 
# número de cilindros para los automoviles producidos en 1999

data %>%
  filter(year == 1999) %>%
  group_by(cyl) %>%
  summarise(promedio_consumo = mean(cty))

# Pregunta: Haga una tabla que cuente la clase (filas) y la tracción del 
# vehículo (columnas)

data %>%
  count(class, drv) %>%
  pivot_wider(names_from =drv, values_from = n)

## Algunos gráficos con ggplot2

ggplot(data, aes(x = displ, y = hwy)) + 
  geom_point()

# Agreguemos color: variable class

ggplot(data, aes(x = displ, y = hwy, colour = class)) +
  geom_point()

# Agreguemos forma: variable drv

ggplot(data, aes(x = displ, y = hwy, shape = drv)) +
  geom_point()

# Agreguemos tamaño: variable cyl

ggplot(data, aes(x = displ, y = hwy, size = cyl)) +
  geom_point()

# Todos a la vez

ggplot(data, aes(x = displ,
                 y = hwy,
                 colour = class,
                 shape = drv,
                 size = cyl)) + 
  geom_point()

# Escalas dentro y fuera de la función aes()

ggplot(mpg, aes(x = displ, y = hwy, colour = "green")) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy), colour = "green") +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 3)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy, shape = drv))

# Facetas: la aplicación del principio de los pequeños múltiplos

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~cyl)

# Otras capas adicionales
# geom_bar() y geom_col(): gráficos de barras
# geom_line(): gráficos de líneas
# geom_histogram(): histograma
# geom_boxplot(): boxplot
# geom_smooth(): dibujar líneas de tendencia
# geom_area(): gráfico de área
# geom_polygon(): poligonos

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_jitter()

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot()

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_violin()

ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_jitter(color = "red", shape = "diamond")

ggplot(mpg, aes(x = cty)) +
  geom_histogram(bins = 30)

ggplot(mpg, aes(x = cty)) +
  geom_freqpoly(bins = 2)

ggplot(mpg, aes(x = cty, colour = drv)) +
  geom_freqpoly()

ggplot(mpg, aes(x = cty, fill = class)) +
  geom_histogram() +
  facet_wrap(~class)

ggplot(mpg, aes(x = cty, colour = class)) +
  geom_histogram() +
  facet_wrap(~class)

ggplot(mpg, aes(x = manufacturer)) +
  geom_bar()

## Cargando otra base de datos
data2 <- economics

ggplot(data2, aes(x = date, y = unemploy)) +
  geom_line()

ggplot(data2, aes(x = date, y = unemploy)) +
  geom_area()

## Añadiendo elementos adicionales al gráfico

mi_grafico <- ggplot(data2, aes(x = date, y = unemploy)) +
  geom_area(colour = "blue", fill = "lightblue") +
  labs(
    title = "Evolución del número de desempleados en Estados Unidos",
    subtitle = "Este es un subtítulo de prueba",
    caption = "Fuente: FED",
    x = "Año",
    y = "Desempleados (miles)",
    tag = "A."
  )

## Guardando el gráfico: ggsave()
ggsave("~/Desktop/Salida/grafico.png", 
       width = 800,
       height = 800,
       units = "px")

ggsave("~/Desktop/Salida/grafico.png",
       mi_grafico,
       width = 800,
       height = 800,
       units = "px")

## Ejercicio
str(iris)

## 1. Vamos a hacer un gráfico de dispersión que me muestre la 
## relación entre longitud y ancho de los petalos.

## 2. El gráfico 1 pero que mapee la especie al color
## de los puntos.

## 3. El gráfico 1 pero que genere facetas de acuerdo con
## la especie.




