library(tidyverse)

input = read_delim(file="input01.txt",  skip_empty_rows = F, delim = "\n", col_names =F) |> 
  select(x=1) |> 
  mutate(n= case_when(is.na(x)~row_number())) |> 
  fill(n, .direction = "up") |> 
  filter(!is.na(x))

# teil 1
input |> 
  group_by(n) |> 
  summarise(s=sum(x)) |> 
  ungroup() |> 
  summarise(s=max(s))

#teil 2
input |> 
  group_by(n) |> 
  summarise(s=sum(x)) |> 
  ungroup() |> 
  arrange(desc(s)) |> 
  head(3) |> 
  summarise(s=sum(s))
