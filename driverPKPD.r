# Run the model
library(deSolve)
library(ggplot2)
library(RColorBrewer)
#library(gridExtra)

# get relevant functions
source("setparams.r")
source("model_PKPD.r")
source("initconds.r")

# get initial condition
IC <- unlist(IC_prePKPD())

# get parameters
pars <- params_preclin_PKPD()

# simulation time
t0 = 0 # start time
tf = 500 # final time (days)
times = seq(t0,tf,1)

# set up model
mod <- list(init = IC,
                params = pars,
                model = model_PKPD)

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







