#' Create a homework template for gradeR
#'
#' This function generates the structure of a basic autograding system.
#' 
#' @param path Where should the sample directory be exported to? 
#' 
#' @importFrom rmarkdown render
#' 
#' @export
#' 

assignment.template <- function(path = "."){
  
  mainDir <- getwd()
  subDir <- file.path(mainDir, path)
  
  #Create directory if it doesn't exist
  if (!path %in% list.dirs()) {
    cat("Files will be saved to a new directory:", subDir)
    dir.create(file.path(subDir), showWarnings = FALSE)
  }else{
    cat("Files will be saved to:", subDir)
    }
  
  #Create basic directories
  dir.create(file.path(subDir, 'tests'), showWarnings = FALSE)
  dir.create(file.path(subDir, 'data'), showWarnings = FALSE)
  
  #Export sample dataset to data
  file.copy(system.file("extdata", "sample_dataset.csv", package = "gradeR"), file.path(subDir, "data/sample_dataset.csv"), overwrite = TRUE)
  
  #Generate answer template and readme files
  file.copy(system.file("extdata", "answers_template.Rmd", package = "gradeR"), file.path(subDir, "tests/0_answers_template_original.Rmd"), overwrite = TRUE)
  file.copy(system.file("extdata", "answers_template.Rmd", package = "gradeR"), file.path(subDir, "tests/1_answers_template.Rmd"), overwrite = TRUE)
  file.copy(system.file("extdata", "README.Rmd", package = "gradeR"), file.path(subDir, "README.Rmd"), overwrite = TRUE)
  
  ## Render answers_template.Rmd
  rmarkdown::render(file.path(subDir, "tests/1_answers_template.Rmd"), envir = new.env(), quiet = TRUE)
  ## Create a full version of the Rmd with the autograder
  mdFile <- readLines(file.path(subDir, "tests/1_answers_template.Rmd"))
  ##Remove the rm(list = ls()) line
  mdFile <- mdFile[-grep("rm(list = ls())", mdFile, fixed = TRUE)]
  ##Add basic autograder
  autg <- c("",
            "```{r gradeR}",
            "student_answers_test <- list(Q1 = Q1, Q2 = Q2, Q3 = Q3, Q4 = Q4)",
            "gradeR(student_answers = student_answers_test, reference_answers = .reference_answers)",
            "rm(list = ls())",
            "save.image('reference_answers.RData', safe = TRUE)",
            "```",
            "")
  mdFile <- c(mdFile, autg)
  writeLines(mdFile, file.path(subDir, "tests/1_answers_template.Rmd"))
  rmarkdown::render(file.path(subDir, "tests/1_answers_template.Rmd"), quiet = TRUE)
}
