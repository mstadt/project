model_PKPD <- function(t,y,params) {
    # Model equations for pre-clinical PK-PD model

    # variable names
    CARTe_PB <- y[1] # CARTe in blood
    CARTm_PB <- y[2] # CARTm in blood
    CARTe_T  <- y[3] # CARTe in tissue
    CARTm_T  <- y[4] # CARTm in tissue
    Cplx     <- y[5] # CAR-Target Complexes
    Tumor    <- y[6] # tumor size

    dydt <- c()

    with(params, {

        # Peripheral blood compartment
        # ddt_CARTe_PB
        dydt[1] <- (doseCART -K12*Vb*CARTe_PB + K21*Vt*CARTe_T)/Vb - Kel_e*CARTe_PB

        # ddt_CARTm_PB
        dydt[2] <- (-K12*Vb*CARTm_PB + K21*Vt*CARTm_T)/Vb  - Kel_m*CARTm_PB

        # Tissue compartment (Bone marrow or solid tumor)
        if ((CARTe_T + CARTm_T) > 0) {
        CplxCART = Cplx / (CARTe_T + CARTm_T)
        Kexp = (Kexp_max * CplxCART) / (EC50_exp + CplxCART)
        } else {
            Kexp = 0
        }
        # ddt_CARTe_T
        dydt[3] <- (K12*Vb*CARTe_PB - K21*Vt*CARTe_T)/Vt + Kexp*CARTe_T - Rm*CARTe_T

        # ddt_CARTm_T
        dydt[4] <- (K12*Vb*CARTm_PB + K21*Vt*CARTm_T)/Vt + Rm*CARTe_T

        # Cplx
        f_CART = (CARTe_T + CARTm_T) * Ag_CAR - Cplx
        f_Ag   = Tumor * Ag_TAA - Cplx
        # ddt_Cplx
        dydt[5] <- Kon_CAR * f_CART * f_Ag - Koff_CAR * Cplx

        # Tumor
        CplxTumor = Cplx/Tumor
        Kkill = (Kkill_max * CplxTumor) / (KC50_Kill + CplxTumor)

        # if (t <= 0) {
        #     Kkill = 0
        #     Kg_tumor = 0
        # }
        # ddt_Tumor
        dydt[6] <- Kg_tumor * Tumor - Kkill * CARTe_T * Tumor


        # list of ODES
        list(c(dydt))
    })
}