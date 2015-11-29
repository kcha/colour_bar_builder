# Colour Bar Creator App

A Shiny app that generates custom colour bars. 

The R code to plot colour bars was adapted from [here](http://www.colbyimaging.com/wiki/statistics/color-bars).
The colour picker input panel is from [shinyjs](https://github.com/daattali/shinyjs).

Demo: 

To start the app on your local machine, `RColorBrewer` and `shinyjs` needs to be
installed first, if not already:
```r
install.packages("shinyjs")
install.packages("RColorBrewer")
```

Then to start the app:
```r
shiny::runGitHub('colour_bar_creator', 'kcha')
```
