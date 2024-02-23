# Run the model
library(deSolve)
library(ggplot2)
library(RColorBrewer)
#library(gridExtra)

# get relevant functions
source("setparams.r")
source("model_eqns.r")
source("initconds.r")

# get initial condition
IC <- unlist(init_conds())

# get parameters
fixed_pars <- fixed_params()
varied_pars <- varied_params() # input parameters

# change parameters here
fixed_pars$Kgtumor0 = 0
varied_pars$Kkill_max0 = 0

# put params in one list
pars <- c(fixed_pars, varied_pars)

# simulation time
t0 = 0 # start time
tf = 500 # final time (days)
times = seq(t0,tf,1)

# set up model
mod <- list(init = IC,
                params = pars,
                model = model_eqns)

# Model simulation
out1 <- as.data.frame(lsoda(
            IC,
            times,
            mod$model,
            mod$params,
            rtol = 1e-10,
            atol = 1e-10
            ))


# Plot results

# Figure specs
my_palette <- brewer.pal(5, "Dark2")
cid = 1 # color id
lw = 1.0 # linewidth

pltT <- ggplot() +
        geom_line(data = out1, aes(x = time, y = Tumor_T), colour = my_palette[cid], linewidth = lw) + # plot TumorT from out
        labs(title = "Tumor cell density", # title
                y = "Tumor_T (cells/L)") + # ylabel
        theme_bw() +
        theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotTumor_T.png", plot = pltT, width = 4, height = 4, dpi = 300)

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

pltCplx_T <- ggplot() +
                geom_line(data = out1, aes(x = time, y = Cplx_T), color = my_palette[cid], linewidth = lw) +
                labs(title = "Cplx_T",
                    y = "Cplx_T (#/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCplx_T.png", plot = pltCplx_T, width = 4, height = 4, dpi = 300)



