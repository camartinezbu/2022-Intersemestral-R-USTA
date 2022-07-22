# Clase 12 - 21 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

library(tidyverse)
# library(ggplot2)

# Vamos a trabajar con la base de datos por defecto de economics

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

presidential_df <- presidential %>%
  filter(start > min(economics$date)) %>%
  mutate(party = case_when(
    party == "Republican" ~ "Republicano",
    party == "Democratic" ~ "Demócrata"
  ))

# Anotaciones y rectángulos

ggplot(economics) +
  geom_rect(aes(xmin = start, xmax = end,
                ymin = -Inf, ymax = Inf,
                fill = party),
            data = presidential_df,
            alpha = 0.5) +
  geom_vline(aes(xintercept = as.numeric(start)),
             data = presidential_df,
             color = "white") +
  geom_label(aes(x = start, y = 18000,
                 label = name, color = party),
             data = presidential_df,
             nudge_x = 800, size = 2,
             show.legend = FALSE) +
  geom_line(aes(x = date, y = unemploy)) +
  labs(
    title = "Desempleo en EEUU según periodo presidencial",
    caption = "Esto es un gráfico de prueba",
    y = "No. desempleados",
    x = "Año",
    fill = "Partido"
  ) +
  scale_fill_manual(
    values = c("blue", "red")
  ) +
  scale_color_manual(
    values = c("blue", "red")
  ) +
  theme(
    plot.title = element_text(size = 15, face = "bold"),
    plot.title.position = "plot",
    legend.position = "top"
  )

# Anotaciones y círculos que encierran
# install.packages("ggforce")
library(ggforce)

ggplot(iris, aes(x = Petal.Length,
                 y = Sepal.Length,
                 colour = Species)) +
  geom_point(show.legend = FALSE) +
  geom_mark_ellipse(aes(label = Species,
                        group = Species),
                    label.fontsize = 7,
                    label.buffer = unit(5, "mm"),
                    show.legend = FALSE) +
  scale_x_continuous(
    limits = c(0, 8)
  ) +
  scale_y_continuous(
    limits = c(3, 9)
  )

# Trabajemos con Gapminder
library(gapminder)

# install.packages("gghightlight")
# devtools::install_github("yutannihilation/gghighlight", force = TRUE)
library(gghighlight)

ggplot(gapminder, aes(x = year, 
                      y = lifeExp,
                      group = country)) +
  geom_line() +
  gghighlight(country == "Colombia")


ggplot(gapminder, aes(x = year, 
                      y = lifeExp,
                      group = country)) +
  geom_line() +
  gghighlight(country %in% c("Colombia", "Korea, Rep."),
              unhighlighted_colour = "lightblue")
  

# Organizar varios gráficos en el espacio: patchwork
# install.packages("patchwork")
library(patchwork)

p1 <- ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy))

p2 <- ggplot(mpg) +
  geom_bar(aes(x = as.character(year), 
               fill = drv), position = "dodge") +
  labs(x = "year")

p3 <- ggplot(mpg) +
  geom_density(aes(x = hwy, fill = drv), colour = NA) +
  facet_grid(rows = vars(drv))

# Si queremos ponerlos lado a lado
p1 + p2

p1 + p2 + p3

# Si queremos ponerlos encima de otro
p1 / p2

p1 / p2 / p3

# Gráficos más complejos
(p1 / p2) | (p3)

(p1 / p2) | (p3  / grid::textGrob("Esto es un texto"))

# Poner un gráfico encima del otro
p1 +  inset_element(p3, left = 0.55, bottom = 0.55, 
                right = .99, top = .99)

p1 +  inset_element(p2 + p3, left = 0.25, bottom = 0.55, 
                    right = .99, top = .99)

p1 +  inset_element(p2 + p3, left = 0.25, bottom = 0.55, 
                    right = .99, top = .99) +
  plot_annotation(tag_levels = "A")

# Ejercicio

## 1. Del dataset diamonds, construir un boxplot con la variable x según
## la variable cut. Cada boxplot debe tener el color asociado a la variable cut.
## Y sin la leyenda de color. Pista: argumento show.legend

## 2. Del dataset gapminder, construir un gráfico de línea con la evolución de la
## expectativa de vida, donde se resalte a Tanzania. Pista: gghighlight

## 3. Usando patchwork, ubique un gráfico sobre el otro.





