## ---- eval=FALSE--------------------------------------------------------------
#  model <- logitr(
#    data,
#    choiceName,
#    obsIDName,
#    parNames,
#    priceName = NULL,
#    randPars = NULL,
#    randPrice = NULL,
#    modelSpace = "pref",
#    weightsName = NULL,
#    options = list()
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_pref <- logitr(
#      data       = data,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = c("price", "size"))
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_wtp <- logitr(
#      data       = data,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = "size",
#      priceName  = "price",
#      modelSpace = "wtp",
#      options    = list(numMultiStarts = 10) # Set numMultiStarts > 1 to run a multistart
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mxl_pref <- logitr(
#      data       = data,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = c("price", "size"),
#      randPars   = c(size = "n"), # Modeling size parameter as normally distributed
#      options    = list(numMultiStarts = 10) # Set numMultiStarts > 1 to run a multistart
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  wtp(mnl_pref, priceName)

## ---- eval=FALSE--------------------------------------------------------------
#  wtpCompare(mnl_pref, mnl_wtp, priceName)

## ---- eval=FALSE--------------------------------------------------------------
#  shares = simulateShares(model, alts, priceName = NULL, alpha = 0.025)

