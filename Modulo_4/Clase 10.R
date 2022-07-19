# Clase 10 - 18 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

# Cargar los paquetes necesarios
library(tidyverse)

# Capas y tipos de gráficos básicos
# geom_area(): Pinta un gráfico área. Necesita aesthetics (x,y)
# geom_bar(stat = "identity"): Pinta un gráfico de barras. Necesita (x,y)
# geom_line(): Pinta un gráfico de línea. Necesita (x,y)
# geom_point(): Pinta un gráfico de dispersión. Necesita (x,y)
# geom_polygon(): Pinta un polígono con base en unos vértices. Necesita (x, y)
# geom_rect(), geom_tile(), geom_raster(): Para pintar rectángulos. Necesita distintos tipos de aesthetics.

# geom_bar: Cuenta las ocurrencias de los valores de una fila.
# Piensen en un histograma de forma discreta.
ggplot(iris, aes(x = Species)) +
  geom_bar()

maximo_sepalo <- iris %>%
  group_by(Species) %>%
  summarise(Maximo = max(Sepal.Length))

# geom_bar(stat = "identity"): Permite asignar la altura de una barra
# más allá de el número de ocurrencias
ggplot(maximo_sepalo, aes(x = Species, y = Maximo)) +
  geom_bar(stat = "identity")

# geom_col: un atajo para geom_bar(stat = "identity")
ggplot(maximo_sepalo, aes(x = Species, y = Maximo)) +
  geom_col()

# Dataframe de ejemplo.
mi_dataset_ejemplo <- data.frame(
  x = c(3, 1, 5),
  y = c(2, 4, 6),
  label = c("A", "B", "C")
)

# Separando los elementos de mi ggplot
mi_grafico_base <- ggplot(mi_dataset_ejemplo, 
                          aes(x = x, y = y, label = label)) +
  theme(
    panel.background = element_rect(fill = "lightblue")
  ) +
  labs(
    title = "Gráfico de ejemplo",
    x = "Esta es la variable x",
    y = "Esta es la variable y",
    caption = "Ejemplo de ggplot"
  )

# Gráfico de dispersión
mi_grafico_base +
  geom_point()

# Gráfico de línea
mi_grafico_base +
  geom_line()

# Gráfico de barras
mi_grafico_base +
  geom_bar(stat = "identity")

# Dibujando rectángulos
mi_grafico_base +
  geom_tile()

# Gráfico de área
mi_grafico_base +
  geom_area()

# Path
mi_grafico_base +
  geom_path()

# Polygon
mi_grafico_base +
  geom_polygon()

# Geometria de texto: Requiere del argumento label.
mi_grafico_base +
  geom_text()

## Dos preguntas
# 1. De las geometrías que hemos visto, ¿cuáles se usan para pintar un geom_smooth()?
# 2. De las geometrías que hemos visto, ¿cuáles se usan para pintar un geom_boxplot()?

ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot()


## Múltiples grupos con 1 aesthetic: group
install.packages("gapminder")
library(gapminder)

data <- gapminder

ggplot(data, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3)

## Diferentes grupos con diferentes capas
ggplot(data, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.3) +
  geom_smooth(se = FALSE, color = "red")

ggplot(data, aes(x = year, y = lifeExp)) +
  geom_line(aes(group = country), alpha = 0.3) +
  geom_smooth(se = FALSE, color = "red") +
  labs(
    title = "La expectativa de vida ha mejorado",
    x = "Año",
    y = "Expectativa de vida",
    caption = "Fuente: gapminder"
  ) +
  theme(
    panel.background = element_rect(fill = "white")
  )

ggplot(mpg, aes(class)) +
  geom_bar(aes(fill = drv))

# Capas para mostrar incertidumbre: nuevo atributo ymax y ymin
# geom_crossbar(): x discreto, y continuo con el centro
# geom_errorbar(): x discreto, y continuo sin el centro
# geom_pointrange(): x discreto, y continuo con el centro
# geom_ribbon(): x continuo, y continuo
# geom_smooth(): x continuo, y continuo

mi_dataset_ejemplo_2 <- data.frame(
  x = 1:3,
  y = c(18, 11, 16),
  se = c(1.2, 0.5, 1.0)
)

