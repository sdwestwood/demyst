# Reference versions of the functions students build in each chapter.
# Chapters from "Spread and Standard Error" onwards load this file so
# they can reuse earlier functions without redefining them. Students keep
# their own versions in exercises/my_functions.R, under the same headings.


# PART I: BUILDING TEST STATISTICS =========================================


# From Equations to Code ---------------------------------------------------

my_mean <- function(x) {
  total <- sum(x)
  n <- length(x)
  output <- total / n
  return(output)
}

my_var <- function(x) {
  n <- length(x)
  mean_x <- my_mean(x)
  squared_distances <- (x - mean_x)^2
  total_squared_distance <- sum(squared_distances)

  output <- total_squared_distance / (n - 1)
  return(output)
}


# Spread and Standard Error ------------------------------------------------

my_sd <- function(x) {
  output <- sqrt(my_var(x))
  return(output)
}

my_se <- function(x) {
  n <- length(x)
  sd_x <- my_sd(x)
  output <- sd_x / sqrt(n)
  return(output)
}

my_summary <- function(x) {
  output <- tibble(
    n = length(x),
    mean = my_mean(x),
    variance = my_var(x),
    sd = my_sd(x),
    se = my_se(x)
  )
  return(output)
}

my_z_score <- function(x) {
  mean_x <- my_mean(x)
  sd_x <- my_sd(x)
  output <- (x - mean_x) / sd_x
  return(output)
}


# The One-Sample t-Test ----------------------------------------------------

my_t_value <- function(x, comparison_value) {
  mean_x <- my_mean(x)
  se_x <- my_se(x)
  output <- (mean_x - comparison_value) / se_x
  return(output)
}

my_t_test <- function(x, comparison_value) {
  t <- my_t_value(x, comparison_value)
  df <- length(x) - 1
  output <- tibble(t = t, df = df)
  return(output)
}


# Covariance and Correlation -----------------------------------------------

my_covariance <- function(x, y) {
  dx <- x - my_mean(x)
  dy <- y - my_mean(y)
  products <- dx * dy
  output <- sum(products) / (length(x) - 1)
  return(output)
}

my_correlation <- function(x, y) {
  covariance <- my_covariance(x, y)
  sd_x <- my_sd(x)
  sd_y <- my_sd(y)
  output <- covariance / (sd_x * sd_y)
  return(output)
}

my_correlation_t <- function(x, y) {
  r <- my_correlation(x, y)
  n <- length(x)
  output <- r * sqrt((n - 2) / (1 - r^2))
  return(output)
}


# PART II: TESTING BY SIMULATION ===========================================


# Null Distributions -------------------------------------------------------

my_null_t <- function(n, pop_mean, pop_sd) {
  sample_values <- rnorm(n = n, mean = pop_mean, sd = pop_sd)
  output <- my_t_value(sample_values, comparison_value = pop_mean)
  return(output)
}

my_cutoffs <- function(null_ts, alpha = 0.05) {
  sorted <- sort(null_ts)
  n <- length(sorted)
  k <- floor(n * alpha / 2)
  lower <- sorted[k + 1]
  upper <- sorted[n - k]
  output <- c(lower, upper)
  return(output)
}


# p-values -----------------------------------------------------------------

my_sim_p_value <- function(t, null_ts) {
  as_extreme <- abs(null_ts) >= abs(t)
  output <- my_mean(as_extreme)
  return(output)
}

my_p_value <- function(t, df) {
  lower_tail <- pt(-abs(t), df)
  output <- 2 * lower_tail
  return(output)
}

# Bonus: correlation
my_null_correlation_t <- function(x) {
  null_y <- rnorm(length(x))
  output <- my_correlation_t(x, null_y)
  return(output)
}


# Effects and Power --------------------------------------------------------

my_effect_t <- function(n, pop_mean, pop_sd, comparison_value) {
  sample_values <- rnorm(n = n, mean = pop_mean, sd = pop_sd)
  output <- my_t_value(sample_values, comparison_value)
  return(output)
}

my_power <- function(ts, cutoffs) {
  past <- ts < cutoffs[1] | ts > cutoffs[2]
  output <- my_mean(past)
  return(output)
}

my_cohens_d <- function(x, comparison_value) {
  mean_x <- my_mean(x)
  sd_x <- my_sd(x)
  output <- (mean_x - comparison_value) / sd_x
  return(output)
}
