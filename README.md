# merge.stats

*Note, this is in development and may have a lot of bugs*

**TO DO:**
- Build check so that improper inputs don't run.
- Add warning messages so user know why something isn't working.

This package builds of the `merge()` function from base
R and the joins from `dplyr` (for example `inner_join()`). The function `merge_stats()`
takes the same inputs as `merge()` with an additional input `show.stats`
(default = `TRUE`). It returns a merged dataframe with an
additional variable `merge` which that imitates the `_merge`
variable from STATA. The variable is 1 for only the first dataframe
merging, 2 for only the second dataframe merging, 3 if there's a
perfect merge, and NA if there's an error. If `show.stats = TRUE`
summaries of the merge are printed to screen.

The function `join_stats` does the same, but with an additional arguement `join = ` which specifies the type of join. Options are the
join currently availible for dplyr ("inner", "right", "left", "full", "semi", and "anti").

## Usage:
This package can be installed using `devtools`. with the following lines of
code:
```
# install.packages('devtools') # uncomment line to install devtools
devtools::install_github('newton-c/merge_stats_R')

```
To use, type:
```
library(merge.stats)

merge_stats(x, y, by = c('var1', 'var2'), ...)
merge_join(x, y, by = c('var1', 'var2'), join = "inner" ...)
```
