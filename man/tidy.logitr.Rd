% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/broom.R
\name{tidy.logitr}
\alias{tidy.logitr}
\title{Tidy a \code{logitr} class object}
\usage{
\method{tidy}{logitr}(x, conf.int = FALSE, conf.level = 0.95, ...)
}
\arguments{
\item{x}{is an object of class \code{logitr}.}

\item{conf.int}{Logical indicating whether or not to include
a confidence interval in the tidied output. Defaults to FALSE.}

\item{conf.level}{The confidence level to use for the confidence
interval if conf.int = TRUE. Must be strictly greater than 0
and less than 1. Defaults to 0.95, which corresponds to a
95 percent confidence interval.}

\item{...}{Unused, included for generic consistency only.}
}
\value{
A tidy \code{\link[tibble:tibble]{tibble::tibble()}} summarizing component-level
information about the model
}
\description{
Tidy a \code{logitr} class object
}
\examples{
library(logitr)

# Estimate a preference space model
mnl_pref <- logitr(
  data    = yogurt,
  outcome = "choice",
  obsID   = "obsID",
  pars    = c("price", "feat", "brand")
)

# Extract a tibble of the model coefficients
tidy(mnl_pref)

# Extract a tibble of the model coefficients with confidence intervals
tidy(mnl_pref, conf.int = TRUE)

}
