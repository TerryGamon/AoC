library(tidyverse)
library(janitor)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

input.raw = read_delim(file="input06.txt",  skip_empty_rows = F, delim = "\n", col_names ="x") 



#allgemein (nach teil 2)


position = function(dff, anzahl){

result = 1:(nchar(dff)-anzahl+1) |>
  as_tibble() |>
  select(nummer = 1) |> 
  mutate(y= str_sub(string = dff, start=row_number(), end = row_number()+anzahl-1)) |> 
  filter(nchar(y)==anzahl) |> 
  mutate(nummer = row_number()+anzahl-1) |> 
  mutate(a = map(.x=y, ~str_split(.x,""))) |> 
  unnest(a) |> 
  mutate(d= map(.x=a, ~duplicated(.x))) |> 
  mutate(dd = map(.x= d, ~!any(.x))) |> 
  filter(dd==TRUE) |> 
  head(1) |> 
  select(nummer) |> 
  deframe() 

  return(result)
}

position(input.raw |> deframe(), 4)
position(input.raw |> deframe(), 14)



#teil 1 ursprünglich
input.raw |> 
  mutate(a= map(.x=x, ~str_split(.x,""))) |> 
  unnest(a) |> 
  unnest_longer(a) |> 
  select(-x) |> 
  mutate(b = lead(a,1)) |> 
  mutate(c = lead(a,2)) |> 
  mutate(d = lead(a,3)) |> 
  mutate(l = !(a==b|a==c|a==d|b==c|b==d|c==d)) |> 
  mutate(z = ifelse(l,row_number()+3,0)) |> 
  filter(z!=0) |> 
  head(1) |> 
  select(z) |> 
  deframe()
  
