library(tidyverse)

input = read_delim(file="input02.txt",  skip_empty_rows = F, delim = "\n", col_names ="x") |> 
  separate(x, into=c("elves","me"), sep=" ")

table=
tibble::tribble(
  ~elves, ~me,      ~name, ~punkte,
     "A", "X",     "Rock", 1L,
     "B", "Y",    "Paper", 2L,
     "C", "Z", "Scissors", 3L
  )

ergebnis=
crossing(table |> select(elves), table |> select(me2=elves)) |> 
  mutate(win = case_when(elves==me2 ~ 3,
                         elves =="A" & me2== "B" ~6,
                         elves =="B" & me2== "C" ~6,
                         elves =="C" & me2== "A" ~6,
                         TRUE ~ 0)) |> 
  left_join(table |> select(me2=elves, me, punkte), by="me2") |> 
  select(elves, me, win, punkte) 

#part1
input |> 
  left_join(ergebnis, by= c("elves", "me")) |> 
  mutate(ges= win + punkte) |> 
  summarise(ges=sum(ges)) 

#part2
wl = 
  tibble::tribble(
    ~res, ~p,
    "X", 0L,
    "Y", 3L,
    "Z", 6L)

input |> 
  left_join(wl, by=c("me"="res")) |> 
  select(-me) |> 
  left_join(ergebnis |> select(me, elves, p=win), by=c("elves","p")) |> 
  left_join(table |> select(me, punkte)) |> 
  mutate(ges= p + punkte) |> 
  summarise(ges=sum(ges)) 
