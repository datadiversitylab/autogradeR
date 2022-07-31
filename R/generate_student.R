#' Generate student's and full version of the homework
#' 
#' This function takes a pre-defined HW template and generates a full
#' homework with an autograding system
#' 
#' @importFrom rmarkdown render
#' @importFrom digest digest
#' 
#' @export

generate_student <- function(){

  instructor_copy <- readLines("./tests/1_answers_template.Rmd")
  
  after_autograder <- which(instructor_copy == "# Autograder")
  
  #Find questions (before the autograder)
  targetLines <- grep("([A-Z][1-9] = )", instructor_copy)
  targetLines <- targetLines[which(targetLines < after_autograder)]
  
  for (i in seq_along(targetLines)){
    new_repacement <- paste0("Q", i, " = NULL #Replace with your final answer")
    instructor_copy[targetLines[i]] <- new_repacement
  }
  
  ##Remove sample autograder in the template
  toDel1 <- which(instructor_copy ==  "```{r Autograder}" )
  toDel2 <- which(instructor_copy ==  "```{r gradeR}"  )-1
  instructor_copy <- instructor_copy[-c(toDel1:toDel2)]
  
  ##Remove traces of the testing autograder
  toDel3 <- which(instructor_copy ==  "rm(list = ls())" )
  toDel4 <- which(instructor_copy ==  "save.image('reference_answers.RData')")
  instructor_copy <- instructor_copy[-c(toDel3, toDel4)]
  
  ##Add reference answers line
  AddDs <- "load('tests/reference_answers.RData')"
  toIns <- which(instructor_copy == "```{r gradeR}")
  toRet <- which(instructor_copy == "rm(list = ls())")
  instructor_copy <- c(instructor_copy[c(1:toIns)], AddDs, instructor_copy[c((toIns+1):length(instructor_copy))]) 
  
  AddDs2 <- c("", "```{r render README}", 
              "save.image('tests/reference_answers.RData')",
              "rmarkdown::render('README.Rmd', quiet = T)",
              "```")
  
  instructor_copy <- c(instructor_copy, AddDs2)
  writeLines(instructor_copy, "0_Homework.Rmd")
  
  
  ## Edit readme
  
  readme <- readLines("README.Rmd")
  
  readme <- c(readme, c("```{r}" ,                                                                         
    "load('tests/reference_answers.RData')"  ,   
    ".gradeR(student_answers = student_answers_test, reference_answers = .reference_answers)",
    "```" ,""))
  
  writeLines(readme, "README.Rmd")
  
  #Render HW and README
  rmarkdown::render("0_Homework.Rmd")

}
