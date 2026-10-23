# From Summary Functions To A t-Statistic

## One More Function

So far, we have built small functions for the mean, variance, standard deviation, and standard error.

Those pieces can also be used to build a t-statistic. We will calculate it first, then see how a test uses it.

The basic question is:

<div class="summary-box">
How far is my sample mean from a comparison value, relative to the noise in the sample?
</div>

## A Score Example

Imagine we have a short set of scores:


``` r
scores <- score_values
comparison_value <- 50

scores
#> [1] 48 51 49 54 52 50 53 51
comparison_value
#> [1] 50
```

The comparison value is just the value we want to compare the sample against. It could be a scale midpoint, a known benchmark, or a value from a previous study.

## The Equation

The t-statistic can be written as:

$$
t = \frac{\bar{x} - \mu_0}{s / \sqrt{n}}
$$

Read this as:

1. calculate the sample mean;
2. subtract the comparison value;
3. calculate the standard error;
4. divide the difference by the standard error.

## Build The Pieces


``` r
my_mean <- function(x) {
  return(sum(x) / length(x))
}

my_var <- function(x) {
  return(sum((x - my_mean(x))^2) / (length(x) - 1))
}

my_sd <- function(x) {
  return(sqrt(my_var(x)))
}

my_se <- function(x) {
  return(my_sd(x) / sqrt(length(x)))
}

mean_score <- my_mean(scores)
sd_score <- my_sd(scores)
n <- length(scores)
se_score <- my_se(scores)

mean_score
#> [1] 51
sd_score
#> [1] 2
n
#> [1] 8
se_score
#> [1] 0.7071068
```

Now we can put those pieces into the equation.


``` r
t_value <- (mean_score - comparison_value) / se_score
t_value
#> [1] 1.414214
```

The absolute t-value is larger when the mean is further from the comparison value, holding the standard error fixed. Its sign tells us which side of the comparison value the mean falls on.

## Put It In A Function


``` r
my_t_value <- function(x, comparison_value) {
  mean_x <- my_mean(x)
  se_x <- my_se(x)

  output <- (mean_x - comparison_value) / se_x
  return(output)
}

my_t_value(scores, comparison_value = 50)
#> [1] 1.414214
```

This function returns one number. That number is not the whole test. It is the statistic that the test uses.

The denominator of the t-statistic is the <input class='webex-solveme nospaces' size='14' data-answer='["standard error"]'/>.

Check the hand-built statistic against `t.test()`:


``` r
t.test(scores, mu = comparison_value)
#> 
#> 	One Sample t-test
#> 
#> data:  scores
#> t = 1.4142, df = 7, p-value = 0.2002
#> alternative hypothesis: true mean is not equal to 50
#> 95 percent confidence interval:
#>  49.32796 52.67204
#> sample estimates:
#> mean of x 
#>        51
```

The `t` in this output should match our function. The test also reports degrees of freedom (`df`), a p-value, and a confidence interval. For this one-sample test, `df` is the sample size minus one.

The two-sided p-value is the probability, under the null model, of getting a t-value at least as far from zero as ours in either direction. It is not the probability that the null hypothesis is true. Here the null model says that the population mean equals the comparison value. The usual exact t-test assumes independent observations drawn from a normal population with nonzero variance.



Our sample mean is 51 and the comparison value is 50. The difference is 1.41 estimated standard errors above zero. The two-sided p-value is 0.2. At an alpha of .05, we would not reject this null hypothesis. That does not establish that the population mean is exactly 50.

Try changing the comparison value to 55. Before running the function, predict the sign of t.


<div class='webex-solution'><button>Show one solution</button>


``` r
my_t_value(scores, comparison_value = 55)
#> [1] -5.656854
t.test(scores, mu = 55)
#> 
#> 	One Sample t-test
#> 
#> data:  scores
#> t = -5.6569, df = 7, p-value = 0.000769
#> alternative hypothesis: true mean is not equal to 55
#> 95 percent confidence interval:
#>  49.32796 52.67204
#> sample estimates:
#> mean of x 
#>        51
```
The t-value is negative because our sample mean is below 55.

</div>


## Why Simulate It?

One t-value tells us what happened in one sample.

The next question is what t-values tend to look like if we took lots of samples. This is where simulation helps.

The NHST app lets you draw one sample, see the summary pieces that produced its t-value, then watch that t-value join the growing distribution of t-values.

Try this sequence:

1. Click **Sample null once**.
2. Look at the current sample and its mean, variance, SD, SE, and t-value.
3. Look at where that single t-value lands on the t-axis.
4. Repeat a few times before running a null batch.
5. Click **Sample true population once** and compare the new t-value with the null values already on the axis.
6. Run a true-population batch and look at how much the generated distribution overlaps with the null t distribution.

The important link is:

<div class="summary-box">
sample values -> summary pieces -> one t-value -> long-run t distribution
</div>
