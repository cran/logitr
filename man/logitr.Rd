% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logitr.R
\name{logitr}
\alias{logitr}
\title{The main function for estimating logit models}
\usage{
logitr(
  data,
  outcome,
  obsID,
  pars,
  scalePar = NULL,
  randPars = NULL,
  randScale = NULL,
  modelSpace = NULL,
  weights = NULL,
  panelID = NULL,
  clusterID = NULL,
  robust = FALSE,
  correlation = FALSE,
  startValBounds = c(-1, 1),
  startVals = NULL,
  numMultiStarts = 1,
  useAnalyticGrad = TRUE,
  scaleInputs = TRUE,
  standardDraws = NULL,
  drawType = "halton",
  numDraws = 50,
  numCores = NULL,
  vcov = FALSE,
  predict = TRUE,
  options = list(print_level = 0, xtol_rel = 1e-06, xtol_abs = 1e-06, ftol_rel = 1e-06,
    ftol_abs = 1e-06, maxeval = 1000, algorithm = "NLOPT_LD_LBFGS"),
  price,
  randPrice,
  choice,
  parNames,
  choiceName,
  obsIDName,
  priceName,
  weightsName,
  clusterName,
  cluster
)
}
\arguments{
\item{data}{The data, formatted as a \code{data.frame} object.}

\item{outcome}{The name of the column that identifies the outcome variable,
which should be coded with a \code{1} for \code{TRUE} and \code{0} for \code{FALSE}.}

\item{obsID}{The name of the column that identifies each observation.}

\item{pars}{The names of the parameters to be estimated in the model.
Must be the same as the column names in the \code{data} argument. For WTP space
models, do not include the \code{scalePar} variable in \code{pars}.}

\item{scalePar}{The name of the column that identifies the scale variable,
which is typically "price" for WTP space models, but could be any
continuous variable, such as "time". Defaults to \code{NULL}.}

\item{randPars}{A named vector whose names are the random parameters and
values the distribution: \code{'n'} for normal, \code{'ln'} for log-normal, or
\code{'cn'} for zero-censored normal. Defaults to \code{NULL}.}

\item{randScale}{The random distribution for the scale parameter: \code{'n'} for
normal, \code{'ln'} for log-normal, or \code{'cn'} for zero-censored normal. Only used
for WTP space MXL models. Defaults to \code{NULL}.}

\item{modelSpace}{This argument is no longer needed as of v0.7.0. The model
space is now determined based on the \code{scalePar} argument:
if \code{NULL} (the default), the model will be in the preference space,
otherwise it will be in the WTP space. Defaults to \code{NULL}.}

\item{weights}{The name of the column that identifies the weights to be
used in model estimation. Defaults to \code{NULL}.}

\item{panelID}{The name of the column that identifies the individual (for
panel data where multiple observations are recorded for each individual).
Defaults to \code{NULL}.}

\item{clusterID}{The name of the column that identifies the cluster
groups to be used in model estimation. Defaults to \code{NULL}.}

\item{robust}{Determines whether or not a robust covariance matrix is
estimated. Defaults to \code{FALSE}. Specification of a \code{clusterID} or
\code{weights} will override the user setting and set this to `TRUE' (a
warning will be displayed in this case). Replicates the functionality of
Stata's cmcmmixlogit.}

\item{correlation}{Set to \code{TRUE} to account for correlation across random
parameters (correlated heterogeneity). Defaults to \code{FALSE}.}

\item{startValBounds}{sets the \code{lower} and \code{upper} bounds for the starting
parameter values for each optimization run, which are generated by
\code{runif(n, lower, upper)}. Defaults to \code{c(-1, 1)}.}

\item{startVals}{is vector of values to be used as starting values for the
optimization. Only used for the first run if \code{numMultiStarts > 1}. Defaults
to \code{NULL}.}

\item{numMultiStarts}{is the number of times to run the optimization loop,
each time starting from a different random starting point for each parameter
between \code{startValBounds}. Recommended for non-convex models, such as WTP
space models and mixed logit models. Defaults to \code{1}.}

\item{useAnalyticGrad}{Set to \code{FALSE} to use numerically approximated
gradients instead of analytic gradients during estimation. For now, using
the analytic gradient is faster for MNL models but slower for MXL models.
Defaults to \code{TRUE}.}

\item{scaleInputs}{By default each variable in \code{data} is scaled to be
between 0 and 1 before running the optimization routine because it usually
helps with stability, especially if some of the variables have very large or
very small values (e.g. \verb{> 10^3} or \verb{< 10^-3}). Set to \code{FALSE} to turn this
feature off. Defaults to \code{TRUE}.}

\item{standardDraws}{By default, a new set of standard normal draws are
generated during each call to \code{logitr} (the same draws are used during each
multistart iteration). The user can override those draws by providing a
matrix of standard normal draws if desired. Defaults to \code{NULL}.}

\item{drawType}{Specify the draw type as a character: \code{"halton"}
(the default) or \code{"sobol"} (recommended for models with more than 5
random parameters).}

\item{numDraws}{The number of Halton draws to use for MXL models for the
maximum simulated likelihood. Defaults to \code{50}.}

\item{numCores}{The number of cores to use for parallel processing of the
multistart. Set to \code{1} to serially run the multistart. Defaults to \code{NULL},
in which case the number of cores is set to \code{parallel::detectCores() - 1}.
Max cores allowed is capped at \code{parallel::detectCores()}.}

\item{vcov}{Set to \code{TRUE} to evaluate and include the variance-covariance
matrix and coefficient standard errors in the returned object.
Defaults to \code{FALSE}.}

\item{predict}{If \code{FALSE}, predicted probabilities, fitted values, and
residuals are not included in the returned object. Defaults to \code{TRUE}.}

\item{options}{A list of options for controlling the \code{nloptr()} optimization.
Run \code{nloptr::nloptr.print.options()} for details.}

\item{price}{No longer used as of v0.7.0 - if provided, this is passed
to the \code{scalePar} argument and a warning is displayed.}

\item{randPrice}{No longer used as of v0.7.0 - if provided, this is passed
to the \code{randScale} argument and a warning is displayed.}

\item{choice}{No longer used as of v0.4.0 - if provided, this is passed
to the \code{outcome} argument and a warning is displayed.}

\item{parNames}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{pars} argument and a warning is displayed.}

\item{choiceName}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{outcome} argument and a warning is displayed.}

\item{obsIDName}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{obsID} argument and a warning is displayed.}

\item{priceName}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{scalePar} argument and a warning is displayed.}

\item{weightsName}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{weights} argument and a warning is displayed.}

\item{clusterName}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{clusterID} argument and a warning is displayed.}

\item{cluster}{No longer used as of v0.2.3 - if provided, this is passed
to the \code{clusterID} argument and a warning is displayed.}
}
\value{
The function returns a list object containing the following objects.\tabular{ll}{
   Value \tab Description \cr
   \code{coefficients} \tab The model coefficients at convergence. \cr
   \code{logLik} \tab The log-likelihood value at convergence. \cr
   \code{nullLogLik} \tab The null log-likelihood value (if all coefficients are 0). \cr
   \code{gradient} \tab The gradient of the log-likelihood at convergence. \cr
   \code{hessian} \tab The hessian of the log-likelihood at convergence. \cr
   \code{probabilities} \tab Predicted probabilities. Not returned if \code{predict = FALSE}. \cr
   \code{fitted.values} \tab Fitted values. Not returned if \code{predict = FALSE}. \cr
   \code{residuals} \tab Residuals. Not returned if \code{predict = FALSE}. \cr
   \code{startVals} \tab The starting values used. \cr
   \code{multistartNumber} \tab The multistart run number for this model. \cr
   \code{multistartSummary} \tab A summary of the log-likelihood values for each multistart run (if more than one multistart was used). \cr
   \code{time} \tab The user, system, and elapsed time to run the optimization. \cr
   \code{iterations} \tab The number of iterations until convergence. \cr
   \code{message} \tab A more informative message with the status of the optimization result. \cr
   \code{status} \tab An integer value with the status of the optimization (positive values are successes). Use \code{\link[=statusCodes]{statusCodes()}} for a detailed description. \cr
   \code{call} \tab The matched call to \code{logitr()}. \cr
   \code{inputs} \tab A list of the original inputs to \code{logitr()}. \cr
   \code{data} \tab A list of the original data provided to \code{logitr()} broken up into components used during model estimation. \cr
   \code{numObs} \tab The number of observations. \cr
   \code{numParams} \tab The number of model parameters. \cr
   \code{freq} \tab The frequency counts of each alternative. \cr
   \code{modelType} \tab The model type, \code{'mnl'} for multinomial logit or \code{'mxl'} for mixed logit. \cr
   \code{weightsUsed} \tab \code{TRUE} or \code{FALSE} for whether weights were used in the model. \cr
   \code{numClusters} \tab The number of clusters. \cr
   \code{parSetup} \tab A summary of the distributional assumptions on each model parameter (\code{"f"}="fixed", \code{"n"}="normal distribution", \code{"ln"}="log-normal distribution"). \cr
   \code{parIDs} \tab A list identifying the indices of each parameter in \code{coefficients} by a variety of types. \cr
   \code{scaleFactors} \tab A vector of the scaling factors used to scale each coefficient during estimation. \cr
   \code{standardDraws} \tab The draws used during maximum simulated likelihood (for MXL models). \cr
   \code{options} \tab A list of options for controlling the \code{nloptr()} optimization. Run \code{nloptr::nloptr.print.options()} for details. \cr
}
}
\description{
Use this function to estimate multinomial (MNL) and mixed logit (MXL)
models with "Preference" space or "Willingness-to-pay" (WTP) space utility
parameterizations. The function includes an option to run a multistart
optimization loop with random starting points in each iteration, which is
useful for non-convex problems like MXL models or models with WTP space
utility parameterizations. The main optimization loop uses the \code{nloptr()}
function to minimize the negative log-likelihood function.
}
\details{
The the \code{options} argument is used to control the detailed behavior of the
optimization and must be passed as a list, e.g. \code{options = list(...)}.
Below are a list of the default options, but other options can be included.
Run \code{nloptr::nloptr.print.options()} for more details.\tabular{lll}{
   Argument \tab Description \tab Default \cr
   \code{xtol_rel} \tab The relative \code{x} tolerance for the \code{nloptr} optimization loop. \tab \code{1.0e-6} \cr
   \code{xtol_abs} \tab The absolute \code{x} tolerance for the \code{nloptr} optimization loop. \tab \code{1.0e-6} \cr
   \code{ftol_rel} \tab The relative \code{f} tolerance for the \code{nloptr} optimization loop. \tab \code{1.0e-6} \cr
   \code{ftol_abs} \tab The absolute \code{f} tolerance for the \code{nloptr} optimization loop. \tab \code{1.0e-6} \cr
   \code{maxeval} \tab The maximum number of function evaluations for the \code{nloptr} optimization loop. \tab \code{1000} \cr
   \code{algorithm} \tab The optimization algorithm that \code{nloptr} uses. \tab \code{"NLOPT_LD_LBFGS"} \cr
   \code{print_level} \tab The print level of the \code{nloptr} optimization loop. \tab \code{0} \cr
}
}
\examples{
# For more detailed examples, visit
# https://jhelvy.github.io/logitr/articles/

library(logitr)

# Estimate a MNL model in the Preference space
mnl_pref <- logitr(
  data    = yogurt,
  outcome = "choice",
  obsID   = "obsID",
  pars    = c("price", "feat", "brand")
)

# Estimate a MNL model in the WTP space, using a 5-run multistart
mnl_wtp <- logitr(
  data           = yogurt,
  outcome        = "choice",
  obsID          = "obsID",
  pars           = c("feat", "brand"),
  scalePar       = "price",
  numMultiStarts = 5
)

# Estimate a MXL model in the Preference space with "feat"
# following a normal distribution
# Panel structure is accounted for in this example using "panelID"
mxl_pref <- logitr(
  data     = yogurt,
  outcome  = "choice",
  obsID    = "obsID",
  panelID  = "id",
  pars     = c("price", "feat", "brand"),
  randPars = c(feat = "n")
)
}
\keyword{logit}
\keyword{logitr}
\keyword{mixed}
\keyword{mnl}
\keyword{mxl}
\keyword{willingness-to-pay}
\keyword{wtp}
