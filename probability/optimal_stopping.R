# The Interviewing Problem *or* Optimal Stopping

# A sequence of continuous random variables from the same distribution is observed
# one at a time. Immediately after observing one, we may stop and cash out with its value X.
# Or we may discard it and go on to the next one. We must stop by the end.

# GOAL: maximize chance of attaining the maximum output X_max from the given sequence.
# ALT GOAL: maximize our output X. (Is this strategy effectively the same?)
# 
# https://en.wikipedia.org/wiki/Secretary_problem

# First monte carlo GOAL (1)...

#' Return an enum of applicant scores with the given max and count
interview_stream <- function(max_score = 100, num_applicants = 20) {
    candidates <- runif(num_applicants, min = 0, max = max_score)
    #candidates <- sample.int(n = 100, size = 20, replace = F)
    #best <- which.max(candidates)
    return(candidates)
}

#' PARAMETERS
max_score      <- 100
num_applicants <- 20
iters          <- 1000

#' TEST
is_best <- function(scores, selection_idx) {
    return(selection_idx == which.max(scores))
}
    
#' STRATEGIES ----------------------
#' 
#' Select the first greater than X% of of the maximum, or the last
first_gt_X <- function(scores, target = 85) {
    idx <- which(scores > target)[1]
    idx <- ifelse(is.na(idx), num_applicants, idx)
    return(idx)
}

#' Discard first N/e, then pick first higher one
wait_n_ovr_e_until_marriage <- function(scores) {
    mx <- 0
    stop_idx <- round(num_applicants / exp(1))
    for (idx in 1:stop_idx) {
        next_score <- scores[idx]
        if (next_score > mx) {
            mx <- next_score
        }
    }
    selected_idx <- -1
    for (idx in (stop_idx+1):length(scores)) {
        score <- scores[idx]
        if (score > mx) {
            return(idx)
        }
    }
    return(length(scores))
}

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

#' Get the proportion of successes with the given strategy
#' Additional parameters to the input strategy function may be passed in ...
percent_best <- function(strat = first_gt_X, ...) {
    attempts <- c()
    for (i in 1:iters) {
        scores <- interview_stream(max_score, num_applicants)
        attempt <- is_best(scores, strat(scores, ...))
        attempts <- c(attempts, attempt)
    }
    return(sum(attempts)/iters)
}

# Plot success rate against target
targets <- 40:99
perc_bests <- c()
for (target in targets) {
    scores <- interview_stream(max_score, num_applicants)
    perc_bests <- c(perc_bests, percent_best(first_gt_X, target))
}
plot(targets, perc_bests, main="Title", type="l", col='grey')
abline(v = targets[which.max(perc_bests)], col='red')


