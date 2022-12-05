library(janitor)
library(tidyverse)
library(lubridate)
library(here)
library(paletteer)

#wd <- dirname(rstudioapi::getSourceEditorContext()$path)
#setwd(wd)

input.raw = read_delim(file="input03.txt", delim="\n", col_names = "i")


#teil 1
loesung = input.raw |> 
  mutate(a = str_sub(i, start=1, end=nchar(i)/2),
         b = str_sub(i, start = nchar(i)/2+1, end = nchar(i))) |> 
  mutate(aa = str_split(a, pattern = "")) |> 
  mutate(bb = str_split(b, pattern = "")) |> 
  mutate(z = map2(.x=aa, .y=bb, ~intersect(.x, .y))) |> 
  mutate(z1 = map(.x=z, ~which(c(letters, LETTERS) == .x))) |> 
  unnest(z1)

loesung |> 
  summarise(z1=sum(z1))

#teil 2
loesung = input.raw |> 
  mutate(platz = floor((row_number()-1) / 3)+1) |> 
  mutate(gruppe = letters[((row_number()-1) %% 3)+1]) |> 
  pivot_wider(names_from = "gruppe", values_from = "i") |> 
  select(-platz) |> 
  mutate(across(cols = everything(), .fns = ~str_split(.x, pattern = ""))) |> 
  mutate(x = map2(.x=a, .y=b, ~intersect(.x,.y))) |> 
  mutate(z = map2(.x=x, .y=c, ~intersect(.x,.y))) |> 
  mutate(z1 = map(.x=z, ~which(c(letters, LETTERS) ==.x))) |> 
  unnest(z1)

loesung |> 
  summarise(z1=sum(z1))
