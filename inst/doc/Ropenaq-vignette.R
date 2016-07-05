## ---- echo = FALSE, warning=FALSE, message=FALSE-------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  purl = NOT_CRAN,
  eval = NOT_CRAN
)

## ---- warning=FALSE, message=FALSE---------------------------------------
library("ropenaq")
countriesTable <- aq_countries()
library("knitr")
kable(countriesTable$results)
kable(countriesTable$meta)
kable(countriesTable$timestamp)

## ---- cache=FALSE--------------------------------------------------------
citiesTable <- aq_cities()
kable(head(citiesTable$results))

## ---- cache=FALSE--------------------------------------------------------
citiesTableIndia <- aq_cities(country="IN")
kable(citiesTableIndia$results)

## ---- error=TRUE---------------------------------------------------------
#aq_cities(country="PANEM")

## ---- cache=FALSE--------------------------------------------------------
locationsIndia <- aq_locations(country="IN", parameter="pm25")
kable(locationsIndia$results)

## ---- cache=FALSE--------------------------------------------------------
tableResults <- aq_measurements(country="IN", city="Delhi", location="Anand+Vihar", parameter="pm25")
kable(head(tableResults$results))
kable(tableResults$timestamp)
kable(tableResults$meta)

## ---- cache=FALSE--------------------------------------------------------
tableLatest <- aq_latest()
kable(head(tableLatest$results))

## ---- cache=FALSE--------------------------------------------------------
tableLatest <- aq_latest(country="IN", city="Delhi", location="Anand+Vihar")
kable(head(tableLatest$results))

## ------------------------------------------------------------------------
how_many <- aq_measurements(city = "Delhi",
                            parameter = "pm25")$meta
knitr::kable(how_many)
how_many$found

## ---- eval = FALSE-------------------------------------------------------
#  meas <- NULL
#  for (page in 1:(ceiling(how_many$found/1000))){
#    meas <- bind_rows(meas,
#                  aq_measurements(city = "Delhi",
#                                  parameter = "pm25",
#                                  page = page,
#                                  limit = 1000))
#    }
#  

