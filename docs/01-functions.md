# Functions As Machines

## The Core Idea

You have already used many functions in R. You may have typed code like `mean(x)`, `sd(x)`, or `summary(x)`. These can feel like magic boxes: you put something in, R thinks for a moment, and an answer appears.

For this book, we will make the box less mysterious.

<div class="summary-box">
A function takes an <strong>input</strong>, applies a <strong>process</strong>, and returns an <strong>output</strong>.
</div>

That is also what a statistical formula does. It takes values, performs operations on those values, and gives you a result.

## A Tiny Function

Here is a small function that adds two numbers.


``` r
add_func <- function(a, b) {
  output <- a + b
  return(output)
}

add_func(2, 5)
#> [1] 7
```

Read it as a sentence:

- the inputs are `a` and `b`;
- the process is `a + b`;
- the output is returned with `return()`.

This is deliberately small. Before we use functions for statistics, we need to see the basic shape.

What is the output of `add_func(4, 6)`? <input class='webex-solveme nospaces' size='2' data-answer='["10"]'/>

## Your Turn: Multiply

Write a function called `multiply_func()` that returns the product of `a` and `b`.


``` r
multiply_func <- function(a, b) {
  output <- 
  return(output)
}

multiply_func(2, 5)
```


<div class='webex-solution'><button>Show one solution</button>


``` r
multiply_func <- function(a, b) {
  output <- a * b
  return(output)
}

multiply_func(2, 5)
#> [1] 10
```

</div>


## Defaults

Sometimes we want a function to use a sensible value unless we tell it otherwise. These are called default arguments.


``` r
subtract_func <- function(a = 5, b = 3) {
  return(a - b)
}

subtract_func()
#> [1] 2
subtract_func(a = 10, b = 5)
#> [1] 5
```

When we run `subtract_func()` without giving it values, R uses `a = 5` and `b = 3`.

The default value of `b` in `subtract_func()` is <input class='webex-solveme nospaces' size='1' data-answer='["3"]'/>.

## Data Frames As Inputs

Functions do not have to take single numbers. They can also take vectors, data frames, and columns from data frames.

We will use this simple data frame throughout the book:


``` r
demo_scores
```

<div class="kable-table">

| participant|condition | score|
|-----------:|:---------|-----:|
|           1|practice  |    48|
|           2|practice  |    51|
|           3|practice  |    49|
|           4|practice  |    54|
|           5|test      |    52|
|           6|test      |    50|
|           7|test      |    53|
|           8|test      |    51|

</div>

Here is a function that takes a data frame and adds a new score column with `mutate()`.


``` r
add_points <- function(df, points) {
  output <- mutate(df, adjusted_score = score + points)
  return(output)
}

add_points(demo_scores, points = 2)
```

<div class="kable-table">

| participant|condition | score| adjusted_score|
|-----------:|:---------|-----:|--------------:|
|           1|practice  |    48|             50|
|           2|practice  |    51|             53|
|           3|practice  |    49|             51|
|           4|practice  |    54|             56|
|           5|test      |    52|             54|
|           6|test      |    50|             52|
|           7|test      |    53|             55|
|           8|test      |    51|             53|

</div>

This uses the same idea as the first example. The only difference is that the addition happens to a column in a data frame.

## A Function With A Default Data Frame

Now we will build a function that:

- takes a data frame and a number;
- adds that number to the `score` column;
- returns a copy of the changed data frame.


``` r
add_points <- function(df = demo_scores, points = 2) {
  output <- mutate(df, adjusted_score = score + points)
  return(output)
}

add_points()
```

<div class="kable-table">

| participant|condition | score| adjusted_score|
|-----------:|:---------|-----:|--------------:|
|           1|practice  |    48|             50|
|           2|practice  |    51|             53|
|           3|practice  |    49|             51|
|           4|practice  |    54|             56|
|           5|test      |    52|             54|
|           6|test      |    50|             52|
|           7|test      |    53|             55|
|           8|test      |    51|             53|

</div>

If the function worked, the first adjusted score should be 50.

The first adjusted score is <input class='webex-solveme nospaces' size='2' data-answer='["50"]'/>.

## Conditionals

A conditional tells R to do something only **if** a condition is true.


``` r
score <- 54
pass_mark <- 50

if (score >= pass_mark) {
  result <- "at or above the pass mark"
}

result
#> [1] "at or above the pass mark"
```

The condition was true because `score` was greater than or equal to `pass_mark`.

Which operator means "greater than or equal to" in R? <select class='webex-select'><option value='blank'></option><option value=''>></option><option value='answer'>>=</option><option value=''>%in%</option></select>

## Repeated Arithmetic

A useful thing about R is that it can repeat simple arithmetic across a whole vector.

Here we add 1 to every score:


``` r
score_values
#> [1] 48 51 49 54 52 50 53 51
score_values + 1
#> [1] 49 52 50 55 53 51 54 52
```

R does the same operation to each value in the vector. Later, this will help us unpack statistical formulas one step at a time.

## Bringing The Tools Together

The next chapter uses these tools to translate a statistical equation into R.

The pattern will stay the same:

1. Identify the inputs.
2. Write down the process.
3. Return the output.
