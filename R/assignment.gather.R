#' Collect homeworks submitted to GitHub classroom
#' 
#' This function takes the name of an organization, a pattern in student's repos
#' and download all the matching repos in the organization to a particular folder.
#' 
#' @param organization Name of GitHub organization
#' @param GHpattern Pattern in GitHub repos for the target assignment
#' @param path Where should the repos be cloned locally? 
#' 
#' @importFrom ghclass local_repo_clone
#' 
#' @export

assignment.collect <- function(organization, GHpattern, path){
  ghclass::local_repo_clone(
    repo = ghclass::org_repos(org = organization, filter = GHpattern),
    local_path = path
  )
}

