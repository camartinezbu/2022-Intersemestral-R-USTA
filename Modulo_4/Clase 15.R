# Clase 15 - 26 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

library(tidyverse)
library(ggplot2)

## Ya hablamos de escalas de posición y de color
## Hablemos de las escalas restantes

## Tamaño: scale_size, scale_size_area, scale_radius

ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) +
  geom_point() +
  scale_size()

ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) +
  geom_point() +
  scale_size(range = c(1, 3))

ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) +
  geom_point() +
  scale_size_area()


ggplot(mpg, aes(x = displ, y = hwy, size = cyl)) +
  geom_point() +
  scale_radius()

planetas <- data.frame(
  nombre = c("Mercurio", "Venus", "Tierra", "Marte", "Jupiter", "Saturno", "Urano", "Neptuno"),
  tipo = c("Interior", "Interior", "Interior", "Interior", "Exterior", "Exterior", "Exterior", "Exterior"),
  posicion = c(1:8),
  radio = c(2440, 6052, 6378, 3390, 71400, 60330, 25559, 24764)
)

grafico_planetas <- ggplot(planetas, aes(x = 0, 
                                         y = fct_reorder(nombre, posicion),
                                         size = radio)) +
  geom_point() +
  labs(
    x = NULL,
    y = NULL
  ) +
  scale_x_continuous(breaks = NULL)

grafico_planetas +
  scale_size_area()

grafico_planetas +
  scale_radius(limits = c(0, NA), range = c(0, 10))

## Escalas de tamaño binned: scale_size_binned

mi_grafico_1 <- ggplot(mpg, aes(x = displ, y = manufacturer, size = hwy)) +
  geom_point(color = "darkgreen", alpha = 0.15) +
  labs(
    title = "Desplazamiento por marca",
    x = "Desplazamiento",
    y = "Marca",
    size = "Millas en\nautopista\npor galón"
  ) +
  theme(
    plot.title.position = "plot"
  ) +
  scale_size_binned()

mi_grafico_1 +
  guides(
    size = guide_bins(axis = FALSE)
  )

mi_grafico_1 +
  guides(
    size = guide_bins(direction = "horizontal",
                      title.position = "top",
                      axis = FALSE)
  )

mi_grafico_1 +
  guides(
    size = guide_bins(
      axis.colour = "blue",
      axis.arrow = arrow(
        length = unit(.1, "inches"),
        ends = "first",
        type = "closed"
      )
    )
  )


## Forma: scale_shape, scale_shape_manual

mi_grafica_forma <- ggplot(mpg, aes(x = displ,
                                    y = hwy,
                                    shape = factor(cyl),
                                    color = factor(cyl))) +
  geom_point() +
  labs(
    title = "Desplazamiento vs Millas en autopista",
    y = "Millas en autopista",
    x = "Desplazamiento",
    shape = "Cilindros"
  ) +
  theme(
    plot.title.position = "plot",
    legend.position = "top",
    legend.direction = "horizontal"
  ) 

## Comportamiento por defecto
mi_grafica_forma +
  scale_shape(solid = TRUE)


## Comportamiento de formas no sólidas
mi_grafica_forma + 
  scale_shape(solid = FALSE)

## Escala manual
mi_grafica_forma +
  scale_shape_manual(
    labels = c("Cuatro", "Cinco", "Seis", "Ocho"),
    values = c("triangle open", "diamond plus", "asterisk", "circle filled")
  ) +
  guides(
    color = guide_none()
  )


## Tipos de lineas
huron <- data.frame(
  year = 1875:1972,
  level = as.numeric(LakeHuron)
)

ggplot(huron, aes(year)) +
  geom_line(aes(y = level + 5), colour = "red", linetype = "dotted") +
  geom_line(aes(y = level - 5), colour = "blue", linetype = "longdash")

ggplot(economics_long, aes(x = date, y = value01, linetype = variable)) +
  geom_line() +
  scale_linetype_manual(
    values = c("dotdash", "longdash", "solid", "twodash", "dotted"),
    labels = c("Consumo", "Población", "Ahorros", "Tiempo desempleo", "No. Desempleados")
  ) +
  labs(
    title = "Esto es un título",
    x = NULL,
    y = "Valor", 
    linetype = "Dato"
  )


## Temas

## Los temas tienen los siguientes componentes:
## a. Temas completos: Funciones predeterminadas que traen un tema específico:
## theme_bw(), theme_void(), theme_gray().
## b. La función theme(), que me va a permitir modificar granularmente los
## elementos de mi tema.
## c. Los elementos de tema, que indican cuáles son las cosas que yo quiero
## modificar en mi gráfico.
## d. Las funciones de elementos, que describen las propiedades visuales de
## los elementos.

grafico_base <- ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_jitter() +
  geom_abline(colour = 'grey50', size = 2) +
  scale_x_continuous(limits = c(0, 45), expand = c(0,0)) +
  scale_y_continuous(limits = c(0, 45), expand = c(0,0)) +
  labs(
    x = "Millas en ciudad por galón",
    y = "Millas en autopista por galón",
    color = "Cilindros",
    title = "Mi gráfico de ejemplo",
    caption = "Elaborado para la clase\nde Análisis de datos con R"
  ) +
  scale_color_brewer(type = "seq", palette = "Spectral")

# Por defecto
grafico_base +
  theme_grey()

grafico_base +
  theme_bw()

grafico_base +
  theme_linedraw()

grafico_base +
  theme_light()

grafico_base +
  theme_dark()

grafico_base +
  theme_minimal()

grafico_base +
  theme_classic()

grafico_base +
  theme_void()

## ggthemes
# install.packages("ggthemes")
library(ggthemes)

grafico_base +
  theme_stata()

grafico_base +
  theme_excel()

grafico_base +
  theme_solarized()

grafico_base +
  theme_fivethirtyeight()

## Ejercicio de la clase

## 1. Usando la base de datos iris, predeterminada en ggplot, crear un
## gráfico de dispersión con las variables Sepal.Length y Sepal.Width,
## donde la forma esté asociada a la función Species, y las formas sean:
## Un asterisco, un triángulo y un rombo.

## 2. Usando el mismo gráfico anterior, definir el tema para que se parezca
## a stata (Requiere instalar ggthemes), y luego, en otra función theme, 
## definir que la leyenda salga a la derecha en dirección vertical.







