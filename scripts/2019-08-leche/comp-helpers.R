
rename_with_dic <- function(x, dic){
  not_names <- which_not_in(names(x),dic[[1]])
  message("Variables not in dictionary: ", paste0(not_names, collapse = ", "))
  names(x) <- mop::match_replace(names(x), dic, force = FALSE)
  x
}

is_repeated <- function(df, cols = NULL, keep_all = TRUE){
  if(!is.null(cols) && !keep_all)
    df <- df %>% select(one_of(cols))
  groups <- match(cols, names(df))
  df %>% 
    group_by_at(groups) %>% 
    filter(n()>1) %>% 
    ungroup()
}


count_Cat <-function(df, cols = NULL) {
  if(!is.null(cols))
    df <- df %>% select(one_of(cols))
  df %>%
    group_by_at(1) %>%
    summarise(total = n()) %>% 
    arrange(desc(total)) %>% 
    ungroup()
}

count_CatCat <-function(df, cols = NULL) {
  if(!is.null(cols))
    df <- df %>% select(one_of(cols))
  df %>%   
    group_by_at(c(1,2)) %>%
    summarise(total = n()) %>% 
    arrange(desc(total)) %>% 
    ungroup()
}

agg_CatNum <- function(df, cols = NULL, agg = "sum"){
  if(!is.null(cols))
    df <- df %>% select(one_of(cols))
  if(agg == "sum")
    f <- function(x) sum(x, na.rm = TRUE)
  var_summary <- names(df)[2]
  df %>%   
    group_by_at(c(1)) %>%
    summarise_at(vars(one_of(var_summary)), f) %>% 
    arrange(desc(!!sym(var_summary))) %>% 
    ungroup()
}


agg_CatCatNum <- function(df, cols = NULL, agg = "sum"){
  if(!is.null(cols))
    df <- df %>% select(one_of(cols))
  if(agg == "sum")
    f <- function(x) sum(x, na.rm = TRUE)
  var_summary <- names(df)[3]
  df %>%   
    group_by_at(c(1,2)) %>%
    summarise_at(vars(one_of(var_summary)), f) %>% 
    arrange(desc(!!sym(var_summary))) %>% 
    ungroup()
}


