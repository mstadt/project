pharmaco <- function(t, blood, p) {
  dblood <- - b * blood
  list(dblood)
}
b <- 0.6
yini <- c(blood = 0)


injectevents <- data.frame(var = "blood",
                          time = 0:20,
                         value = 40,
                        method = "add")
head(injectevents)

times <- seq(from = 0, to = 10, by = 1/24)
outDrug <- ode(func = pharmaco, times = times, y = yini,
  parms = NULL, method = "impAdams",
  events = list(data = injectevents))