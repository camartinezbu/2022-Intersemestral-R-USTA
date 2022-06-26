# Clase 4 - 24 de junio de 2022
# Módulo 2: Tidyverse

library(tidyverse)

# Cargar los sets de datos ----

sets <- read_csv("Módulo 2 Tidyverse /Datos/Lego/sets.csv")
themes <- read_csv("Módulo 2 Tidyverse /Datos/Lego/themes.csv")

# Repaso verbos dplyr

# Cuál es el número promedio de partes de los sets agrupados según el año

numero_partes_por_año <- sets %>%
  group_by(year) %>%
  summarise(promedio = mean(num_parts))

ggplot(numero_partes_por_año, aes(x = year, y = promedio)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(
    breaks = seq(from = 1950, to = 2020, by = 10)
  ) +
  scale_y_continuous(
    breaks = seq(from = 0, to = 300, by = 25)
  ) +
  # theme_bw()
  # theme_classic()
  # theme_dark()
  theme_void()

numero_partes_por_año_wide <- numero_partes_por_año %>%
  pivot_wider(names_from = year, values_from = promedio)

# Unir distintos dataframes: binds y joins ----

## Joins: left_join, right_join, inner_join, full_join ----
## Ejemplo Joins:

productos <- data.frame(id_cliente = c(1:6),
                        producto = c("Horno",
                                     "Television",
                                     "Telefono",
                                     "Lavadora",
                                     "Luces",
                                     "Tableta"))

departamentos <- data.frame(id_cliente = c(2, 4, 6, 7, 8),
                            departamento = c("Cundinamarca",
                                             "Huila",
                                             "Cesar",
                                             "Meta",
                                             "Antioquia"))


# Inner_join: "Intersección", me devuelve los registros que aparecen en ambas tablas
resultado_inner <- productos %>%
  inner_join(departamentos, by = "id_cliente")

# Full_join: "Unión", me devuelve todos los registros
resultado_full <- productos %>%
  full_join(departamentos, by = "id_cliente")

# Left_join: Une los elementos, pero conserva todos los de la tabla izquierda
resultado_left <- productos %>%
  left_join(departamentos, by = "id_cliente")

resultado_left_alt <- departamentos %>%
  left_join(productos, by = "id_cliente")

# Right_join: Une los elementos, pero conserva todos los de la tabla derecha
resultado_right <- productos %>%
  right_join(departamentos, by = "id_cliente")

resultado_right_alt <- departamentos %>%
  right_join(productos, by = "id_cliente")


# Ejemplo Lego

set_themes <- sets %>%
  left_join(themes, by = c("theme_id" = "id"),
            suffix = c("_set", "_theme"))

# Cuáles es el promedio de piezas según el tema

numero_partes_por_tema <- set_themes %>%
  group_by(name_theme) %>%
  summarise(promedio = mean(num_parts)) %>%
  top_n(10, promedio) %>%
  arrange(desc(promedio))

ggplot(numero_partes_por_tema, aes(x = name_theme, y = promedio)) +
  geom_col()

# Opción 1 para extraer los elementos de una columna: $
top_10_temas <- numero_partes_por_tema$name_theme

# Opción 2 para extraer los elementos de una columna: pull()
top_10_temas <- numero_partes_por_tema %>%
  pull(name_theme)

ggplot(numero_partes_por_tema, aes(x = factor(name_theme, level = top_10_temas),
                                   y = promedio)) +
  geom_col() + 
  theme(
    axis.text.x = element_text(angle = 45)
  )

# Ejemplo Lego: Segunda parte
inventories <- read_csv("Módulo 2 Tidyverse /Datos/Lego/inventories.csv")
inventory_parts <- read_csv("Módulo 2 Tidyverse /Datos/Lego/inventory_parts.csv")
parts <- read_csv("Módulo 2 Tidyverse /Datos/Lego/parts.csv")

parts_by_set <- inventories %>%
  left_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  left_join(parts, by = "part_num") %>%
  right_join(set_themes, by = "set_num") %>%
  select(name_set, year, name_theme, num_parts, part_num, name, quantity, part_material)

## Binds ----

## Bind_rows: Pegar filas

subconjunto <- parts_by_set %>%
  head(20)

subconjunto2 <- parts_by_set %>%
  slice(21:40)

subconjunto3 <- subconjunto %>%
  bind_rows(subconjunto2)

## Bind_cols: Pergar columnas

subconjunto4 <- subconjunto3 %>%
  select(name_set, year, name_theme)

subconjunto5 <- subconjunto3 %>%
  select(-c(name_set, year, name_theme))

base_original <- subconjunto4 %>%
  bind_cols(subconjunto5)




