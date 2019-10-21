# THIS SCRIPT WAS USED FOR THE VISUALIZATIONS
# SMALL DATA FILES WERE PULLED DIRECTLY FROM GOOGLE SHEETS MANUALLY CURATED FROM MULTIPLE SOURCES

library(tidyverse)
library(hgchmagic)
library(googlesheets)
library(htmlwidgets)

source("comp-helpers.R")
source("theme.R")

library(visNetwork)
library(tableviz)

d0 <- read_csv("data/clean/leche-secop_1-full-celebrado.csv",
               col_types = cols(unidad_ejec_id = "c"))
dic <- read_csv("data/clean/secop_dic.csv")
problems(d0)

# Red Colanta
url <- "https://docs.google.com/spreadsheets/d/18lasGnUT7r_VIa0Qe18af-jACn3axjtuVBni5VerYlc/edit#gid=0"
ss <- gs_url(url)
d <- gs_read_csv(ss)

d1 <- d %>% filter(Empresa == "Colanta") %>%
  select(from = personaje1, to = personaje2, label = relacion)

edges <- d1 %>% distinct()
nodes <- tibble(id = unique(c(edges$from, edges$to)))
nodes <- nodes %>% mutate(label = id) %>% filter(!is.na(id))
visNetwork(nodes, edges, width = "100%")

# Contratos colanta
coop_colanta_nit <- 	890904478
d_colanta <- d0 %>% filter(contratista_id == coop_colanta_nit)
d_colanta2 <- rename_with_dic(d_colanta, dic)

tableviz_dt(d_colanta2, scrollX = TRUE, theme = "dark", lang = "es")

# Top 10 entidades colanta
cols <- "ent_nombre"
d2 <- d_colanta %>% count_Cat(cols)

# Línea de tiempo contratos número
d3 <- d_colanta %>% 
  count_Cat(c("cont_firma_ano"))
hgch_line_CatNum(d3, opts = list(colors = theme$colors))

# Línea de tiempo contratos valor
d3 <- d_colanta %>% 
  agg_CatNum(c("cont_firma_ano","cont_valor_tot")) %>% 
  arrange(cont_firma_ano) %>% 
  mutate(cont_valor_tot = cont_valor_tot/1000000)
hgch_line_CatNum(d3, opts = list(colors = theme$colors))




# Red Recetta
url <- "https://docs.google.com/spreadsheets/d/18lasGnUT7r_VIa0Qe18af-jACn3axjtuVBni5VerYlc/edit#gid=0"
ss <- gs_url(url)
d <- gs_read_csv(ss)

d1 <- d %>% filter(Empresa == "La Recetta Soluciones Gastronómicas Integradas") %>%
  select(from = personaje1, to = personaje2, label = relacion)

edges <- d1 %>% distinct()
nodes <- tibble(id = unique(c(edges$from, edges$to)))
nodes <- nodes %>% mutate(label = id) %>% filter(!is.na(id))
visNetwork(nodes, edges, width = "100%")


# Contratos Recetta
emp_nit <- 	900213759
d_emp <- d0 %>% filter(contratista_id == emp_nit)
d_emp2 <- rename_with_dic(d_emp, dic)

tableviz_dt(d_emp2, scrollX = TRUE, theme = "dark", lang = "es")

# Top 10 entidades recetta
cols <- "ent_nombre"
d2 <- d_emp %>% count_Cat(cols)

# Línea de tiempo contratos número
d3 <- d_emp %>% 
  count_Cat(c("cont_firma_ano"))
hgch_line_CatNum(d3, opts = list(colors = theme$colors))

# Línea de tiempo contratos valor
d3 <- d_emp %>% 
  agg_CatNum(c("cont_firma_ano","cont_valor_tot")) %>% 
  arrange(cont_firma_ano) %>% 
  mutate(cont_valor_tot = cont_valor_tot/1000000)
hgch_line_CatNum(d3, opts = list(colors = theme$colors))





# Contratos Buenos Aires
emp_nit <- 	800136998	
d_emp <- d0 %>% filter(contratista_id == emp_nit)
d_emp2 <- rename_with_dic(d_emp, dic)

tableviz_dt(d_emp2, scrollX = TRUE, theme = "dark", lang = "es")

# Top 10 entidades buenos aires
cols <- "ent_nombre"
d2 <- d_emp %>% count_Cat(cols)

# Línea de tiempo contratos número
d3 <- d_emp %>% 
  count_Cat(c("cont_firma_ano"))
hgch_line_CatNum(d3, opts = list(colors = theme$colors))

# Línea de tiempo contratos valor
d3 <- d_emp %>% 
  agg_CatNum(c("cont_firma_ano","cont_valor_tot")) %>% 
  arrange(cont_firma_ano) %>% 
  mutate(cont_valor_tot = cont_valor_tot/1000000)
hgch_line_CatNum(d3, opts = list(colors = theme$colors))





# Contratos Nestlé
emp_nit <- 	860002130	
d_emp <- d0 %>% filter(contratista_id == emp_nit)
d_emp2 <- rename_with_dic(d_emp, dic)

tableviz_dt(d_emp2, scrollX = TRUE, theme = "dark", lang = "es")

# Top 10 entidades buenos aires
cols <- "ent_nombre"
d2 <- d_emp %>% count_Cat(cols)

# Línea de tiempo contratos número
d3 <- d_emp %>% 
  count_Cat(c("cont_firma_ano"))
hgch_line_CatNum(d3, opts = list(colors = theme$colors))

# Línea de tiempo contratos valor
d3 <- d_emp %>% 
  agg_CatNum(c("cont_firma_ano","cont_valor_tot")) %>% 
  arrange(cont_firma_ano) %>% 
  mutate(cont_valor_tot = cont_valor_tot/1000000)
hgch_line_CatNum(d3, opts = list(colors = theme$colors))



####  PAE

pae <- read_csv("data/clean/leche-pae.csv")
d_pae <- rename_with_dic(pae, dic)
tableviz_dt(d_pae, scrollX = TRUE, theme = "dark", lang = "es")







