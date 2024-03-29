# ============================================================================
# Functions for taking draws for mixed logit models
# ============================================================================

# Returns shifted normal draws for each parameter
makeBetaDraws <- function(pars, parIDs, n, standardDraws, correlation) {
  pars_mean <- pars[seq_len(n$vars)]
  pars_sd <- pars[(n$vars + 1):n$pars]
  # First scale the draws according to the covariance matrix
  if (correlation) {
    lowerMat <- matrix(0, n$parsRandom, n$parsRandom)
    lowerMat[lower.tri(lowerMat, diag = TRUE)] <- pars_sd
  } else {
    lowerMat <- diag(pars_sd, ncol = length(pars_sd))
  }
  scaledDraws <- standardDraws
  scaledDraws[,parIDs$r] <- scaledDraws[,parIDs$r] %*% lowerMat
  # Now shift the draws according to the means
  meanMat <- matrix(rep(pars_mean, n$draws), ncol = n$vars, byrow = TRUE)
  betaDraws <- meanMat + scaledDraws
  # log-normal draws: Exponentiate
  if (length(parIDs$ln) > 0) {
    betaDraws[, parIDs$ln] <- exp(betaDraws[, parIDs$ln])
  }
  # Censored normal draws: Censor
  if (length(parIDs$cn) > 0) {
    betaDraws[, parIDs$cn] <- pmax(betaDraws[, parIDs$cn], 0)
  }
  return(betaDraws)
}

getStandardDraws <- function(parIDs, numDraws, drawType) {
  numBetas <- length(parIDs$f) + length(parIDs$r)
  if (drawType == 'sobol') {
    draws <- as.matrix(randtoolbox::sobol(numDraws, numBetas, normal = TRUE))
  } else {
    draws <- as.matrix(randtoolbox::halton(numDraws, numBetas, normal = TRUE))
  }
  draws[, parIDs$f] <- 0 * draws[, parIDs$f]
  return(draws)
}

getUncertaintyDraws <- function(model, numDraws) {
  coefs <- stats::coef(model)
  covariance <- stats::vcov(model)
  draws <- data.frame(MASS::mvrnorm(numDraws, coefs, covariance))
  colnames(draws) <- names(coefs)
  return(draws)
}
