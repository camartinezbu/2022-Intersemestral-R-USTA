# Clase 5 - 28 de junio de 2022
# Módulo 2: Tidyverse

library(tidyverse)
library(lubridate)

# Fechas: lubridate
# Strings: stringr
# Factores: forcats

# Hablemos de Fechas ----
# Dependiendo del lugar, tenemos diferentes convenciones para definir fechas

# Hay un fomato estándar: ISO 8601 -> YYYY-MM-DD
# 1 de febrero de 2022 -> 2022-02-01

## Fechas en R ----

2022-06-28 # No: Esto es un numeric

"2022-06-28" # No: Esto es un string/character

str(as.Date("2022-06-28"))

## Aritmética con fechas
as.Date("2022-06-28") > as.Date("2021-05-12")

as.Date("2022-06-28") + 1

as.Date("2016-10-15") - as.Date("1998-05-20")

## Gráficos

mis_fechas <- c(
  as.Date("2022-06-26"),
  as.Date("2022-06-27"),
  as.Date("2022-06-28")
)

ggplot() +
  geom_point(aes(x = mis_fechas, y = 1:3))

## Horas, minutos y segudos: ISO 8601 -> YYYY-MM-DD HH:MM:SS

## Datetimes: tanto fecha como hora, minuto y segundo
## POSIXct -> en los segundos que han pasado desde 1970-01-01 00:00:00

# Hora local
as.POSIXct("2022-05-04 12:35:45")

# Hora en el meridiano de greenwich
as.POSIXct("2022-05-04 12:35:45", tz = "Europe/Warsaw")


# Lubridate
as.Date("6/28/2022")

# Funciones para leer Dates: ymd, dmy...
fecha1 <- ymd("2022-06-28")

fecha2 <- mdy("06/28/2022", tz = "America/Bogota")

# Dos notas:
# 1. Comparado con el paquete base, lubridate es más flexible en cuanto a formatos
# de fechas.
# 2. Por defecto, la zona horaria en lubridate es "UTC"

parse_date_time("28.06.2022", order = "dmy", tz = "Asia/Pyongyang")

## Funciones para leer Datetimes: ymd_hm, mdy_hms, ...

dmy_hm("28-06-2022 7:33pm")

## Formato de fechas
# d: El día numérico de la semana
# m: El mes del año
# y: Año con el siglo
# Y: Año sin el siglo
# H: Horas (24 horas)
# I: Horas (12 horas)
# M: Minutos
# a: Día de la semana abreviado
# A: Día de la semana completo
# b: Mes del año abreviado
# B: Mes del año completo
# p: AM/PM

parse_date_time("28-06-2022 7:33pm", order = "dmy IMp")

## Extraer elementos de mi fecha:
mi_fecha <- dmy_hms("28-06-2022 7:33:05pm", 
                   tz = "America/Bogota")

wday(mi_fecha, 
     week_start = 1, # Que la semana empiece el lunes y no el domingo
     label = TRUE, # Nombre del día y no el número
     abbr = FALSE, # Que el nonbre sea completo y no abreviado
     locale = "es_ES"
     )

month(Sys.Date(),
      label = TRUE,
      abbr = TRUE,
      locale = "fr_FR")



# Funciones para extraer la fecha, 
# la fecha y hora y la zona horaria de mi computador
Sys.Date()
Sys.time()
Sys.timezone()

# Otras funciones útiles para trabajar con datetimes
leap_year(mi_fecha) # Si el año es bisiesto
am(mi_fecha) # Si la hora está en la mañana
pm(mi_fecha) # Si la hora está en la tarde
dst(mi_fecha) # Si hay daylight savings time (paises con estaciones)
quarter(mi_fecha, type = "year.quarter") # El trimestre del año
semester(mi_fecha) # El semestre del año

# Periodos vs duraciones ----
# Periodos: Se refieren a los espacios de tiempo que hablamos ordinariamente.
# Estos pueden variar dependiendo del día en que estamos parados.
# Duraciones: Se refieren a unos momentos fijo definidos en segundos.

# Periodos: minutes, hours, weeks, years, etc...
# Duraciones: dminutes, dhours, dweeks, dyears, etc...

now() # Sys.time()
today() # Sys.date()

ahora <- now()

ahora + minutes(10)
ahora + dminutes(10)

ahora + months(2)
ahora + dmonths(2)

today() - ymd("1998-05-11")

## Redondear datetimes: floor_date, round_date, ceiling_date.
floor_date(ahora, unit = "hour")

ceiling_date(ahora, unit = "hour")

round_date(ahora, unit = "minute")

## Ejemplo: Casos de covid en Colombia
covid_col <- read_csv("~/Downloads/Casos_positivos_de_COVID-19_en_Colombia.csv")

covid_col_limpio <- covid_col %>%
  mutate(`Nombre departamento` = case_when(
    `Nombre departamento` == "Caldas" ~ "CALDAS",
    `Nombre departamento` == "Cundinamarca" ~ "CUNDINAMARCA",
    `Nombre departamento` == "Santander" ~ "SANTANDER",
    `Nombre departamento` == "Tolima" ~ "TOLIMA",
    TRUE ~ `Nombre departamento`
  ))


# Número de casos registrados por deparamento
casos_departamento <- covid_col_limpio %>%
  count(`Nombre departamento`)

# Estado de los casos en Bogotá
casos_estado <- covid_col_limpio %>%
  filter(`Código DIVIPOLA departamento` == 11) %>%
  count(Estado)

# Histórico mensual de casos de covid en medellín
historico_medellin <- covid_col_limpio %>%
  filter(`Código DIVIPOLA municipio` == 50001) %>%
  group_by(Year = year(`Fecha de inicio de síntomas`),
           Month = month(`Fecha de inicio de síntomas`)) %>%
  summarise(total = n()) %>%
  mutate(fecha_completa = paste0(as.character(Year), "-",
                                 as.character(Month))) %>%
  mutate(fecha_completa = ym(fecha_completa)) %>%
  select(-c(Year, Month)) %>%
  filter(!is.na(fecha_completa))

ggplot(historico_medellin, aes(fecha_completa, total)) +
  geom_line() +
  theme_bw()

for (departamento in unique(covid_col_limpio$`Código DIVIPOLA departamento`)) {
  base <- covid_col_limpio %>%
    filter(`Código DIVIPOLA departamento` == departamento) %>%
    group_by(Year = year(`Fecha de inicio de síntomas`),
             Month = month(`Fecha de inicio de síntomas`)) %>%
    summarise(total = n()) %>%
    mutate(fecha_completa = paste0(as.character(Year), "-",
                                   as.character(Month))) %>%
    mutate(fecha_completa = ym(fecha_completa)) %>%
    select(-c(Year, Month)) %>%
    filter(!is.na(fecha_completa))
  
  print(ggplot(base, aes(fecha_completa, total)) +
    geom_line() +
    theme_bw() +
    labs(title = departamento))
}





