library(tidyverse)
library(googlesheets)
library(rlang)
library(mop)

source("comp-helpers.R")

ss <- gs_url("https://docs.google.com/spreadsheets/d/1zuP8O4YLc7OpmCGoFUIq1Yg5sI3Tgf2sj-kMe5OZsKQ/edit#gid=1051008904")
# tabs <- gs_ws_ls(ss)
ids <- gs_read_csv(ss, ws = "files")

vars <- gs_read_csv(ss, ws = "variables")
glimpse(vars)
countries <- ids$iso_code
dics <- map(countries, function(x){
  country <- rlang::sym(x)
  vars %>% select(!!c("ocds_2", "ocds_title", x)) %>% #filter(!is.na(ocds_path)) %>% 
    filter(!is.na(!!country))  %>% mutate(country = !!x) %>%  select( everything(), var_name = !!x)
})
glimpse(dics[[1]])
glimpse(dics[[2]])
glimpse(dics[[3]])

all_dics <- dics %>% bind_rows()

# Variables per country
vars_per_country <- all_dics %>% group_by(country) %>% summarize(n_vars = n())
# Variables across countries
vars_across_countries <- all_dics %>% group_by(ocds_2) %>% 
  summarize(n_vars = n(), countries = paste0(country, collapse = ", ")) %>% 
  arrange(desc(n_vars))

mop::copy_clipboard(vars_across_countries)


## 
gsheets <- transpose(ids) %>% map(safely(function(x){
  #x <- transpose(ids)[[3]]
  message(x$pais)
  ss <- gs_url(x$file)
  gs_read_csv(ss, ws = x$tab, col_types = cols(.default = "c"))
}))
map(gsheets, problems)

errors <- gsheets %>% keep(~{is.null(.$result)})
ds <- gsheets %>% keep(~{!is.null(.$result)}) %>% map("result")


## Rename according to dic
#names(ds[[1]])
#arg <- rename_with_dic(ds[[1]], dics[[1]] %>% select(3,1))

ds_renamed <- map2(ds, dics, ~{rename_with_dic(.x,.y %>% select(3,1))})


walk(seq_along(countries), function(i){
  write_csv(ds_renamed[[i]], paste0("data/original/latam/",countries[i],".csv"))
})

####






