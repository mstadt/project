IC_prePKPD <- function() {
    # Initial conditions for pre-clinical PKPD model
    list(
        CARTe_PB = 0, # SHOULD BE DOSE WHEN I GET THERE (or do LSODA events process...)
        CARTm_PB = 0, # from supp mat
        CARTe_T  = 1e-12, # needs to be nonzero to prevent numerical issues with tumor growth...
        CARTm_T  = 0, # from supp mat
        Cplx     = 0, # from supp mat
        Tumor    = 1e5 # tumor size (Tab 1)
    )
}

IC_clinPKPD <- function() {
    # Initial conditions for pre-clinical PKPD model
    list(
        CARTe_PB = 0, # SHOULD BE DOSE WHEN I GET THERE (or do LSODA events process...)
        CARTm_PB = 0, # from supp mat
        CARTe_T  = 1e-6, # needs to be nonzero to prevent numerical issues with tumor growth...
        CARTm_T  = 0, # from supp mat
        Cplx     = 0, # from supp mat
        Tumor    = 1e5 # tumor size (Tab 1)
    )
}

IC_PD <- function() {
    # Initial conditions for PD model
    list(
        Cmplx = 0, # number of CAR-Target Complexes per tumor cells
        Nt = 1e5, # cells, tumor cells
        Ne = 0 # cells, CAR-T cells (unsure see Eq. 3 of supp mat)
    )
}

init_conds <- function(){
    # Initial conditions for MOnolix
    list(
        CARTe_PB = 0, # effector cell pool concentration in blood (cells/L)
        CARTm_PB = 0, # memory cell pool concentration in blood (cells/L)
        CARTe_T = 1e-6, # effector cell pool concentration in tissue (cells/L)
        CARTm_T = 0, # memory cell pool concentration in tissues (cells/L)
        Cplx_T = 0, # complex in bone marrow (#/L)
        Tumor_T = 1e5 #2.5e9 # tumor in bone marrow (cells/L)
    )
}
