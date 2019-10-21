
## THIS SCRIPT HELPS MAKING BASIC COMPUTATIONS AND PREPARING FILES

library(tidyverse)
library(hgchmagic)
library(mop)

source("comp-helpers.R")

#d0 <- read_csv("data/clean/leche-secop-1.csv", col_types = cols(.default = "c"))
d0 <- read_csv("data/clean/leche-secop_1-full.csv", col_types = cols(.default = "c"))
dic <- read_csv("data/clean/secop_dic.csv")


# Status
status <- d0 %>% count_Cat("proc_status")
unique(d0$proc_status)
d0 <- d0 %>% filter(proc_status == "Celebrado")

## filter-celebrados

write_csv(d0,"data/clean/leche-secop_1-full-celebrado.csv")

### Filter PAE

pae <- d0 %>% filter_keywords(c("PAE","escolar"), cols = "cont_objeto_det")
write_csv(pae, "data/clean/leche-pae.csv")


# Contratistas

contratistas <- d0 %>% 
  select(contratista_id, contratista_nombre) %>% 
  filter(!is.na(contratista_id)) %>% 
  count_CatCat()

# Convert numeric
num_vars <- dic %>% filter(ctype == "Num") %>% pull(id)
d0 <- d0 %>% mutate_at(vars(one_of(num_vars)), as.numeric)

geo_vars <- dic %>% filter(ctype %in% c("Gcd","Gnm")) %>% pull(id)

# Quiénes tienen más contratos

# por nit

d1 <- d0 %>%
  select(contratista_id, contratista_id_tipo) %>% 
  count_CatCat()
write_csv(d1, "out/01_top_n_contratos_por_nit.csv")

d2 <- d1 %>% 
  mutate(contratista = match_replace(contratista_id, contratistas)) %>% 
  select(contratista, total) %>% 
  filter(!is.na(contratista)) %>% 
  top_n(10)
hgch_bar_CatNum(d2, opts = list(colors = theme$colors, sort = "desc", orientation = "hor"))

# rep legal
cols <- c("rep_legal_id", "rep_legal_id_tipo")
d1 <- d0 %>%
  count_CatCat(cols)
write_csv(d1, "out/02_top_n_contratos_por_rep_legal.csv")

# Quiénes ganan más plata con la contratación
cols <- c("contratista_id", "contratista_id_tipo", "cont_valor_tot")
d1 <- d0 %>% agg_CatCatNum(cols = cols)
write_csv(d1, "out/03_top_dinero_contratos_por_nit.csv")

d2 <- d1 %>% 
  mutate(contratista = match_replace(contratista_id, contratistas)) %>% 
  select(contratista, cont_valor_tot) %>% 
  filter(!is.na(contratista)) %>% 
  top_n(10)
hgch_bar_CatNum(d2, opts = list(colors = theme$colors, sort = "desc", orientation = "hor"))



cols <- c("rep_legal_id", "rep_legal_id_tipo", "cont_valor_tot") 
d1 <- d0 %>% agg_CatCatNum(cols = cols)

write_csv(d1, "out/04_top_dinero_contratos_por_rep_legal.csv")




# Top X contratistas por región

cols <- c("contratista_id", "muni_obten")
d1 <- d0 %>% count_CatCat(cols = cols)

write_csv(d1, "out/05_top_contratistas_por_municipio_obtencion_numero_contratos.csv")

cols <- c("contratista_id", "muni_obten", "cont_valor_tot")
d1 <- d0 %>% agg_CatCatNum(cols = cols)

write_csv(d1, "out/06_top_contratistas_por_municipio_obtencion_dinero.csv")


# Tipo de contratación más frecuentes

cols <- c("proc_tipo")
d1 <- d0 %>% count_Cat(cols = cols)

write_csv(d1, "out/07_tipo_proceso_frecuente.csv")



# Top Municipios y departamos de ejecución de contratos

cols <- c("contratista_id", "muni_ejec")
d1 <- d0 %>% count_CatCat(cols = cols)

write_csv(d1, "out/08_top_contratistas_por_municipio_ejecucion_numero_contratos.csv")

cols <- c("contratista_id", "muni_ejec", "cont_valor_tot")
d1 <- d0 %>% agg_CatCatNum(cols = cols)

write_csv(d1, "out/09_top_contratistas_por_municipio_ejecucion_dinero.csv")

# Fechas con más contratos

d1 <- d0 %>% mutate(cont_firma_fecha_mes = substr(cont_firma_fecha, 1,7)) %>% 
  select(cont_firma_fecha_mes) %>% count_Cat()
write_csv(d1, "out/10_meses_mas_contratos.csv")


# Fechas con más contratos por región

d1 <- d0 %>% mutate(cont_firma_fecha_mes = substr(cont_firma_fecha, 1,7)) %>% 
  select(cont_firma_fecha_mes, muni_obten) %>% count_CatCat()
write_csv(d1, "out/11_meses_mas_contratos_por_muni_obtencion.csv")


# Entidades que más contratan

cols <- c("ent_nombre", "ent_nit")
d1 <- d0 %>% count_CatCat(cols = cols)
write_csv(d1, "out/12_ent_mas_contratos.csv")


# Buscar contratos PAE, alimentación escolar
source("clean_funs.R")
d1 <- d0 %>% filter_keywords(c("escolar", "pae"), cols = c("cont_objeto_det"))
write_csv(d1, "out/13_contratos_escolar.csv")












