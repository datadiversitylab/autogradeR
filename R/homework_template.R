#' Create a homework template for gradeR
#'
#' This function generates the structure of a basic autograding system.
#' 
#' @param path Where should the sample directory be exported to? 
#' 
#' @export
#' 

homework_template <- function(path){

#Create basic directories
dir.create('tests')
dir.create('data')

#Export sample dataset to data
sample_dataset <- data.frame(A = rnorm(5), b = rnorm(5))
write.csv(sample_dataset, "./data/sample_dataset.csv")

#Generate answer template files

basicAnswers <- "
#'---
#' title: 'Sample HW for gradeR'
#' ---
#'
#' **Objectives**: This is a sample Rmd homework with the basic autograder (from `gradeR`)

#+ Basic packages
library(digest)
library(here)

#' # Question 1
#' Please use `R` to generate a sequence from 1 to 5. Save the resulting vector in `Q1`.

#+ Question 1
# YOUR ANSWER BEGINS HERE
Q1 = c(1:5)
# END OF YOUR ANSWER

#' # Question 2
#' Please use `R` to generate a sequence from 6 to 10. Save the resulting vector in `Q2`.

#+ Question 2
# YOUR ANSWER BEGINS HERE
Q2 = c(6:10)
# END OF YOUR ANSWER


#' # Question 3
#' Please use `R` to read `data/sample_dataset.csv` and save it in `Q3`.

#+ Question 3
# YOUR ANSWER BEGINS HERE
Q3 = read.csv('./data/sample_dataset.csv') 
# END OF YOUR ANSWER


#' # Question 4
#' Please briefly define object-oriented programming. Save your answer under `Q4`.

#+ Question 3
# YOUR ANSWER BEGINS HERE
Q4 = NULL #Replace with NULL
# END OF YOUR ANSWER


#' # Autograder
#'

#+ Autograder
.reference_answers <- list(
          Q1 = list(digest(Q1, algo = 'sha1'), fun = function(x){digest(x, algo = 'sha1')}), # Question 1
          Q2 = list(length(Q2), fun = function(x){length(x)}),                               # Question 2
          Q3 = list(dim(Q3), fun = function(x){dim(x)}),                                     # Question 3
          Q4 = list(Q4, fun = function(x){is.null(x)})                                       # Question 4
)
rm(list = ls())
save.image(here('tests', 'reference_answers.RData'))
"
writeLines(basicAnswers, "./tests/0_ans_temp.R")
knitr::spin("./tests/0_ans_temp.R", format = "Rmd", knit = FALSE)
unlink("./tests/0_ans_temp.R")

}
