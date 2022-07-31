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
file.copy(system.file("extdata", "answers_template.Rmd", package = "gradeR"), "./tests/1_answers_template.Rmd")

## Render answers_template.Rmd
rmarkdown::render("./tests/1_answers_template.Rmd")
## Keep only the workspace and Rmd
unlink("./tests/1_answers_template_modify.html")
## Create a full version of the Rmd with the autograder
mdFile <- readLines("./tests/1_answers_template.Rmd")
##Remove the rm(list = ls()) line
mdFile <- mdFile[-grep("rm(list = ls())", mdFile, fixed = TRUE)]
##Add basic autograder
autg <- c("",
          "```{r gradeR}",
          "student_answers_test <- list(Q1 = Q1, Q2 = Q2, Q3 = Q3, Q4 = Q4)",
          ".gradeR(student_answers = student_answers_test, reference_answers = .reference_answers)",
          "rm(list = ls())",
          "save.image('reference_answers.RData')",
          "```",
          "")
mdFile <- c(mdFile, autg)
writeLines(mdFile, "./tests/1_answers_template.Rmd")
rmarkdown::render("./tests/1_answers_template.Rmd")
Sys.sleep(1)

}
