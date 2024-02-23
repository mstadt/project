# Driver file for running model_PD
# Run the model
library(deSolve)
library(ggplot2)
library(RColorBrewer)
#library(gridExtra)

# get relevant functions
source("setparams.r")
source("model_PD.r")
source("initconds.r")

# get initial condition
IC <- unlist(IC_PD())

# get parameters
pars <- params_PD()

# simulation time
t0 = 0 # start time
tf = 500 # final time (days)
times = seq(t0,tf,1)

# set up model
mod <- list(init = IC,
                params = pars,
                model = model_PD)

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

pltNt <- ggplot() +
        geom_line(data = out1, aes(x = time, y = Nt), colour = my_palette[cid], linewidth = lw) + # plot TumorT from out
        labs(title = "Tumor cells", # title
                y = "N_t (cells)") + # ylabel
        theme_bw() +
        theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotNt.png", plot = pltNt, width = 4, height = 4, dpi = 300)


pltCmplx <- ggplot() +
        geom_line(data = out1, aes(x = time, y = Cmplx), colour = my_palette[cid], linewidth = lw) + # plot TumorT from out
        labs(title = "Complex", # title
                y = "Cmplx") + # ylabel
        theme_bw() +
        theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCmplx.png", plot = pltCmplx, width = 4, height = 4, dpi = 300)

pltNe <- ggplot() +
        geom_line(data = out1, aes(x = time, y = Ne), colour = my_palette[cid], linewidth = lw) + # plot TumorT from out
        labs(title = "CART cells", # title
                y = "Ne (cells)") + # ylabel
        theme_bw() +
        theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotNe.png", plot = pltNe, width = 4, height = 4, dpi = 300)


