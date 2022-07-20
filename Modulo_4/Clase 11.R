# Clase 8 y 9 - 19 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

# Cargar los paquetes necesarios
library(tidyverse)

# Resúmenes estadísticos: geom_bar(stat = "identity")

# Cuál es el promedio de precio según cada color de los diamantes

# Desde dplyr
diamonds %>%
  group_by(color) %>%
  summarise(promedio_precio = mean(price)) 

# Desde ggplot
ggplot(diamonds, aes(x = color, y = price)) +
  geom_bar(stat = 'summary_bin', fun = sd)

# Cómo se relacionan los atributos de table, depth
ggplot(diamonds, aes(x = table, y = depth)) +
  geom_point()

ggplot(diamonds, aes(table, depth)) +
  geom_bin2d(binwidth = 1) +
  xlim(50, 70) +
  ylim(50, 70)

# Qué pasa si quiero ver también el precio promedio
ggplot(diamonds, aes(x = table, y = depth, z = price)) +
  geom_raster(binwidth = 1, 
              stat = "summary_2d",
              fun = median) +
  xlim(50, 70) +
  ylim(50, 70)

# Superficies: geom_contour()
ggplot(faithfuld, aes(x = eruptions, y = waiting)) +
  geom_raster(aes(fill = density))

ggplot(faithfuld, aes(x = eruptions, y = waiting)) +
  geom_contour(aes(z = density, colour = ..level..))

# Mapas: una mirada rápida
# Paquetes: sf
# install.packages("sf")
library(sf)

# Paquetes: ozmaps
# install.packages("ozmaps")
library(ozmaps)

oz_states <- ozmaps::ozmap_states

# Mapas vectoriales
# Pintemos los polígonos
ggplot(oz_states) +
  geom_sf(aes(fill = NAME)) +
  coord_sf() +
  theme(
    legend.position = "none"
  )

ggplot(oz_states) +
  geom_sf(aes(fill = NAME)) +
  geom_sf_label(aes(label = NAME)) +
  coord_sf(
    xlim = c(145, 153),
    ylim = c(-32, -38),
  ) +
  theme(
    legend.position = "none"
  )

oz_capitals <- tibble::tribble(
  ~city,           ~lat,     ~lon,
  "Sydney",    -33.8688, 151.2093,  
  "Melbourne", -37.8136, 144.9631, 
  "Brisbane",  -27.4698, 153.0251, 
  "Adelaide",  -34.9285, 138.6007, 
  "Perth",     -31.9505, 115.8605, 
  "Hobart",    -42.8821, 147.3272, 
  "Canberra",  -35.2809, 149.1300, 
  "Darwin",    -12.4634, 130.8456,
)

ggplot() +
  geom_sf(data = oz_states, aes(fill = NAME)) +
  theme(
    legend.position = "none"
  ) +
  geom_point(data = oz_capitals,
             aes(x = lon, y = lat),
             shape = "diamond filled", 
             fill = "yellow",
             size = 3)

## Anotaciones y etiquetas

## funcion labs

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = factor(cyl), shape = drv)) +
  labs(
    title = "Millas por tamaño de motor y cilindros",
    x = "Desplazamiento del motor",
    y = "Millas recorridas por\ngalón en autopista",
    caption = "Fuente: Gobierno de Estados Unidos",
    colour = "Número de\ncilindros",
    shape = "Tracción"
  )

# Ecuaciones sencillas
values <- seq(from = -2, to = 2, by = .01)
df <- data.frame(x = values, y = values ^ 3)

ggplot(df, aes(x, y)) +
  geom_path() +
  labs(
    y = quote(f(x) == x^3)
  )

# Etiquetas de texto
df <- data.frame(x = 1, y = 3:1, family = c("sans", "serif", "mono"))

ggplot(df, aes(x, y)) +
  geom_text(aes(label = family, family = family))

df <- data.frame(x = 1, y = 3:1, face = c("plain", "bold", "italic"))

ggplot(df, aes(x, y)) +
  geom_text(aes(label = face, fontface = face))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = factor(cyl), shape = drv)) +
  geom_text(label = "Este es un mensaje", x = 4, y = 40, 
            fontface = "italic", size = 3, color = "blue",
            angle = 45) +
  labs(
    title = "Millas por tamaño de motor y cilindros",
    x = "Desplazamiento del motor",
    y = "Millas recorridas por\ngalón en autopista",
    caption = "Fuente: Gobierno de Estados Unidos",
    colour = "Número de\ncilindros",
    shape = "Tracción"
  )

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = factor(cyl), shape = drv)) +
  geom_label(label = "Este es un mensaje", x = 4, y = 40, 
            fontface = "italic", size = 3, color = "blue",
            fill = "yellow") +
  labs(
    title = "Millas por tamaño de motor y cilindros",
    x = "Desplazamiento del motor",
    y = "Millas recorridas por\ngalón en autopista",
    caption = "Fuente: Gobierno de Estados Unidos",
    colour = "Número de\ncilindros",
    shape = "Tracción"
  )

df <- data.frame(trt = c("a", "b", "c"), 
                 resp = c(1.2, 3.4, 2.5))

ggplot(df, aes(resp, trt)) + 
  geom_point() + 
  geom_text(aes(label = trt), nudge_y = 0.25)
  
# Ejercicios
iris

# 1. Usando geom_bar, y sin usar los verbos del tidyverse, construya
# un gráfico de barras que muestre la desviación estándar de la variable
# Petal.Length de acuerdo con la columna Species

# 2. Escriba el código de dplyr que me devuelve una tabla equivalente a lo
# contenido en el gráfico de arriba

# 3. Cree un dataframe con 3 puntos (x,y) y 3 etiquetas (label), pinte esos
# puntos en el espacio con sus respectivas etiquetas, sin que se sobrelapen con
# los puntos
  
mi_dataframe <- data.frame(
  x = floor(runif(3, 1, 10)),
  y = floor(runif(3, 1, 10)),
  label = c("a", "b", "c")
)

ggplot(mi_dataframe, aes(x = x, y = y)) +
  geom_point() +
  geom_text(aes(label = label), nudge_y = -0.15)


