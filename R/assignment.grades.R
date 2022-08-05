#' Generate student's and full version of the homework
#' 
#' This function extracts grades from submitted assignments. It also
#' moves all the HTML files from each student repo to a main folder where
#' the instructor can check the rendered submissions.If you're interested in 
#' using \code{wkhtmltopdf} to transform HTML files into PDFs, and submit comments
#' in PDF files, that's also an option. However, please make sure that \code{wkhtmltopdf}
#' is installed to the path. Instructors can also just give feedback directly in 
#' github or using any other approach they decide is suitable given their expectations.
#' 
#' @param createPDFs Should we use \code{wkhtmltopdf} to create PDF 
#'                   files from student's submissions?
#' 
#' @export

assignment.grades <- function(createPDFs = TRUE){
  
  #Set the working directory
  mainDir <- getwd()
  targetFiles <- list.files(pattern = "html", recursive = T, full.names = T)
  dir.create("0_HTML")
  targetFilesUpdated <- sub('/0_', "_", targetFiles, fixed = TRUE)
  targetFilesUpdated <- sub('./', '0_HTML/', targetFilesUpdated)
  file.rename(targetFiles, targetFilesUpdated)
  
  if (createPDFs){
  ##Get the PDFs
  subDir <- paste0(mainDir, "/0_HTML")
  setwd(subDir)
  system('for f in *.html; do wkhtmltopdf "$f" "$f.pdf"; done')
  setwd(mainDir)
  }
  
  ##Export grades
  targetFiles <- list.files(".", pattern = "README.md",recursive = TRUE, full.names = TRUE)
  grades <- do.call(rbind,lapply(targetFiles, function(x){
    targetFile <- readLines(x)
    
    points <- targetFile[grep("Auto-grade", targetFile)]
    points <- gsub(".*,","",points)
    
    cbind.data.frame(student= strsplit(x, "/")[[1]][2] , points =points)
  }))
  
  ##Export grades
  write.csv(grades, "0_grades.csv")
  
}
