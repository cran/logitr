## ----include=FALSE------------------------------------------------------------
# Unfortunately, because not all these packages are available on CRAN 
# for all platforms, this vignette causes errors that will lead to {logitr}
# being taken off CRAN. So instead of actually running all of this code, 
# I just hard-code the results that print out here. You can run it yourself
# to verify that the results are accurate.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  eval = FALSE,
  fig.width = 7.252,
  fig.height = 4,
  comment = "#>",
  fig.retina = 3
)

# Read in results from already estimated models so that the
# examples aren't actually run when building this page,
# otherwise it'll take much longer to build
# model_logitr <- readRDS(here::here('inst', 'extdata', 'model_logitr.Rds'))
# model_logitr10 <- readRDS(here::here('inst', 'extdata', 'model_logitr10.Rds'))
# model_mixl1 <- readRDS(here::here('inst', 'extdata', 'model_mixl1.Rds'))
# model_mixl2 <- readRDS(here::here('inst', 'extdata', 'model_mixl2.Rds'))
# model_gmnl1 <- readRDS(here::here('inst', 'extdata', 'model_gmnl1.Rds'))
# model_apollo1 <- readRDS(here::here('inst', 'extdata', 'model_apollo1.Rds'))
# model_apollo2 <- readRDS(here::here('inst', 'extdata', 'model_apollo2.Rds'))

## -----------------------------------------------------------------------------
#  library(logitr)
#  library(mlogit)
#  library(gmnl)
#  library(apollo)
#  library(mixl)
#  library(dplyr)
#  library(tidyr)
#  
#  set.seed(1234)

## -----------------------------------------------------------------------------
#  numDraws_wtp <- 50
#  start_wtp <- c(
#      scalePar        = 1,
#      feat            = 0,
#      brandhiland     = 0,
#      brandweight     = 0,
#      brandyoplait    = 0,
#      sd_feat         = 0.1,
#      sd_brandhiland  = 0.1,
#      sd_brandweight  = 0.1,
#      sd_brandyoplait = 0.1
#  )

## -----------------------------------------------------------------------------
#  yogurt <- subset(logitr::yogurt, logitr::yogurt$id <= 50)

## -----------------------------------------------------------------------------
#  data_gmnl <- mlogit.data(
#      data     = yogurt,
#      shape    = "long",
#      choice   = "choice",
#      id.var   = 'id',
#      alt.var  = 'alt',
#      chid.var = 'obsID'
#  )

## -----------------------------------------------------------------------------
#  yogurt_price <- yogurt %>%
#      select(id, obsID, price, brand) %>%
#      mutate(price = -1*price) %>%
#      pivot_wider(
#          names_from  = 'brand',
#          values_from = 'price') %>%
#      rename(
#          price_dannon  = dannon,
#          price_hiland  = hiland,
#          price_weight  = weight,
#          price_yoplait = yoplait)
#  yogurt_feat <- yogurt %>%
#      select(id, obsID, feat, brand) %>%
#      pivot_wider(
#          names_from = 'brand',
#          values_from = 'feat') %>%
#      rename(
#          feat_dannon  = dannon,
#          feat_hiland  = hiland,
#          feat_weight  = weight,
#          feat_yoplait = yoplait)
#  yogurt_choice <- yogurt %>%
#      filter(choice == 1) %>%
#      select(id, obsID, choice = alt)
#  data_apollo <- yogurt_price %>%
#      left_join(yogurt_feat, by = c('id', 'obsID')) %>%
#      left_join(yogurt_choice, by = c('id', 'obsID')) %>%
#      arrange(id, obsID) %>%
#      mutate(
#        av_dannon  = 1,
#        av_hiland  = 1,
#        av_weight  = 1,
#        av_yoplait = 1
#      )

