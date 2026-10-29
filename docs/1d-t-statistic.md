# The One-Sample t-Test {#t-statistic}

## One More Function

So far, we have built small functions for the mean, variance, standard deviation, and standard error.

Those pieces can also be used to build a t-statistic. We will build it piece by piece, then check it against R's own t-test.

The basic question is:

<div class="summary-box">
How far is my sample mean from a comparison value, relative to the noise in the sample?
</div>

## A Score Example

We will keep using the same ten values from the last two chapters. Their mean is 50.


``` r
scores <- c(44, 47, 48, 49, 50, 50, 51, 52, 53, 56)
comparison_value <- 49
```

The comparison value is just the value we want to compare the sample against. It could be a scale midpoint, a known benchmark, or a value from a previous study.

We will test the same sample against two different comparison values. First 49, which is close to our sample mean, and later 46, which is further away. Keep an eye on what changes between the two and what stays the same.

## Files For This Chapter

Download the exercise file for this chapter and save it in the same folder as your `my_functions.R`:

- <a href="exercises/1d-t-statistic-exercises.Rmd" download>1d-t-statistic-exercises.Rmd</a>

## Load Your Toolbox

Load the functions you have built so far:


``` r
library(tidyverse)
source("my_functions.R")
```



Check that they still match R before building on them:


``` r
all.equal(my_mean(scores), mean(scores))
all.equal(my_var(scores), var(scores))
all.equal(my_sd(scores), sd(scores))
all.equal(my_se(scores), t.test(scores)$stderr)
```

```
## [1] TRUE
## [1] TRUE
## [1] TRUE
## [1] TRUE
```

Four `TRUE`s and you are ready.

## The Equation

The t-statistic can be written as:

$$
t = \frac{\bar{x} - \mu_0}{s / \sqrt{n}}
$$

Look at the bottom of the fraction. It is the standard error equation from Chapter \@ref(standard-error):

$$
SE = \frac{s}{\sqrt{n}}
$$

So the t-statistic is the difference on top, divided by the standard error underneath:

$$
t = \frac{\overbrace{\bar{x} - \mu_0}^{\text{difference}}}{\underbrace{s / \sqrt{n}}_{\text{standard error}}} = \frac{\bar{x} - \mu_0}{SE}
$$

The two halves of the fraction push t in opposite directions:

- **the numerator:** the bigger the difference between the sample mean and the comparison value, the bigger t is;
- **the denominator:** the bigger the standard error (the amount of spread in sample means), the smaller t is.

So t tells us how big the difference we are interested in is, *after* taking into account how much uncertainty there is from sampling.

With our scores and a comparison value of 49, that is:

$$
t = \frac{50 - 49}{1.05} = 0.95
$$

You already have a function for the bottom of the fraction, `my_se()`, so the t-value needs only one new step: the division.

Read this as:

1. calculate the sample mean;
2. subtract the comparison value;
3. calculate the standard error;
4. divide the difference by the standard error.

## Build The Pieces

Every piece of the equation is something you have already built:


``` r
mean_score <- my_mean(scores)
se_score <- my_se(scores)

c(mean = mean_score, se = se_score)
```

```
##      mean        se 
## 50.000000  1.054093
```

Now put those pieces into the equation yourself. Write one line that subtracts the comparison value from the mean, then divides by the standard error:


``` r
t_value <-
t_value
```


<div class='webex-solution'><button>Show a hint</button>

Use `mean_score`, `comparison_value`, and `se_score`. Put brackets around the top of the fraction, so the subtraction happens before the division.

</div>


To two decimal places, t is <input class='webex-solveme nospaces' size='4' data-answer='["0.95",".95"]'/>.


<div class='webex-solution'><button>Show one solution</button>


``` r
t_value <- (mean_score - comparison_value) / se_score
t_value
```

```
## [1] 0.9486833
```

</div>


The sign of t tells us which side of the comparison value the mean falls on: positive above it, negative below it.

## Your Turn: Write `my_t_value()`

This function has two inputs: the values, `x`, and the comparison value. The recipe is:

1. calculate the sample mean, using `my_mean()`;
2. calculate the standard error, using `my_se()`;
3. subtract the comparison value from the mean, then divide by the standard error.


``` r
my_t_value <- function(x, comparison_value) {
  mean_x <- 
  se_x <- 
  output <- 
  return(output)
}

my_t_value(scores, comparison_value = 49)
```


<div class='webex-solution'><button>Show a hint</button>

The last blank is the same calculation you just wrote by hand, with `mean_x` and `se_x` in place of `mean_score` and `se_score`.

</div>



<div class='webex-solution'><button>Show one solution</button>


``` r
my_t_value <- function(x, comparison_value) {
  mean_x <- my_mean(x)
  se_x <- my_se(x)
  output <- (mean_x - comparison_value) / se_x
  return(output)
}

my_t_value(scores, comparison_value = 49)
```

```
## [1] 0.9486833
```

</div>


