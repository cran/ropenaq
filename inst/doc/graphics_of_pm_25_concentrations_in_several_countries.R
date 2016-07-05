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
library("ggplot2")
library("dplyr")


## ----fig.width=7, fig.height=4-------------------------------------------
tbHanoi <- aq_measurements(city="Hanoi", parameter="pm25", date_from=as.character(Sys.Date()-1), limit=1000)$results

tbJakarta <- aq_measurements(city="Jakarta", parameter="pm25", date_from=as.character(Sys.Date()-1), limit=1000)$results

tbChennai <- aq_measurements(city="Chennai", location="US+Diplomatic+Post%3A+Chennai", parameter="pm25", date_from=as.character(Sys.Date()-1), limit=1000)$results

tbWarsaw <- aq_measurements(city="Warszawa", location="Marsza%C5%82kowska", parameter="pm25", date_from=as.character(Sys.Date()-1), limit=1000)$results


tbPM <- rbind(tbHanoi,
            tbJakarta,
            tbChennai,
            tbWarsaw)
tbPM <- filter(tbPM, value>=0)

ggplot() + geom_line(data=tbPM,
                     aes(x=dateLocal, y=value, colour=location),
                     size=1.5) +
  ylab(expression(paste("PM2.5 concentration (", mu, "g/",m^3,")"))) +
  theme(text = element_text(size=15))


## ----fig.width=7, fig.height=4-------------------------------------------
tbIndia <- aq_measurements(country="IN", parameter="pm25", date_from=as.character(Sys.Date()-1), limit=1000)$results
tbIndia <- filter(tbIndia, value>=0)
ggplot() + geom_line(data=tbIndia,
                     aes(x=dateLocal, y=value, colour=location),
                     size=1.5) +
  ylab(expression(paste("PM2.5 concentration (", mu, "g/",m^3,")"))) +
  theme(text = element_text(size=15))