## -----------------------------------------------------------------------------
#  apollo_probabilities_wtp <- function(
#    apollo_beta, apollo_inputs, functionality = "estimate"
#  ) {
#  
#      ### Attach inputs and detach after function exit
#      apollo_attach(apollo_beta, apollo_inputs)
#      on.exit(apollo_detach(apollo_beta, apollo_inputs))
#  
#      ### Create list of probabilities P
#      P <- list()
#  
#      ### List of utilities: these must use the same names as in mnl_settings,
#      #   order is irrelevant
#      V <- list()
#      V[["dannon"]] <- scalePar * (b_feat * feat_dannon - price_dannon)
#      V[["hiland"]] <- scalePar * (b_brandhiland + b_feat * feat_hiland - price_hiland)
#      V[["weight"]] <- scalePar * (b_brandweight + b_feat * feat_weight - price_weight)
#      V[["yoplait"]] <- scalePar * (b_brandyoplait + b_feat * feat_yoplait - price_yoplait)
#  
#      ### Define settings for MNL model component
#      mnl_settings <- list(
#          alternatives = c(dannon = 1, hiland = 2, weight = 3, yoplait = 4),
#          avail = list(
#            dannon = av_dannon,
#            hiland = av_hiland,
#            weight = av_weight,
#            yoplait = av_yoplait),
#          choiceVar = choice,
#          utilities = V
#      )
#  
#      ### Compute probabilities using MNL model
#      P[["model"]] <- apollo_mnl(mnl_settings, functionality)
#      ### Take product across observation for same individual
#      P <- apollo_panelProd(P, apollo_inputs, functionality)
#      ### Average across inter-individual draws
#      P = apollo_avgInterDraws(P, apollo_inputs, functionality)
#      ### Prepare and return outputs of function
#      P <- apollo_prepareProb(P, apollo_inputs, functionality)
#  
#      return(P)
#  }

## -----------------------------------------------------------------------------
#  apollo_randCoeff <- function(apollo_beta, apollo_inputs) {
#      randcoeff <- list()
#      randcoeff[['b_feat']] <- feat + d_feat * sd_feat
#      randcoeff[['b_brandhiland']] <- brandhiland + d_brandhiland * sd_brandhiland
#      randcoeff[['b_brandweight']] <- brandweight + d_brandweight * sd_brandweight
#      randcoeff[['b_brandyoplait']] <- brandyoplait + d_brandyoplait * sd_brandyoplait
#      return(randcoeff)
#  }

## -----------------------------------------------------------------------------
#  apollo_control_wtp <- list(
#      modelName       = "MXL_WTP_space",
#      modelDescr      = "MXL model on yogurt choice SP data, in WTP space",
#      indivID         = "id",
#      mixing          = TRUE,
#      analyticGrad    = TRUE,
#      panelData       = TRUE,
#      nCores          = 1
#  )
#  
#  # Set parameters for generating draws
#  apollo_draws_n <- list(
#      interDrawsType = "halton",
#      interNDraws    = numDraws_wtp,
#      interUnifDraws = c(),
#      interNormDraws = c(
#          "d_feat", "d_brandhiland", "d_brandweight", "d_brandyoplait"),
#      intraDrawsType = "halton",
#      intraNDraws    = 0,
#      intraUnifDraws = c(),
#      intraNormDraws = c()
#  )
#  
#  # Set input
#  apollo_inputs_wtp <- apollo_validateInputs(
#      apollo_beta      = start_wtp,
#      apollo_fixed     = NULL,
#      database         = data_apollo,
#      apollo_draws     = apollo_draws_n,
#      apollo_randCoeff = apollo_randCoeff,
#      apollo_control   = apollo_control_wtp
#  )

## -----------------------------------------------------------------------------
#  data_mixl <- data_apollo # Uses the same "wide" format as {apollo}
#  data_mixl$ID <- data_mixl$id
#  data_mixl$CHOICE <- data_mixl$choice

## -----------------------------------------------------------------------------
#  mixl_wtp <- "
#      feat_RND = @feat + draw_1 * @sd_feat;
#      brandhiland_RND = @brandhiland + draw_2 * @sd_brandhiland;
#      brandweight_RND = @brandweight + draw_3 * @sd_brandweight;
#      brandyoplait_RND = @brandyoplait + draw_4 * @sd_brandyoplait;
#      U_1 = @scalePar * (feat_RND * $feat_dannon - $price_dannon);
#      U_2 = @scalePar * (brandhiland_RND + feat_RND * $feat_hiland - $price_hiland);
#      U_3 = @scalePar * (brandweight_RND + feat_RND * $feat_weight - $price_weight);
#      U_4 = @scalePar * (brandyoplait_RND + feat_RND * $feat_yoplait - $price_yoplait);
#  "
#  mixl_spec_wtp <- specify_model(mixl_wtp, data_mixl)
#  availabilities <- generate_default_availabilities(data_mixl, 4)