This function returns one number, the t-statistic. A full t-test also reports degrees of freedom and a p-value, which we will come to.

The denominator of the t-statistic is the <input class='webex-solveme nospaces' size='14' data-answer='["standard error"]'/>.

## Check It Against `t.test()`

R's version is `t.test()`, from the `stats` package. As with every function so far, we check ours against it. First, look at the full output:


``` r
t.test(scores, mu = comparison_value)
```

```
## 
## 	One Sample t-test
## 
## data:  scores
## t = 0.94868, df = 9, p-value = 0.3676
## alternative hypothesis: true mean is not equal to 49
## 95 percent confidence interval:
##  47.61548 52.38452
## sample estimates:
## mean of x 
##        50
```

The `t` in this output should match our function. To check it with `all.equal()`, we need to pull the t-value out of the result. `t.test()` returns a list of results, and `$statistic` picks out the t-value. That value comes with a label attached (`t`), so `unname()` removes the label and leaves just the number. Otherwise `all.equal()` would report that the names differ, even though the numbers match.


``` r
t_result <- t.test(scores, mu = comparison_value)

c(mine = my_t_value(scores, comparison_value), R = unname(t_result$statistic))
all.equal(my_t_value(scores, comparison_value), unname(t_result$statistic))
```

```
##      mine         R 
## 0.9486833 0.9486833 
## [1] TRUE
```

`TRUE` means your function reproduces the t-value from `t.test()`.

The output also reports degrees of freedom (`df`), a p-value, and a confidence interval. For this one-sample test, `df` is the sample size minus one, the same $n - 1$ as in the variance.

<div class="note">
**What about the p-value?**

You will notice that `t.test()` also reports a p-value. It answers a question we have not asked yet: if there were no real difference, how unusual would a t-value this far from zero be? We will build that ourselves in Chapters \@ref(null-distributions) and \@ref(p-values), in the second part of the book. For now, focus on what the t-value itself tells you.
</div>

## Your Turn: Write `my_t_test()`

Put the pieces together in one function that returns a small table with the t-value and its degrees of freedom:

1. calculate t with `my_t_value()`;
2. calculate the degrees of freedom: the number of values minus one;
3. put both into a table with `tibble()`.


``` r
my_t_test <- function(x, comparison_value) {
  t <- 
  df <- 
  output <- tibble(t = t, df = df)
  return(output)
}

my_t_test(scores, comparison_value = 49)
```


<div class='webex-solution'><button>Show a hint</button>

`t` uses `my_t_value(x, comparison_value)`, and `df` uses `length(x) - 1`.

</div>



<div class='webex-solution'><button>Show one solution</button>


``` r
my_t_test <- function(x, comparison_value) {
  t <- my_t_value(x, comparison_value)
  df <- length(x) - 1
  output <- tibble(t = t, df = df)
  return(output)
}

my_t_test(scores, comparison_value = 49)
```

<div class="kable-table">

|         t| df|
|---------:|--:|
| 0.9486833|  9|

</div>

</div>


## Check It Against `t.test()` Again

`t.test()` keeps the degrees of freedom under the name `parameter`. To check both numbers at once, put R's t and df into a one-row tibble shaped like the one `my_t_test()` returns. As in Chapter \@ref(standard-error), `bind_rows()` stacks the two rows so you can read them side by side, and `all.equal()` compares the whole table:


``` r
my_result <- my_t_test(scores, comparison_value)
r_result <- tibble(
  t = unname(t_result$statistic),
  df = unname(t_result$parameter)
)

bind_rows(mine = my_result, R = r_result, .id = "version")
all.equal(my_result, r_result)
```

<div class="kable-table">

|version |         t| df|
|:-------|---------:|--:|
|mine    | 0.9486833|  9|
|R       | 0.9486833|  9|

</div>

```
## [1] TRUE
```

`TRUE` means your own functions reproduce the t-value and degrees of freedom from `t.test()`.

Our sample mean is 50 and the comparison value is 49. The mean sits 0.95 standard errors above the comparison value.

## A Second Comparison Value

Now test the same sample against 46.


``` r
comparison_value_2 <- 46

my_result_2 <- my_t_test(scores, comparison_value_2)
t_result_2 <- t.test(scores, mu = comparison_value_2)
r_result_2 <- tibble(
  t = unname(t_result_2$statistic),
  df = unname(t_result_2$parameter)
)

bind_rows(mine = my_result_2, R = r_result_2, .id = "version")
all.equal(my_result_2, r_result_2)
```

<div class="kable-table">

|version |        t| df|
|:-------|--------:|--:|
|mine    | 3.794733|  9|
|R       | 3.794733|  9|

</div>

```
## [1] TRUE
```

The sample mean is still 50 and the standard error is still 1.05. The only thing that changed is the comparison value. The difference is now 4 instead of 1, so t is 3.79 instead of 0.95.

| Comparison value | Difference | Standard error | t |
|---|---|---|---|
| 49 | 1 | 1.05 | 0.95 |
| 46 | 4 | 1.05 | 3.79 |

