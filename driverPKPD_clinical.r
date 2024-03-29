# Run the model
library(deSolve)
library(ggplot2)
library(RColorBrewer)
library(gridExtra)

# get relevant functions
source("setparams.r")
source("model_PKPD.r")
source("initconds.r")

# get initial condition
IC <- unlist(IC_clinPKPD())

# get parameters
pars <- params_clin_PKPD()

# events (doses)
dose_times = c(0) # when to do dose
dose_amts = c(0) # dose amounts
events <- data.frame(var = 'CARTe_PB', # index for CARTe_PB in the state vector y
                     time = dose_times,
                     value = dose_amts, # dose concentration
                     method = "add")

# simulation time
t0 = -2 # start time
tf = 10 # final time (days)
times = seq(t0,tf,1/4)
times = unique(sort(c(times, dose_times)))

# Model simulation
print('start simulation')
out1 <- as.data.frame(lsoda(
            y = IC,
            times = times,
            func = model_PKPD, # PKPD model
            parms = pars,
            rtol = 1e-6,
            atol = 1e-6,
            events = list(data = events) # add doses
            ))
print('simulation done')


# Plot results
print('plotting results')

# Figure specs
my_palette <- brewer.pal(5, "Dark2")
cid = 1 # color id
lw = 1.0 # linewidth


pltCARTe_PB <- ggplot() +
                geom_line(data = out1, aes(x = time, y = CARTe_PB), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTe in blood",
                    y = "CARTe_PB (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTe_PB.png", plot = pltCARTe_PB, width = 4, height = 4, dpi = 300)

pltCARTm_PB <- ggplot() +
                geom_line(data = out1, aes(x = time, y = CARTm_PB), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTm in blood",
                    y = "CARTm_PB (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTm_PB.png", plot = pltCARTm_PB, width = 4, height = 4, dpi = 300)

pltCARTe_T <- ggplot() +
                geom_line(data = out1, aes(x = time, y = CARTe_T), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTe in tissue",
                    y = "CARTe_T (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTe_T.png", plot = pltCARTe_T, width = 4, height = 4, dpi = 300)

pltCARTm_T <- ggplot() +
                geom_line(data = out1, aes(x = time, y = CARTm_T), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTm in tissue",
                    y = "CARTm_T (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTm_T.png", plot = pltCARTm_T, width = 4, height = 4, dpi = 300)

# put plots on a grid
combined_plots <- grid.arrange(pltCARTe_PB, pltCARTm_PB, pltCARTe_T, pltCARTm_T, 
                                    ncol = 2, nrow = 2)
# save combined plots as PNG file
ggsave("plotCARTall.png", plot = combined_plots, width = 10, height = 10, dpi = 300)  

pltCplx <- ggplot() +
                geom_line(data = out1, aes(x = time, y = Cplx), color = my_palette[cid], linewidth = lw) +
                labs(title = "Complex",
                    y = "Cplx") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCplx.png", plot = pltCplx, width = 4, height = 4, dpi = 300)

pltTumor <- ggplot() +
                geom_line(data = out1, aes(x = time, y = Tumor), color = my_palette[cid], linewidth = lw) +
                labs(title = "Tumor",
                    y = "Tumor (cells)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotTumor.png", plot = pltTumor, width = 4, height = 4, dpi = 300)






