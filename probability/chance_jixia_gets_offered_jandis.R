# Jandis Barov

heroes = seq(1,24)
jandis = 1

draw <- function() {
    choices = sample(heroes, 4, replace=F)
    return(jandis %in% choices)
}
N = 10000
results = sapply(seq(N), FUN = function(x) {draw()})
