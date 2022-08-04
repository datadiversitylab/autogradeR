  <!-- badges: start -->
  [![Codecov test coverage](https://codecov.io/gh/cromanpa94/gradeR/branch/main/graph/badge.svg)](https://codecov.io/gh/cromanpa94/gradeR?branch=main)
  [![R-CMD-check](https://github.com/cromanpa94/gradeR/workflows/R-CMD-check/badge.svg)](https://github.com/cromanpa94/gradeR/actions)
  [![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)  
  [![](https://img.shields.io/github/languages/code-size/cromanpa94/gradeR.svg)](https://github.com/cromanpa94/gradeR)
  [![CodeFactor](https://www.codefactor.io/repository/github/cromanpa94/phruta/badge)](https://www.codefactor.io/repository/github/cromanpa94/gradeR)  <!-- badges: end -->

# The `gradeR` `R` package <a href='https://cromanpa94.github.io/gradeR'><img src='man/figures/logo.png' align="right" height="300" /></a>

### A package to simplify basic grading taks in `R`

`gradeR` is expected to help instructors grade pre-defined assignments using a particular and relatively simple set of functions.

-------------

## Installing `gradeR`

The `gradeR` R package can be installed from GitHub using the code presented below. I expect `gradeR` to be available on CRAN at some point in the future.

```
library(devtools)
install_github("cromanpa94/gradeR")
```

#### Next steps

- [x] Function to create the sample repo

- [x] Function to run the autograder in the readme and homework

- [x] Functions to generate correct solutions to questions 

- [ ] Compile grades and feedback 
    - for a set of folders
    - find feedback files
    - read them and put it into a single string per student.
    - list grades per student
    
- [ ] Push feedback to GitHub repos]
