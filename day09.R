library(tidyverse)
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# unfortunately not my code...
# whoever this was, I consider him as genius

inp <- read.table("input09.txt", sep = " ")


dir <- c("U" = 1i, "D" = -1i, "L" = -1, "R" = 1)
hp <- c(0i, cumsum(unlist(apply(inp, 1, \(x) rep(dir[x[1]], x[2])))))

pos <- matrix(hp, ncol = 10, nrow = length(hp))

for (p in 2:10) {
  for (k in seq_along(hp)[-1]) {
    d <-  pos[k, p - 1] - pos[k - 1, p]
    pos[k, p] <- pos[k - 1, p] + if (abs(d) >= 2) sign(Re(d)) + sign(Im(d))*1i else 0
  }
}

#part1----
length(unique(pos[,2]))

#part2----
length(unique(pos[,10]))
