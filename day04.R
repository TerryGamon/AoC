library(tidyverse)

#wd <- dirname(rstudioapi::getSourceEditorContext()$path)
#setwd(wd)

input.raw = read_delim(file="input04.txt", delim="\n", col_names = c("input")) 


#teil 1 - alternativc

loesung = input.raw|>
  mutate(nummer = row_number()) |> 
  separate(col = "input",  into=c("xa", "xb", "ya","yb")) |> 
  mutate(across(!starts_with("nummer"),~as.numeric(.x))) |> 
  mutate(l = pmin((xb-xa+1),(yb-ya+1))) |>
  mutate(za = map2(.x=xa, .y=xb, ~.x:.y)) |> 
  mutate(zb = map2(.x=ya, .y=yb, ~.x:.y)) |> 
  mutate(z = map2(.x=za, .y=zb, ~intersect(.x, .y))) |> 
  mutate(nr = map(.x=z, ~length(.x))) |>
  unnest(nr) |> 
  mutate(c = l ==nr) |> 
  print()

loesung |> summarise(c=sum(c))  

#teil 1 - alternativc


input.raw|>
  separate(col = "input",  into=c("xa", "xb", "ya","yb")) |> 
  mutate(across(everything(), ~as.numeric(.x))) |> 
  mutate( c = (xa>=ya & xb<=yb) | (ya>=xa & yb<=xb)) |> 
  summarise(c = sum(c))

#teil 2

loesung = input.raw|>
  separate(col = "input",  into=c("xa", "xb", "ya","yb")) |> 
  mutate(across(everything(), ~as.numeric(.x))) |> 
  mutate(c=(ya<=xb)&(xa<=yb)) |> 
  summarise(c = sum(c)) |> 
  print()







  