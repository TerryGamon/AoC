library(tidyverse)
library(janitor)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

input.raw = read_delim(file="input06.txt",  skip_empty_rows = F, delim = "\n", col_names ="x", n_max=8) 



#allgemein (nach teil 2)


position = function(df, anzahl){

result = df |> 
  mutate(a= map(.x=x, ~str_split(.x,""))) |> 
  unnest(a) |> 
  unnest_longer(a) |> 
  mutate(y= str_sub(string = x, start=row_number(), end = row_number()+anzahl-1)) |> 
  filter(nchar(y)==anzahl) |> 
  mutate(nummer = row_number()+anzahl-1) |> 
  mutate(a = map(.x=y, ~str_split(.x,""))) |> 
  unnest(a) |> 
  mutate(d= map(.x=a, ~duplicated(.x))) |> 
  mutate(dd = map(.x= d, ~!any(.x))) |> 
  select(-a,-d) |> 
  unnest(dd) |> 
  filter(dd==TRUE) |> 
  head(1) |> 
  select(nummer) |> 
  deframe()

  return(result)
}

position(input.raw, 4)
position(input.raw, 14)






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
  
#teil 2 und allgemein teil1
input.raw |> 
  mutate(a= map(.x=x, ~str_split(.x,""))) |> 
  unnest(a) |> 
  unnest_longer(a) |> 
  mutate(y= str_sub(string = x, start=row_number(), end = row_number()+13)) |> 
  filter(nchar(y)==14) |> 
  mutate(nummer = row_number()+13) |> 
  mutate(a = map(.x=y, ~str_split(.x,""))) |> 
  unnest(a) |> 
  mutate(d= map(.x=a, ~duplicated(.x))) |> 
  mutate(dd = map(.x= d, ~!any(.x))) |> 
  select(-a,-d) |> 
  unnest(dd) |> 
  filter(dd==TRUE) |> 
  head(1) |> 
  select(nummer) |> 
  deframe()
  