A t-value is the distance between the sample mean and the comparison value, measured in standard errors. A mean that sits nearly four standard errors from the comparison value is much harder to put down to noise than one that sits about one standard error away.

Deciding how far is far enough is the job of p-values. Chapter \@ref(null-distributions) builds the null distribution they need from scratch, and Chapter \@ref(p-values) turns it into p-values.

Which part of the t-statistic changed between the two tests? <select class='webex-select'><option value='blank'></option><option value=''>the standard error</option><option value='answer'>the difference between the sample mean and the comparison value</option><option value=''>the sample size</option></select>

Try a third comparison value: 55. Before running the function, predict the sign of t.


<div class='webex-solution'><button>Show one solution</button>


``` r
my_t_test(scores, comparison_value = 55)
t.test(scores, mu = 55)
```

<div class="kable-table">

|         t| df|
|---------:|--:|
| -4.743417|  9|

</div>

```
## 
## 	One Sample t-test
## 
## data:  scores
## t = -4.7434, df = 9, p-value = 0.001054
## alternative hypothesis: true mean is not equal to 55
## 95 percent confidence interval:
##  47.61548 52.38452
## sample estimates:
## mean of x 
##        50
```
The t-value is negative because our sample mean is below 55.

</div>


## Try It On Real Data

Back to the `sleep` data from Chapter \@ref(standard-error). Did the first drug add any sleep, on average? If it did nothing, the population mean of `extra` would be 0, so 0 is our comparison value. Run your t-test and R's:


``` r
drug_1 <- sleep %>% filter(group == 1) %>% pull(extra)

my_result <- my_t_test(drug_1, comparison_value = 0)
drug_t_result <- t.test(drug_1, mu = 0)
drug_r_result <- tibble(
  t = unname(drug_t_result$statistic),
  df = unname(drug_t_result$parameter)
)

bind_rows(mine = my_result, R = drug_r_result, .id = "version")
all.equal(my_result, drug_r_result)
```

<div class="kable-table">

|version |       t| df|
|:-------|-------:|--:|
|mine    | 1.32571|  9|
|R       | 1.32571|  9|

</div>

```
## [1] TRUE
```

On average, patients slept 0.75 hours more on the first drug, which puts the mean about 1.3 standard errors above 0. Chapter \@ref(p-values) works out whether that is far enough to rule out noise.

## Add To Your Toolbox

<div class="summary-box">
Copy your finished `my_t_value()` and `my_t_test()` into your `my_functions.R` file, under **The One-Sample t-Test** heading, and save it.
</div>

The steps are the same as in Chapter \@ref(equations):

1. Open `my_functions.R` from the **Files** pane.
2. Copy each finished function from your exercise file, from its first line down to its closing `}`, and paste it under **The One-Sample t-Test** heading.
3. Save the file.


<div class='webex-solution'><button>Show what my_functions.R should look like now</button>


``` r
# My statistics functions
#
# Add each function you build to this file, under the heading of the
# chapter you built it in. Later chapters load it with
# source("my_functions.R"), so every function here can be reused.
#
# Keep only the functions in this file. Run and check them in your
# exercise files, not here.
#
# Some functions return a tibble, so load the tidyverse before using them.


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
# my_covariance(), my_correlation() and my_correlation_t() go here



# PART II: TESTING BY SIMULATION ===========================================


# Null Distributions -------------------------------------------------------
# my_null_t() and my_cutoffs() go here



# p-values -----------------------------------------------------------------
# my_sim_p_value() and my_p_value() go here
# (and my_null_correlation_t() if you did the correlation section)



# Effects and Power --------------------------------------------------------
# my_effect_t(), my_power() and my_cohens_d() go here
```

</div>


Then check that the saved file works on its own. This is the last chunk of the exercise file:


``` r
rm(list = ls())
source("my_functions.R")

values <- c(44, 47, 48, 49, 50, 50, 51, 52, 53, 56)
mine <- my_t_test(values, comparison_value = 46)
theirs <- t.test(values, mu = 46)

all.equal(
  c(mine$t, mine$df),
  unname(c(theirs$statistic, theirs$parameter))
)
```

You should see one `TRUE`:

```text
[1] TRUE
```

## Where This Goes Next

You have built a one-sample t-statistic entirely from your own functions:

<div class="summary-box">
values -> mean -> variance -> standard deviation -> standard error -> t
</div>

One t-value tells us about one sample. From here, there are two ways to carry on:

- **Keep building.** The next chapter builds another test statistic from the same pieces. Part I of the book keeps going like this, one statistic at a time.
- **Dip into Part II.** Chapter \@ref(null-distributions) takes the t-value you just built and simulates thousands of samples to find out what "far enough" means, and Chapter \@ref(p-values) turns that into p-values. They only need the chapters you have already done, and you can come back to Part I afterwards.

Either order works. If you are not sure, keep building, and come back to Part II once you have a few test statistics under your belt.
