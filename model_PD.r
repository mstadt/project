model_PD <- function(t,y,params) {
    # Model equations for cell-level PD model

    # variable names
    Cmplx <- y[1] # number of CAR-Target complexes per tumor cells (unitless?)
    Nt <- y[2] # number of tumor cells (cells) in a media volume
    Ne <- y[3] # number of CART cells in a media volume

    dydt <- c()

    with(params, {

        # Cmplx
        # ddt_Cmplx
        dydt[1] <- K_on_CAR * (Ag_CAR - Cmplx) * (Ag_tumor - Cmplx) - K_off_CAR * Cmplx

        # Tumor cells
        # ddt_Nt
        SF = 1e9 / (6.023e23) # scaling factor
        CplxCell = (Cmplx * MV) / (SF * Nt)
        Kill = (Kkill_max * CplxCell)/(KC50_CART + CplxCell)
        dydt[2] <- log(2)/DT_tumor * Nt - Kill * Nt

        # CAR-T cells
        # ddt_NE
        dydt[3] <- log(2)/DT_CART * Ne

        # list of ODES
        list(c(dydt))
    })
}