## -----------------------------------------------------------------------------
#  model_logitr <- logitr(
#      data      = yogurt,
#      outcome   = 'choice',
#      obsID     = 'obsID',
#      panelID   = 'id',
#      pars      = c('feat', 'brand'),
#      scalePar  = 'price',
#      randPars  = c(feat = "n", brand = "n"),
#      startVals = start_wtp,
#      numDraws  = numDraws_wtp
#  )
#  
#  summary(model_logitr)

## -----------------------------------------------------------------------------
#  model_logitr <- logitr(
#      data      = yogurt,
#      outcome   = 'choice',
#      obsID     = 'obsID',
#      panelID   = 'id',
#      pars      = c('feat', 'brand'),
#      scalePar  = 'price',
#      randPars  = c(feat = "n", brand = "n"),
#      startVals = start_wtp,
#      numDraws  = numDraws_wtp,
#      numMultiStarts = 10
#  )
#  
#  summary(model_logitr)

## -----------------------------------------------------------------------------
#  model_mixl <- estimate(
#      mixl_spec_wtp, start_wtp,
#      data_mixl, availabilities,
#      nDraws = numDraws_wtp
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), logLik(model_mixl))

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), coef(model_mixl))

## -----------------------------------------------------------------------------
#  model_mixl <- estimate(
#      mixl_spec_wtp, coef(model_logitr),
#      data_mixl, availabilities,
#      nDraws = numDraws_wtp
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), logLik(model_mixl))

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), coef(model_mixl))

## -----------------------------------------------------------------------------
#  model_gmnl <- gmnl(
#      data = data_gmnl,
#      formula = choice ~ price + feat + brand | 0 | 0 | 0 | 1,
#      ranp = c(
#          feat = "n", brandhiland = "n", brandweight = "n",
#          brandyoplait = "n"),
#      fixed = c(TRUE, rep(FALSE, 10), TRUE),
#      model = "gmnl",
#      method = "bfgs",
#      haltons = NA,
#      panel = TRUE,
#      start = c(start_wtp, 0.1, 0.1, 0),
#      R = numDraws_wtp
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), logLik(model_gmnl))

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), coef(model_gmnl))

## -----------------------------------------------------------------------------
#  model_gmnl <- gmnl(
#      data = data_gmnl,
#      formula = choice ~ price + feat + brand | 0 | 0 | 0 | 1,
#      ranp = c(
#          feat = "n", brandhiland = "n", brandweight = "n",
#          brandyoplait = "n"),
#      fixed = c(TRUE, rep(FALSE, 10), TRUE),
#      model = "gmnl",
#      method = "bfgs",
#      haltons = NA,
#      panel = TRUE,
#      start = c(coef(model_logitr), 0.1, 0.1, 0),
#      R = numDraws_wtp
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), logLik(model_gmnl))

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), coef(model_gmnl))

## -----------------------------------------------------------------------------
#  model_apollo <- apollo_estimate(
#      apollo_beta          = start_wtp,
#      apollo_fixed         = NULL,
#      apollo_probabilities = apollo_probabilities_wtp,
#      apollo_inputs        = apollo_inputs_wtp,
#      estimate_settings    = list(printLevel = 0)
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), model_apollo$LLout)

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), coef(model_apollo))

## -----------------------------------------------------------------------------
#  model_apollo <- apollo_estimate(
#      apollo_beta          = coef(model_logitr),
#      apollo_fixed         = NULL,
#      apollo_probabilities = apollo_probabilities_wtp,
#      apollo_inputs        = apollo_inputs_wtp,
#      estimate_settings    = list(printLevel = 0)
#  )

## -----------------------------------------------------------------------------
#  c(logLik(model_logitr), model_apollo$LLout)

## -----------------------------------------------------------------------------
#  cbind(coef(model_logitr), model_apollo$betaStop)

