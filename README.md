# gradeR

## A basic autograding system for assignments in `R`


### The project in brief

1. Function to download sample repo
    - Open files using `usethis::edit_file()`
    - Alternatively, use `here` and `usethis` as shown below:

```{r}
library(here)
library(usethis)
##Option 1: Fork a repo (which might be handy...) and open the project
usethis::use_directory(here("TemplateRepo_gradeR"))

usethis::create_from_github(repo_spec = "hidyverse/tidytues", 
                            destdir = "TemplateRepo_gradeR",
                            fork = TRUE,
                            rstudio = ifelse(Sys.getenv("RSTUDIO"), 1, 0)
                            )

##Option 2: Clone aproject locally and edit the relevant files...
usethis::use_course('cromanpa94/repcol', 
                    destdir = here("TemplateRepo_gradeR"))
usethis::edit_file()


```

2. Function to run the autograder in the readme and homework

    - takes a list of objects saved to a workspace

3. Functions to generate correct solutions to questions 

    - each question indicate string (partial match), number or explicit object. Number of points (optional)
    - only all good or wrong. No partial credit

4. Assemble the reference of the autograder

    - take a list of correct answers
    - all questions worth the same or not
    - print statement for each question 
    - print total credit
    - save feedback 

5. Compile grades and feedback 

    - for a set of folders
    - find feedback files
    - read them and put it into a single string per student.
    - list grades per student

