--- 
title: "Demystifying Functions For Statistics"
author: "Sean Westwood"
date: "2026-09-18"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
description: |
  A short PsyTeachR-style bridge between programming functions and statistical formulas.
biblio-style: apalike
csl: include/apa.csl
---



# Overview {-}

This mini-book is designed for students who have already used functions in R, but still feel that functions and statistical equations are two different languages. The goal is to show that they are the same idea written in different forms.

<div class="summary-box">
In this resource, a statistical formula is treated as a recipe: inputs go in, a process happens, and an output comes back.
</div>

By the end, students should be able to:

- describe a function as **input -> process -> output**;
- recognise arguments, defaults, and returned values;
- translate simple mathematical notation into R code;
- explain summation as repeated addition with `sum()`;
- connect raw values to distributions;
- build a variance function by hand;
- explain standard error as the spread of sample means;
- build small reusable statistics functions from familiar pieces;
- use paired deviations to calculate covariance and correlation;
- connect a correlation test to the t-distribution.

## How To Use This Book

Work through the chapters in order. Type the code yourself when possible, then change the numbers and predict what will happen before running it again.

Use the questions to check your predictions. Open the hints or solutions after you have tried an exercise yourself.
