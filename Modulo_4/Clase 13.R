# Clase 13 - 22 de julio de 2022
# Módulo 4: Visualización de datos con ggplot
# Referencia: Libro de ggplot2 de Hadley Wickham
# https://ggplot2-book.org/index.html

library(tidyverse)
library(patchwork)

## Escalas de posición: (x,y) ----

### Escalas numéricas ----
### Las vamos a acceder a través de las funciones scale_x_continuous y
### scale_y_continuous

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~year)

mpg_99 <- ggplot(filter(mpg, year == 1999),
                 aes(x = displ, y = hwy)) +
  geom_point()

mpg_08 <- ggplot(filter(mpg, year == 2008),
                 aes(x = displ, y = hwy)) +
  geom_point()

mpg_99 + mpg_08 

#### Modificar los límites del gráfico ----

mpg_99 +
  scale_x_continuous(limits = c(0, 10)) +
  scale_y_continuous(limits = c(0, 100))
  
mpg_99_fix <- mpg_99 +
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))

mpg_08_fix <- mpg_08 +
  scale_x_continuous(limits = c(1, 7)) +
  scale_y_continuous(limits = c(10, 45))

mpg_99_fix + mpg_08_fix

##### Atajo: función lims

mpg_99 +
  lims(x = c(0, 10), y = c(0, 100))

#### Hacer zoom ----

mi_mediana <- mpg %>%
  filter(drv == "f") %>%
  summarise(median(hwy)) %>%
  pull()

mi_boxplot <- ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_hline(yintercept = mi_mediana, color = "blue") +
  geom_boxplot()

mi_boxplot

mi_bp_scale <- mi_boxplot +
  lims(y = c(10,35))

mi_bp_coord <- mi_boxplot +
  coord_cartesian(ylim = c(10,35))

mi_bp_scale + mi_bp_coord

#### Tamaño del panel ----

mi_raster <- ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density)) +
  theme(legend.position = "none") 

mi_raster +
  scale_x_continuous(expand = expansion(0)) +
  scale_y_continuous(expand = expansion(0))

##### Siguiendo el ejemplo anterior
mpg_99 +
  scale_x_continuous(limits = c(0, 10), expand = expansion(0)) +
  scale_y_continuous(limits = c(0, 100), expand = expansion(0))

#### Diferencia entre expansion aditiva y multiplicativa

mi_raster +
  scale_y_continuous(expand = expansion(add = 5)) +
  scale_x_continuous(expand = expansion(add = 5))

mi_raster +
  scale_y_continuous(expand = expansion(mult = .3)) +
  scale_x_continuous(expand = expansion(mult = .3))

mi_raster +
  scale_x_continuous(expand = expansion(mult = c(.05, .2))) +
  scale_y_continuous(expand = expansion(mult = c(.3, 0)))

#### Cortes de los ejes ----

#### Major
mpg_99 +
  scale_x_continuous(breaks = c(2, 4, 6)) +
  scale_y_continuous(breaks = c(20, 40))

mpg_99 +
  scale_x_continuous(breaks = seq(2, 6, 0.5)) +
  scale_y_continuous(breaks = c(20, 40))

#### Minor

mpg_99 +
  scale_x_continuous(minor_breaks = seq(1, 7, 0.25)) +
  scale_y_continuous(minor_breaks = 25)

#### Etiquetas de los ejes ----

mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = c("dos", "tres", "cuatro", "cinco", "seis")
  )

mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = c("dos", "tres", "cuatro", "cinco", "seis")
  ) +
  scale_y_continuous(
    breaks = seq(10, 50, 5),
    labels = scales::label_percent(scale = 1)
  )

mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = c("dos", "tres", "cuatro", "cinco", "seis")
  ) +
  scale_y_continuous(
    breaks = seq(10, 50, 5),
    labels = scales::label_dollar(prefix = "COP$")
  )

mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = c("dos", "tres", "cuatro", "cinco", "seis")
  ) +
  scale_y_continuous(
    breaks = seq(10, 50, 5),
    labels = scales::label_dollar(prefix = "", suffix = "€")
  )


mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = c("dos", "tres", "cuatro", "cinco", "seis")
  ) +
  scale_y_continuous(
    breaks = seq(10, 50, 5),
    labels = scales::label_comma(scale = 100)
  )

mpg_99 +
  scale_x_continuous(
    breaks = seq(2, 6, 1), 
    labels = scales::label_ordinal(rules = scales::ordinal_spanish())
  ) +
  scale_y_continuous(
    breaks = seq(10, 50, 5),
    labels = scales::label_dollar(prefix = "", suffix = "€")
  )

#### Transformaciones ----

##### Ejes reversados
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_reverse()

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_reverse()

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_reverse() +
  scale_y_reverse()

#### Escala logarítimica

ggplot(diamonds, aes(x = price, y = carat)) +
  geom_point() +
  scale_y_log10() +
  scale_x_continuous(trans = "log")

### Escalas discretas ----
ggplot(mpg, aes(x = hwy, y = class)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = class)) +
  geom_point() +
  scale_x_continuous(
    breaks = seq(10, 50, 5)
  ) +
  scale_y_discrete(
    limits = c("subcompact", "midsize", "pickup", "No existe")
  )

ggplot(mpg, aes(x = hwy, y = class)) +
  geom_point() +
  scale_x_continuous(
    breaks = seq(10, 50, 5)
  ) +
  scale_y_discrete(
    limits = c("subcompact", "midsize", "pickup", "No existe"),
    breaks = c("subcompact", "pickup")
  )

ggplot(mpg, aes(x = hwy, y = class)) +
  geom_point() +
  scale_x_continuous(
    breaks = seq(10, 50, 5)
  ) +
  scale_y_discrete(
    limits = c("subcompact", "midsize", "pickup"),
    labels = c(subcompact = "Subcompacto",
               midsize = "Mediano",
               pickup = "Camioneta")
  )

### Ejercicio: Dataset iris

# 1. Hacer un boxplot de Petal.Length de acuerdo con cada especie.
# La escala en en el eje debe ir de 1 a 5, sin que se modifique
# la forma del boxplot.

# 2. Vamos a hacer un scatterplot de Petal.Length con Petal.Width,
# coloreado según la especie. El eje x debe estar reversado, y en el
# eje y deben haber líneas (major) sólo en 0, 0.5 y 1.




