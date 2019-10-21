library(tidyverse)

files <- list.files("data/original/latam", full.names = TRUE)
countries <- tools::file_path_sans_ext(basename(files))

vars <- c("awards/suppliers/name", "buyer/name", "contracts/description", 
          "contracts/period/startDate", "contracts/value/amount", "tender/procurementMethod", 
          "contracts/documents/url", "contracts/items/quantity", "contracts/period/startDate/Year",
          "contracts/items/classification/scheme", "contracts/items/unit/value/amount",
          "contracts/value/currency", "tender/id")

ds <- map(files, function(x){
  read_csv(x, col_types = cols(.default = "c")) %>% select(one_of(vars))
}) %>% set_names(countries)


dss <- ds %>%  bind_rows(.id = "countries")
write_csv(dss, "data/original/leche-latam.csv")
