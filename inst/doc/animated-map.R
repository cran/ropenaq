## ---- echo = FALSE, warning=FALSE, message=FALSE-------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  purl = NOT_CRAN,
  eval = NOT_CRAN
)

## ---- warning=FALSE, message=FALSE---------------------------------------
library("ggmap")
library("ggplot2")
library("ropenaq")
library("dplyr")
library("tidyr")

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
#  measurementsIndia <- NULL
#  for (page in 1:7){
#    print(page)
#    measurementsIndia <- rbind(measurementsIndia,
#                               aq_measurements(country = "IN",
#                                               has_geo = TRUE,
#                                               page = page,
#                                               parameter = "pm25",
#                                               limit = 1000,
#                                               date_from = "2015-09-01",
#                                               value_from = 0))}

## ---- warning=FALSE, message=FALSE, eval=FALSE, echo=FALSE---------------
#  save(measurementsIndia, file="data/measurementsIndia.RData")

## ---- warning=FALSE, message=FALSE, eval=TRUE, echo=FALSE----------------
load("data/measurementsIndia.RData")

## ------------------------------------------------------------------------
dailyIndia <- measurementsIndia %>%
  group_by(day = as.Date(dateLocal),
           location) %>%
  summarize(value = mean(value)) %>%
  mutate(location = as.factor(location))


dailyIndia <- complete(dailyIndia, day, location, fill = list(value = NA))

## ------------------------------------------------------------------------
tableGeo <- unique(select(measurementsIndia, location,
                          longitude, latitude))

dailyIndia <- dailyIndia %>% left_join(tableGeo)

## ------------------------------------------------------------------------
indiaMap <- get_map(location = c(65,
                                 6,
                                 97,
                                 36))
ggmap(indiaMap)

## ---- echo = TRUE, eval = FALSE------------------------------------------
#  library("gganimate")
#  library("animation")
#  minConc <- min(dailyIndia$value)
#  maxConc <- max(dailyIndia$value)
#  plotMap <- ggmap(indiaMap)+ theme_bw()+
#    geom_point(data = dailyIndia, aes(x=longitude,
#                                    y=latitude,
#                                    frame=day,
#                                         colour = value),
#               size=8)+
#    scale_colour_gradient(limits=c(minConc, maxConc),
#                          low="yellow",
#                          high="red") +
#    theme(axis.line=element_blank(),axis.text.x=element_blank(),
#          axis.text.y=element_blank(),axis.ticks=element_blank(),
#          axis.title.x=element_blank(),
#          text = element_text(size=20),
#          axis.title.y=element_blank(),
#          panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
#          panel.grid.minor=element_blank(),plot.background=element_blank())+
#    ggtitle("PM 2.5 concentration") +
#    theme(plot.title = element_text(lineheight=1, face="bold"))
#  
#  ani.options(interval = 0.25, ani.width = 800, ani.height = 800)
#  gg_animate(plotMap, "map.mp4")

