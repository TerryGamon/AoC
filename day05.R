library(tidyverse)

setwd("K:/AM/GFI/wkamyg/r/_test_techniken/adventofcode/05")


input.raw = read_delim(file="input.txt",  skip_empty_rows = F, delim = "\n", col_names ="x", n_max=8) 
input = input.raw |> 
  mutate(x= str_replace_all(x, pattern = "    ", replacement = " [x] ")) |> 
  mutate(x = str_replace_all(x, pattern = " ", replacement="")) |> 
  mutate(x = str_replace_all(x, pattern = "[[:punct:]]", replacement="")) |> 
  mutate(c = map(.x=x, ~str_split(.x, ""))) |> 
  unnest(c) |> 
  unnest_wider(c, names_sep = "_") |> 
  select(-x) |>
  t() |> 
  as_tibble() %>% 
  select(order(colnames(.), decreasing = TRUE)) |> 
  unite(col = "c", sep="") |> 
  mutate(c= str_remove_all(c,pattern = "x")) |> 
  deframe() |> 
  print()
  
instructions.raw = read_delim(file="input.txt",  skip_empty_rows = F, delim = "\n", col_names ="x", skip = 10) 
instructions = instructions.raw |> 
  mutate(step = row_number()) |> 
  separate(col = "x", into = c("t1", "anzahl", "t2","von", "t3","nach"), convert = T) |>
  select(-starts_with("t")) |> 
  relocate(step) |> 
  print()

crates = input  
for (i in 1:nrow(instructions)){
  von = crates[instructions$von[i]]
  nach = crates[instructions$nach[i]]
  anzahl = instructions$anzahl[i]
  was = str_sub(string = von, start = nchar(von)+1-anzahl, end= nchar(von))
  was_rev = stringi::stri_reverse(was)
  alt = str_sub(string = von, start=1, end= nchar(von)-anzahl)
  neu = paste0(nach, was_rev) 
  crates[instructions$von[i]] = alt
  crates[instructions$nach[i]] = neu
}

crates |> 
  as_tibble() |> 
  mutate(value = str_sub(string=value, start=nchar(value), end= nchar(value))) |> 
  deframe() |>
  paste(collapse = "")

#teil 2
crates = input  
for (i in 1:nrow(instructions)){
  von = crates[instructions$von[i]]
  nach = crates[instructions$nach[i]]
  anzahl = instructions$anzahl[i]
  was = str_sub(string = von, start = nchar(von)+1-anzahl, end= nchar(von))
  alt = str_sub(string = von, start=1, end= nchar(von)-anzahl)
  neu = paste0(nach, was) 
  crates[instructions$von[i]] = alt
  crates[instructions$nach[i]] = neu
}

crates |> 
  as_tibble() |> 
  mutate(value = str_sub(string=value, start=nchar(value), end= nchar(value))) |> 
  deframe() |>
  paste(collapse = "")


















stacks <- read.fwf('input.txt', widths = rep(4, 9), n = 8) 
stacks[,] <- lapply(stacks, trimws) # remove leading/trailing  whitespaces

stacks[,] <- lapply(stacks, function(x) gsub("\\]|\\[", "", x)) # remove braces
stacks <- as.list(stacks) # convert to list from data.frame
stacks <- lapply(stacks, function(x) Filter(function(y) y!="", x)) # remove empty positions
stacks2 <- stacks # create a copy for part 2 


# read instructions as a table
inst <- read.table('input.txt', skip = 10)[, c(2, 4, 6)]
names(inst) <- c('move', 'from', 'target') # update names

#for(i in 1:3){
for(i in 1:nrow(inst)){  

    move <- inst$move[i]
  from <- inst$from[i]
  target <- inst$target[i]
  
  # move one by one
  for(j in seq_len(move)){
    stacks[[target]] <- c(stacks[[from]][1], stacks[[target]])
    stacks[[from]] <- stacks[[from]][-1]
  }
  
}
# Part 1
paste(sapply(stacks, `[`, 1), collapse = "")


# Part 2
for(i in 1:nrow(inst)){
  
  move <- inst$move[i]
  from <- inst$from[i]
  target <- inst$target[i]
  
  # move all together
  stacks2[[target]] <- c(stacks2[[from]][seq_len(move)], stacks2[[target]])
  stacks2[[from]] <- stacks2[[from]][-c(seq_len(move))]
  
}

paste(sapply(stacks2, `[`, 1), collapse = "")
