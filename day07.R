library(tidyverse)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

input.raw = read_delim(file="input07.txt", delim="\n", col_names = c("x")) 
ergebnis =
  input.raw |> 
  mutate(pfad=" ") |> 
  slice(2:nrow(input.raw)) |> 
  mutate(x= str_remove(string= x,pattern = "\\$ ")) |> 
  filter(x!="ls") |> 
  mutate(size = str_extract(x,"\\d+"),
         size=as.numeric(size))

pfad = "root"
for (i in 1:nrow(ergebnis)){
  up = FALSE
  zeile = ergebnis$x[i]
  if (grepl("cd \\.\\.", zeile)){
     up = TRUE
     pfad = paste0(unlist(strsplit(pfad,'/'))[1:(length(unlist(strsplit(pfad, '/')))-1)], collapse='/')
  }
  if ((grepl("cd ", zeile)==TRUE) & (up == FALSE)){
      pfad = paste0(pfad, "/", gsub(pattern = "cd ", x= zeile, replacement = ""))
  }
  ergebnis$pfad[i] = pfad
}

splitten = function(i){
  l = length(unlist(strsplit(i, '/')))
  
  e= c()
  for (x in 1:l-1){
    a = paste0(unlist(strsplit(i,'/'))[1:(length(unlist(strsplit(i, '/')))-x)], collapse='/')
    e= c(e,a)
  }
  return(e)
}

struktur = ergebnis |> 
  filter(!str_detect(x,"cd ") | !is.na(size)) |> 
  filter(!str_detect(x,"dir ") | !is.na(size))

zusammenfassung = 
  struktur |> 
  mutate(d = map(.x=pfad, ~splitten(.x))) |> 
  unnest(d) |> 
  group_by(d) |> 
  summarise(size=sum(size)) |> 
  ungroup() 

#teil 1

zusammenfassung |> 
  filter(size<100000) |> 
  summarise(size=sum(size))

#teil 2

gebraucht = -(70000000 - (zusammenfassung |> filter(d == "root") |> select(size) |> deframe()) - 30000000)

zusammenfassung |> 
  filter(size>gebraucht) |> 
  arrange(size) |> 
  head(1) |> 
  select(size) |> 
  deframe()