mi_grafico_base_2 <- ggplot(mi_dataset_ejemplo_2, aes(x = x, y = y,
                                 ymin = y - se, 
                                 ymax = y + se))

# geom_crossbar
mi_grafico_base_2 +
  geom_crossbar()

# geom_pointrange
mi_grafico_base_2 +
  geom_pointrange()

# geom_errorbar
mi_grafico_base_2 +
  geom_errorbar()

# geom_smooth
mi_grafico_base_2 +
  geom_smooth(stat = "identity")

# geom_ribbon
mi_grafico_base_2 +
  geom_ribbon()

# Capas para mostrar pesos
ggplot(midwest, aes(x = percollege, y = percbelowpoverty)) +
  geom_point()

ggplot(midwest, aes(x = percollege, y = percbelowpoverty)) +
  geom_point(aes(size = poptotal))

ggplot(midwest, aes(x = percollege, y = percbelowpoverty)) +
  geom_point(aes(size = poptotal/1e6),
             alpha = 0.5) +
  geom_smooth(aes(weight = poptotal), method = "lm") +
  scale_size_area(
    "Población\nen millones",
    breaks = c(0.5, 1, 2, 4)
  )

ggplot(midwest, aes(x = percbelowpoverty)) +
  geom_histogram(binwidth = 1)

ggplot(midwest, aes(percbelowpoverty)) +
  geom_histogram(
    aes(weight = poptotal), binwidth = 1
  )

## Graficando distribución

# geom_histogram
ggplot(diamonds, aes(depth)) +
  geom_histogram()

## Restringir los límites de un gráfico: Dos opciones

# xlim
ggplot(diamonds, aes(depth)) +
  geom_histogram(binwidth = 0.1) +
  xlim(55, 70)

# argumento limits en scale_x_continuous
ggplot(diamonds, aes(depth)) +
  geom_histogram(binwidth = 0.1) +
  scale_x_continuous(
    limits = c(55,70)
  )

# geom_freqpoly

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(binwidth = 0.1) +
  xlim(55,70)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(binwidth = 0.1) +
  xlim(55,70)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(binwidth = 0.1) +
  xlim(55,70) +
  facet_wrap(~cut)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(aes(group = cut), binwidth = 0.1) +
  xlim(55,70)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(aes(color = cut), binwidth = 0.1) +
  xlim(55,70)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(aes(color = cut), binwidth = 0.1) +
  xlim(55,70) +
  facet_wrap(~cut)

ggplot(diamonds, aes(depth)) +
  geom_freqpoly(aes(color = cut), binwidth = 0.1) +
  xlim(55,70) +
  facet_wrap(~cut) +
  theme(
    legend.position = "none"
  )

# geom_density

ggplot(diamonds, aes(depth)) +
  geom_density() +
  xlim(55,70)

ggplot(diamonds, aes(depth)) +
  geom_density() +
  xlim(55,70) +
  facet_wrap(~cut)

ggplot(diamonds, aes(depth)) +
  geom_density(aes(fill = cut, color = cut),
               alpha = 0.2) +
  xlim(55,70)

# boxplot
ggplot(diamonds, aes(x = clarity, y = depth)) +
  geom_boxplot()

ggplot(diamonds, aes(y = clarity, x = depth)) +
  geom_boxplot()

ggplot(diamonds, aes(x = clarity, y = depth)) +
  geom_violin(aes(color = clarity, fill = clarity),
              alpha = 0.2) +
  theme(
    legend.position = "none"
  )

## Overplotting

df <- data.frame(
  x = rnorm(3000),
  y = rnorm(3000)
)

ggplot(df, aes(x, y)) +
  geom_point()

# Puedo cambiar la forma que estoy utilizando: shape
ggplot(df, aes(x, y)) +
  geom_point(shape = 1)

ggplot(df, aes(x, y)) +
  geom_point(shape = ".")

# Puedo cambiar la transparencia de los puntos: alpha
ggplot(df, aes(x,y)) +
  geom_point(alpha = .5)

ggplot(df, aes(x,y)) +
  geom_point(alpha = .1)

# Bin2d
ggplot(df, aes(x, y)) +
  geom_bin2d(binwidth = 0.2)

# hex
install.packages("hexbin")
library(hexbin)

ggplot(df, aes(x,y)) +
  geom_hex(binwidth = 0.3)

