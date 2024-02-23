init_conds <- function(){
    # Initial conditions
    list(
        CARTe_PB = 0, # effector cell pool concentration in blood (cells/L)
        CARTm_PB = 0, # memory cell pool concentration in blood (cells/L)
        CARTe_T = 1.0e-6, # effector cell pool concentration in tissue (cells/L)
        CARTm_T = 0, # memory cell pool concentration in tissues (cells/L)
        Cplx_T = 0, # complex in bone marrow (#/L)
        Tumor_T = 2.5e9 # tumor in bone marrow (cells/L)
    )
}
