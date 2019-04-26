#' Plane
#' 
#' This function is similar to the \code{facet_*} family of functions from the \code{ggplot2} package.
#' 
#' @inheritParams geoms
#' @param type The type of facet to user.
#' @param ... Planes, bare column names or \code{NULL}.
#' 
#' @name plane
#' @export
plane_wrap <- function(g2, ..., type = c("list", "rect", "circle", "tree", "mirror", "matrix")) {
  
  plane_aes <- get_planes(...)

  # add to ensure we select columns
  g2$x$mapping <- append(g2$x$mapping, plane_aes) 

  # add to main mapping
  plane_names <- plane_aes %>% 
    map(rlang::quo_name) %>% 
    unlist()

  fields <- plane_names %>% 
    map(js_null) %>% 
    unname() %>% 
    unlist()

  print(fields)

  g2$x$facet <- list(
    type = match.arg(type),
    opts = list(
      fields = fields
    )
  )

  return(g2)
}

#' @rdname plane
#' @export
planes <- function(...){
  exprs <- rlang::enquos(..., .ignore_empty = "all")
  aes <- new_aes(exprs, env = parent.frame())
  .construct_aesthetics(aes, "planes")
}