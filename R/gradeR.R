#' Autograder
#' 
#' This function combines student's answers, reference answers, and a maximum number
#' of points to grade a particular set of questions.
#' 
#' @param student_answers Answers provided by the student in the form of a list that matches the order as the one in the \code{reference_answers}
#' @param reference_answers Reference answers constructed using the files under /tests
#' @param maximum_grade Maximum grade
#' 
#' @export
#' 

.gradeR <- function(student_answers, reference_answers, maximum_grade=10){
  
  report <- sapply(seq_along(student_answers), function(x){
    if ( is.null(student_answers[[x]])){
      cat('\u2753', "Question", names(reference_answers)[x], "- Incomplete\n")
      return(0)
    }else{
      st_answer <- reference_answers[[x]][[2]](student_answers[[x]])
      ref_answer <- reference_answers[[x]][[1]]
      answered <- all(ref_answer == st_answer)
      if (answered) {
        cat('\u2705', "Question", names(reference_answers)[x], "- Correct!\n")
        return(1)
      }else{
        cat('\u274C', "Question", names(reference_answers)[x], "- Potentially incorrect\n")
        return(0)
      }
    }
  })

  cat('\n\n   \u231B', "Auto-grade", round(100*sum(report)/length(reference_answers),2),"%, ", round((sum(report)/length(reference_answers))*maximum_grade,2), "/",maximum_grade, "points\n\n\n")

}


