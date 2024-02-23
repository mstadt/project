model_PKPD <- function(t,y,params) {
    # Model equations for pre-clinical PK-PD model

    # variable names
    CARTe_PB <- y[1] # CARTe in blood
    CARTm_PB <- y[2] # CARTm in blood
    CARTe_T  <- y[3] # CARTe in tissue
    CARTm_T  <- y[4] # CARTm in tissue

    dydt <- c()

    with(params, {

        # Peripheral blood compartment
        # ddt_CARTe_PB
        dydt[1] <- (-K12*Vb*CARTe_PB + K21*Vt*CARTe_T)/Vb - Kel_e*CARTe_PB

        # ddt_CARTm_PB
        dydt[2] <- (-K12*Vb*CARTm_PB + K21*Vt*CARTm_T)/Vb  - Kel_m*CARTm_PB

        # Tissue compartment (Bone marror or solid tumor)
        #CplxCART = Cplx/Tumor
        Kexp = 0.1 * Kexp_max # FOR NOW.... #(Kexp_max * CplxCART) / (EC50_exp + CplxCART) 
        # ddt_CARTe_T
        dydt[3] <- (K12*Vb*CARTe_PB - K21*Vt*CARTe_T)/Vt + Kexp*CARTe_T - Rm*CARTe_T

        # ddt_CARTm_T
        dydt[4] <- (K12*Vb*CARTm_PB + K21*Vt*CARTm_T)/Vt + Rm*CARTe_T


        # list of ODES
        list(c(dydt))
    })
}