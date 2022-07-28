# Clase 16 - 27 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

library(tidyverse)
library(ggplot2)

## Gráfico de ejemplo con iris
grafico_base <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point() +
  labs(
    title = "Longitud y Ancho del Pétalo",
    subtitle= "Este es un gráfico de ejemplo",
    x = "Longitud",
    y = "Ancho",
    color = "Especie",
    caption = "Elaborado en clase"
  ) +
  scale_x_continuous(
    limits = c(0, 8),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    limits = c(0, 3),
    expand = c(0, 0)
  ) +
  scale_color_manual(
    labels = c("Setosa", "Versicolor", "Virginica"),
    values = c("#102542", "#F87060", "#bf9aca")
  )

# Textos: títulos del gráfico, de los ejes, de las leyendas.
grafico_base +
  theme(
    plot.title = element_text(size = 20, # Tamaño de fuente
                              color = "blue", # Color de fuente
                              face = "bold", # Tipo de fuente
                              hjust = 0.5 # Justificación horizontal
                              )
  )

grafico_base +
  theme(
    plot.subtitle = element_text(size = 15,
                                 color = "red",
                                 face = "italic",
                                 hjust = 1),
    plot.caption = element_text(size = 8,
                                color = "grey50",
                                face = "bold.italic",
                                hjust = 0)
  )

grafico_base +
  theme(
    plot.title.position = "plot",
    plot.caption.position = "plot"
  )

grafico_base +
  theme(
    plot.title = element_text(size = 20, # Tamaño de fuente
                              color = "blue", # Color de fuente
                              face = "bold", # Tipo de fuente
                              hjust = 0.5 # Justificación horizontal
    ),
    plot.subtitle = element_text(size = 15,
                                 color = "red",
                                 face = "italic",
                                 hjust = 1),
    plot.caption = element_text(size = 8,
                                color = "grey50",
                                face = "bold.italic",
                                hjust = 0),
    plot.title.position = "plot",
    plot.caption.position = "plot"
  )

grafico_base +
  theme(
    axis.title = element_text(color = "darkgreen")
  )

grafico_base +
  theme(
    axis.title.x = element_text(color = "darkgreen"),
    axis.title.y = element_text(color = "darkred")
  )

grafico_base +
  theme(
    axis.text.x = element_text(size = 12, face = "bold"),
    axis.text.y = element_text(size = 5, face = "italic", color = "purple")
  )

grafico_base +
  theme(
    legend.title = element_text(size = 20, color = "pink"),
    legend.text = element_text(color = "blue", face = "italic", hjust = 0.5)
  )

## Rectángulos: Plot, panel, legend, bacgkround
grafico_base +
  theme(
    plot.background = element_rect(
      fill = "grey",
      color = "red",
      size = 3
    )
  )

grafico_base +
  theme(
    panel.background = element_rect(
      fill = "lightblue"
    )
  )

grafico_base +
  theme(
    legend.background = element_rect(color = "black",
                                     fill = "yellow"),
    legend.key = element_rect(color = "lightblue",
                              fill = "lightgreen")
  )

grafico_base +
  theme(
    legend.position = "top",
    legend.direction = "horizontal"
  )

grafico_base +
  theme(
    legend.background = element_rect(color = "black",
                                     fill = "yellow"),
    legend.key = element_rect(color = "lightblue",
                              fill = "lightgreen"),
    legend.position = "top",
    legend.direction = "horizontal"
  )

## Lineas: Ejes, panel
grafico_base +
  theme(
    panel.grid.major = element_line(color = "red",
                                    size = 2),
    panel.grid.minor = element_line(color = "blue",
                                    linetype = "dotted")
  )

grafico_base +
  theme(
    panel.grid.major.x = element_line(color = "red",
                                    size = 2),
    panel.grid.major.y = element_line(color = "green",
                                      size = 1),
    panel.grid.minor = element_line(color = "blue",
                                    linetype = "dotted")
  )


grafico_base +
  theme(
    axis.ticks = element_line(color = "pink",
                              size = 2),
    axis.ticks.length = unit(5, "mm")
  )

grafico_base +
  theme(
    axis.line = element_line(color = "red", linetype = "dashed")
  )

grafico_base +
  theme(
    axis.line.x = element_line(color = "red", 
                               linetype = "dashed"),
    axis.line.y = element_line(color = "blue", 
                               linetype = "dotted",
                               size = 2)
  )

## Elementos varios
# Relación de aspecto del panel

grafico_base +
  theme(
    aspect.ratio = 1/2
  )

## Ángulo de las etiquetas
grafico_base +
  theme(
    axis.text.x = element_text(angle = -45)
  )

# Tamaño de las llaves de las leyendas
grafico_base +
  theme(
    legend.key.size = unit(5, "mm")
  )

grafico_base +
  theme(
    legend.key = element_rect(color = "black"),
    legend.key.height = unit(5, "mm"),
    legend.key.width = unit(20, "mm")
  )

# Margen del gráfico
grafico_base +
  theme(
    plot.background = element_rect(fill = "lightblue"),
    plot.margin = margin(t = 20, r = 10, b = 30, l = 50)
  )

# Qué hacer con las facetas
grafico_base +
  facet_wrap(~Species) +
  theme(
    strip.background = element_rect(fill = "yellow"),
    strip.text = element_text(color = "blue",
                              face = "bold.italic",
                              hjust = 1)
  )

## Ejercicio de la clase

# 1. Vamos a crear un boxplot con el dataset mpg, tomando en el eje x
# la variable drv y en eje y la variable cty. El fondo del gráfico debe ser
# verde, el fondo del panel debe ser azul, el título del gráfico (que tienen
# que añadir debe ser rojo), las líneas "major" del eje x deben ser amarillas.

# 2. Vamos a crear unos gráficos de dispersión con mpg, entre cty y hwy,
# el color con la variable cyl y con facetas de acuerdo con drv.
# El fondo de la leyenda debe ser azul claro, el color de los títulos de las 
# facetas debe ser negro y el texto de los títulos de las facetas debe ser blanco

ggplot(mpg, aes(x = cty, y = hwy, color = cyl)) +
  geom_point() +
  facet_wrap(~drv) +
  theme(
    legend.background = element_rect(fill = "lightblue"),
    strip.background = element_rect(fill = "black"),
    strip.text = element_text(color = "white")
  )









