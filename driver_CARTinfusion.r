# This driver runs the clinical PKPD model with an infusion
# of CART cells over 4 hours

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


# simulation time
t0 = 0 # start time
tf = 10 # final time (days)
times1 = seq(t0,tf,(tf-t0)/50)

pars1 = pars
pars1$doseCART = 0 # dose amount for starting simulation

# initial condition
IC1 = IC

# Model simulation
print('start simulation from initial condition')
out1 <- as.data.frame(lsoda(
                        y = IC1,
                        times = times1,
                        func = model_PKPD, # PKPD model
                        parms = pars1,
                        rtol = 1e-6,
                        atol = 1e-6
                        ))
print('sim 1 done')

dose_total = 150e6 # total dose
inf_hrs = 4 # hours of infusion
pars2 <- pars
pars2$doseCART = dose_total / (inf_hrs/24) # dose amount per day

t0 = tf
tf = tf + inf_hrs / 24
times2 = seq(t0,tf, (tf-t0)/10)

# get IC
end_out1 = tail(out1,n=1)
IC2 = unlist(c(end_out1['CARTe_PB'],
            end_out1['CARTm_PB'],
            end_out1['CARTe_T'],
            end_out1['CARTm_T'],
            end_out1['Cplx'],
            end_out1['Tumor']))
print('infusion simulation')
out2 <- as.data.frame(lsoda(
                        y = IC2,
                        times = times2,
                        func = model_PKPD, # PKPD model
                        parms = pars2,
                        rtol = 1e-6,
                        atol = 1e-6
                        ))
print('sim 2 done')

# No infusion
pars3 <- pars
pars3$doseCART = 0 # no more infusion
t0 = tf
tf = t0 + 10
times3 = seq(t0,tf, (tf-t0)/10)

# get IC
end_out2 = tail(out2,n=1)
IC3 = unlist(c(end_out2['CARTe_PB'],
            end_out2['CARTm_PB'],
            end_out2['CARTe_T'],
            end_out2['CARTm_T'],
            end_out2['Cplx'],
            end_out2['Tumor']))
print('post-infusion')
out3 <- as.data.frame(lsoda(
                        y = IC3,
                        times = times3,
                        func = model_PKPD, # PKPD model
                        parms = pars3,
                        rtol = 1e-6,
                        atol = 1e-6
                        ))
print('sims finished')

# Put results together
temp <- rbind(out1, out2)
out <- rbind(temp, out3)



# Plot results
print('plotting results')

# Figure specs
my_palette <- brewer.pal(5, "Dark2")
cid = 1 # color id
lw = 1.0 # linewidth


pltCARTe_PB <- ggplot() +
                geom_line(data = out, aes(x = time, y = CARTe_PB), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTe in blood",
                    y = "CARTe_PB (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTe_PB.png", plot = pltCARTe_PB, width = 4, height = 4, dpi = 300)

pltCARTm_PB <- ggplot() +
                geom_line(data = out, aes(x = time, y = CARTm_PB), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTm in blood",
                    y = "CARTm_PB (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTm_PB.png", plot = pltCARTm_PB, width = 4, height = 4, dpi = 300)

pltCARTe_T <- ggplot() +
                geom_line(data = out, aes(x = time, y = CARTe_T), color = my_palette[cid], linewidth = lw) +
                labs(title = "CARTe in tissue",
                    y = "CARTe_T (cells/L)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCARTe_T.png", plot = pltCARTe_T, width = 4, height = 4, dpi = 300)

pltCARTm_T <- ggplot() +
                geom_line(data = out, aes(x = time, y = CARTm_T), color = my_palette[cid], linewidth = lw) +
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
                geom_line(data = out, aes(x = time, y = Cplx), color = my_palette[cid], linewidth = lw) +
                labs(title = "Complex",
                    y = "Cplx") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotCplx.png", plot = pltCplx, width = 4, height = 4, dpi = 300)

pltTumor <- ggplot() +
                geom_line(data = out, aes(x = time, y = Tumor), color = my_palette[cid], linewidth = lw) +
                labs(title = "Tumor",
                    y = "Tumor (cells)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotTumor.png", plot = pltTumor, width = 4, height = 4, dpi = 300)

pltTumor2 <- ggplot() +
                geom_line(data = out2, aes(x = time, y = Tumor), color = my_palette[cid], linewidth = lw) +
                labs(title = "Tumor during infusion",
                    y = "Tumor (cells)") +
                theme_bw() +
                theme(panel.grid.major = element_line(colour = "grey", linewidth = 0.3),
                    panel.grid.minor = element_line(colour = "grey", linewidth = 0.3))

ggsave("plotTumor2.png", plot = pltTumor, width = 4, height = 4, dpi = 300)






