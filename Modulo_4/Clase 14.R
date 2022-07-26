# Clase 14 - 25 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

library(tidyverse)
library(ggplot2)

## Escalas de posición.

### Escalas de positión date-time

data <- economics

ggplot(data, aes(x = date, y = psavert)) +
  geom_line() +
  labs(
    x = NULL,
    y = NULL
  ) +
  scale_x_date(
    date_breaks = "10 years",
    date_labels = "%Y:%m_%a"
  )

## Atajos para darle formato a la etiqueta de los datetimes
# %S: Segundos
# %M: Minutos
# %l: Hora en formato 12 horas
# %H: Hora en formato 24 horas
# %a: Día de la semana abreviado
# %A: Días de la semana completo
# %e: Día del mes
# %m: Mes del año (numérico)
# %b: Mes del año (abreviado)
# %B: Mes del año (nombre completo)
# %y: Año (sólo últimos dos dígitos)
# %Y: Año completo

### Escalas de posición binned

ggplot(mpg, aes(hwy)) +
  geom_bar() +
  scale_x_binned()

ggplot(mpg, aes(displ, hwy)) +
  geom_count() +
  scale_x_binned()

ggplot(mpg, aes(displ, hwy)) +
  geom_count() +
  scale_x_binned(n.breaks = 2)

## Escalas de color continuas

grafico_base <- ggplot(faithfuld, aes(x = waiting, y = eruptions, fill = density)) +
  geom_raster(show.legend = FALSE) +
  scale_x_continuous(NULL, expand = c(0,0)) +
  scale_y_continuous(NULL, expand = c(0,0))

# Viridis
grafico_base +
  scale_fill_viridis_c()

grafico_base +
  scale_fill_viridis_c(option = "magma")

# Distiller
grafico_base +
  scale_fill_distiller()

grafico_base +
  scale_fill_distiller(palette = "YlOrBr")

# Scico
install.packages("scico")
library(scico)

grafico_base +
  scale_fill_scico(palette = "lajolla")

## Escalas de color discretas

df <- data.frame(
  x = c("a", "b", "c", "d"),
  y = c(3, 1, 5, 2)
)

mi_grafico_discreto <- ggplot(df, aes(x, y, fill = x)) +
  geom_bar(stat = "identity") +
  labs(
    x = NULL,
    y = NULL
  )

mi_grafico_discreto +
  scale_fill_brewer(palette = "Set3")

mi_grafico_discreto +
  scale_fill_viridis_d(option = "magma")

mi_grafico_discreto +
  scale_fill_grey()

## Escala discreta manual

mi_grafico_discreto +
  scale_fill_manual(
    values = c("green", "darkgreen", "yellow", "red")
  )

mi_grafico_discreto +
  labs(
    title =  "Mi gráfico",
    caption = "Intersemestral USTA",
    fill = "Mi paleta"
  ) +
  scale_fill_manual(
    breaks = c("a", "b", "c", "d"),
    labels = c(
      "grupo1",
      "grupo2",
      "grupo3",
      "grupo4"
    ),
    values = c(
      "a" = "#C33149",
      "b" = "#A8C256",
      "c" = "#f3d9b1",
      "d" = "#C29979"
    )
  )

ggplot(mpg, aes(displ, cty, color = as.factor(cyl))) +
  geom_point() +
  scale_color_manual(
    labels = c("cuatro", "cinco", "seis", "ocho"),
    values = c("#0a2463", "#fb3640", "#605f5e", "#247ba0")
  )

## Escalas con alpha

grafico_alpha <- ggplot(faithfuld, aes(waiting, eruptions, alpha = density)) +
  geom_raster(fill = "maroon") +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  scale_alpha_continuous(range = c(0, 1))

## Modificar la posición de la leyenda

grafico_alpha +
  theme(legend.position = "top")

grafico_alpha +
  theme(legend.position = "bottom")

grafico_alpha +
  theme(legend.position = "left")

grafico_alpha +
  theme(legend.position = "right")

grafico_alpha +
  theme(legend.position = "right",
        legend.direction = "horizontal")

grafico_alpha +
  theme(legend.position = c(0.1, 0.75))

library(gapminder)

gapminder

## Ejercicio de la clase

## 1. Gráfico de barras con la mediana de gdp per capita en el eje y y 
## en el eje x el continente, con el color asignado a cada continente
# y donde definan manualmente el color de cada contiente.

## 2. El mismo gráfico de arriba con un título, un caption, un título
## personalizado para la leyenda de color y que la leyenda esté a la 
## izquierda.

