library(tidyverse)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

raw = as.matrix(read.fwf("input08.txt", widths = rep(1,99))) |> 
  unname()

zz = nrow(raw)-1
ss = ncol(raw)-1

#teil 1

visible = function(z,s){
  element= raw[z,s]
  links = c()
  rechts = c()
  oben = c()
  unten = c()
  for (jl in 1:(s-1)){
    links = c(links, raw[z, jl])
  }
  for (jr in (s+1):(ss+1)){
    rechts = c(rechts, raw[z, jr])
  }
  for (jo in 1:(z-1)){
    oben = c(oben, raw[jo, s])
  }
  for (ju in (z+1):(zz+1)){
    unten = c(unten, raw[ju, s])
  }
  v = !any(element<=links) | !any(element<=rechts)| !any(element<=oben) |!any(element<=unten)   
  return(v)
}

loesung = crossing(x = 2:zz, y=2:ss) |> 
  mutate(element = raw[cbind(x,y)]) |> 
  mutate(v = map2(.x=x, .y=y, ~visible(.x,.y))) |> 
  unnest(v)

loesung |> 
  summarise(v = sum(v)) |> 
  deframe() + 
  nrow(raw)*2 +
  (nrow(raw)-2)*2

#teil2

view = function(z,s){
  element= raw[z,s]
  zaehler_l = 0
  zaehler_r = 0
  zaehler_o = 0
  zaehler_u = 0
  for (jl in (s-1):1){
    if(raw[z,jl] < element){
      zaehler_l = zaehler_l+1
    } else {
      zaehler_l = zaehler_l+1
      break
    }
  }
  for (jr in (s+1):(ss+1)){
    if(raw[z,jr] < element){
        zaehler_r = zaehler_r + 1
      } else {
        zaehler_r = zaehler_r + 1
        break
      }
  }
  for (jo in (z-1):1){
    if(raw[jo,s] < element){
      zaehler_o = zaehler_o + 1
    } else {
      zaehler_o = zaehler_o + 1
      break
    }
  }
  for (ju in (z+1):(zz+1)){
    if(raw[ju,s] < element){
      zaehler_u = zaehler_u + 1
    } else {
      zaehler_u = zaehler_u + 1
      break
    }
  }
  ergebnis = zaehler_l*zaehler_r*zaehler_o*zaehler_u
  return(ergebnis)
}

loesung = crossing(x = 2:zz, y=2:ss) |> 
  mutate(element = raw[cbind(x,y)]) |> 
  mutate(v = map2(.x=x, .y=y, ~view(.x,.y))) |> 
  unnest(v)

loesung |> 
  arrange(desc(v)) |> 
  head(1) |> 
  select(v) |> 
  deframe()
