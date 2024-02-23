model_eqns <- function(t,y,params) {
    # Model equations
    # These model equations are based on the monolix code...

    # variable names
    CARTe_PB <- y[1] # effector cell pool concentration in blood (cells/L)
    CARTm_PB <- y[2] # memory cell pool concentration in blood (cells/L)
    CARTe_T <- y[3] # effector cell pool concentration in tissue (cells/L)
    CARTm_T <- y[4] # memory cell pool concentration in tissues (cells/L)
    Cplx_T <- y[5] # complex in bone marrow (#/L)
    Tumor_T <- y[6] # tumor in bone marrow (cells/L)

    dydt <- c()
    
    with(params, {

        # Peripheral blood (PB)

        # ddt_CARTe_PB
        dydt[1] <- (-K12*Vb * CARTe_PB + K21 *Vt*CARTe_T)/Vb - Kel_e * CARTe_PB
        
        # ddt_CARTm_PB
        dydt[2] <- (-K12*Vb * CARTm_PB + K21*Vt* CARTm_T)/Vb  - Kel_m * CARTm_PB

        # Tissues (T)
        CAR_T = (CARTe_T+ CARTm_T) * Density_CAR - Cplx_T  # free CAR in tissue
        TAA_T = Tumor_T * Density_TAA - Cplx_T # free tumor associated antigen tissue
        CplxPCART_T= Cplx_T / (CARTe_T + CARTm_T)  
        # ddt_CARTe_T
        dydt[3] <- (K12 *Vb* CARTe_PB - K21 *Vt* CARTe_T)/Vt +(Kexp_max* CplxPCART_T/ (EC50 + CplxPCART_T)) * CARTe_T - rm  * CARTe_T

        # ddt_CARTm_T
        dydt[4] <- (K12 *Vb* CARTm_PB - K21 *Vt* CARTm_T)/Vt + rm  * CARTe_T

        # ddt_Cplx_T
        dydt[5] <- Kon * CAR_T * TAA_T - Koff * Cplx_T  

        # Tumor dynamics
        if (t <= 0) {
            Kg_tumor = 0
            Kkill_max = 0
        } else {
            Kg_tumor = Kgtumor0
            Kkill_max = Kkill_max0
        }
        CplxPTumor_T= Cplx_T / Tumor_T  
        # ddt_Tumor_T
        dydt[6] <- Kg_tumor * Tumor_T  -  (Kkill_max * (CplxPTumor_T) / (IC50 + (CplxPTumor_T))) * Tumor_T 

        # list of ODES
        list(c(dydt))
    })


}