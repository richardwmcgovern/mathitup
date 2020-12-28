# 5 randomly sampled points from a large enough population
# has range containing population median 93% of the time

median <- function(x) {
    x.sorted <- sort(x)
    x.len <- length(x)
    if (x.len %% 2 == 1) {
        x.sorted[ceiling(x.len / 2)]
    } else {
        (x.sorted[x.len / 2] + x.sorted[x.len / 2 + 1]) / 2   
    }
}

median_in_range <- function(samp, data) {
    data.med <- median(data)
    data.med > min(samp) && data.med < max(samp)
}

pop <- runif(1000, min = 4.5, max = 6.5)

trial <- function(pop) {
    samp <- sample(pop, 5)
    median_in_range(samp, pop)
}

trials.100 <- sapply(seq(100), FUN = function(x) {trial(pop)})
sum(trials.100) / 100


