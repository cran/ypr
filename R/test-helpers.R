save_csv <- function(x) {
  path <- tempfile(fileext = ".csv")
  readr::write_csv(x, path)
  path
}

expect_snapshot_data <- function(x, name) {
  testthat::skip_on_ci()
  testthat::skip_on_os("windows")
  path <- save_csv(x)
  testthat::expect_snapshot_file(path, paste0(name, ".csv"))
}


save_png <- function(x, width = 400, height = 400) {
  path <- tempfile(fileext = ".png")
  grDevices::png(path, width = width, height = height)
  on.exit(grDevices::dev.off())
  print(x)

  path
}

expect_snapshot_plot <- function(x, name) {
  testthat::skip_on_ci()
  testthat::skip_on_os("windows")
  path <- save_png(x)
  testthat::expect_snapshot_file(path, paste0(name, ".png"))
}

## Inspiration from usethis package https://usethis.r-lib.org/index.html
## If session temp directory appears to be, or be within, a project, there
## will be large scale, spurious test failures.
## The IDE sometimes leaves .Rproj files behind in session temp directory or
## one of its parents.
## Delete such files manually.

create_local_package <- function(dir = tempfile(pattern = "testpkg"),
                                 env = parent.frame()) {
  old_project <- proj_get_() # this could be `NULL`, i.e. no active project
  old_wd <- getwd() # not necessarily same as `old_project`

  withr::defer(
    {
      unlink(dir, recursive = TRUE)
    },
    envir = env
  )

  withr::with_options(
    list(usethis.quiet = TRUE),
    usethis::create_package(
      dir,
      rstudio = FALSE,
      open = FALSE,
      check_name = FALSE
    )
  )

  withr::defer(usethis::proj_set(old_project, force = TRUE), envir = env)
  usethis::proj_set(dir)
  withr::defer(
    {
      setwd(old_wd)
    },
    envir = env
  )
  setwd(usethis::proj_get())

  invisible(usethis::proj_get())
}

proj <- new.env(parent = emptyenv())

proj_get_ <- function() proj$cur

proj_set_ <- function(path) {
  old <- proj$cur
  proj$cur <- path
  invisible(old)
}
