params_PD <- function() {
    # Set parameters for the PD model
    list(
        MV = 1e-6, # media volume in L (GUESSED)
        K_on_CAR = 7.1e4*(60*60*24)/(6.023e23), # (1/Molar/sec conv to 1/#/L/day) binding affinity of CAR to TAA (Tab 1, PD mod)
        K_off_CAR = 2.39e-3*(60*60*24), # (1/sec convert to 1/day) dissociation rate of CAR to TAA (Tab 1, PD mod)
        Ag_CAR = 15000, # numbers/CARTcell, overall density of CARs on CAR-T cells (Tab 1, PD mod)
        Ag_tumor = 222, # JeKo value (TODO: try others), (Tab 1, PD mod)
        Kkill_max = 0.353, # 1/hour # maximum rate of killing of tumor cells by CAR-T cells (Tab 1, PD mod)
        KC50_CART = 2.24, # (number/cell) (Tab 1, PD mod)
        DT_tumor = 26, # (hour), doubling time of tumor cells (Tab 1, PD mod, JeKo value)
        DT_CART = 24 # (hour), double time of CART cells
    )
}

params_preclin_PKPD <- function() {
    # set parameters for preclinical PK-PD model
    list(
        K12         = 20304, # (1/day) distribution rate from blood to bone marrow compartment
        Vb          = 0.944, # (mL) blood volume
        K21         = 0.3288, # (1/day) redistribution rate from bone marrow to blood compartment
        Vt          = 0.151, # (mL) volume of tumor compartment (or bone marrow?)
        Kel_e       = 113, # (1/day) elimination rate of effector CARTe (tab 1)
        Kel_m       = 0.219, # not given in pre-clin PKPD....this is from other part...
        Kexp_max    = 0.9168, # (1/day) max rate of CART cells expansion
        EC50_exp    = 1.15, # (num/day) 50 max for maximum rate of CART cell expansion
        Rm          = 0.00002, # guess from Tab 1...
        Ag_CAR      = 15000, # Table 1
        Ag_TAA      = 12590, # Table 1
        Kkill_max   = 0.612, # Table 1
        KC50_Kill   = 2.24, # Table 1
        Kon_CAR     = 7.1e4 * (60*60*24)/(6.023e23), # table 1 (convert to 1/#/L/day)
        Koff_CAR    = 2.39e-2*(60*60*24),  # table 1 (convert to 1/day)
        Kg_tumor    = 0.0888 # first order growth rate
    )
}

params_clin_PKPD <- function() {
    # set parameters for clinical PK-PD model
    list(
        K12         = 1.71, #20304, # (1/day) distribution rate from blood to bone marrow compartment
        Vb          = 5, # (L) #0.944, # (mL) blood volume
        K21         = 0.176, #0.3288, # (1/day) redistribution rate from bone marrow to blood compartment
        Vt          = 3.65, # (L) #0.151, # (mL) volume of tumor compartment (or bone marrow?)
        Kel_e       = 113, # (1/day) elimination rate of effector CARTe (tab 1)
        Kel_m       = 0.219, # not given in pre-clin PKPD....this is from other part...
        Kexp_max    = 1.73, #0.9168, # (1/day) max rate of CART cells expansion
        EC50_exp    = 10, #1.15, # (num/day) 50 max for maximum rate of CART cell expansion
        Rm          = 0.00002, # guess from Tab 1...
        Ag_CAR      = 15000, # Table 1
        Ag_TAA      = 12590, # Table 1
        Kkill_max   = 0.343, #0.612, # Table 1
        KC50_Kill   = 2.24, # Table 1
        Kon_CAR     = 7.1e4 * (60*60*24)/(6.023e23), # table 1 (convert to 1/#/L/day)
        Koff_CAR    = 2.39e-2*(60*60*24),  # table 1 (convert to 1/day)
        Kg_tumor    = 0.008 #0.0888 # first order growth rate
    )
}

fixed_params <- function() {
    Kon_orig = 7.103E+4  # 1/M/s
    Koff_orig = 2.385e-3 # 1/s
    # fixed parameters for model
    list(
        Vb=5, # blood volume (L)
        Vt=3.65, # tissue volume (L)
        Kon=Kon_orig*(60*60*24)/(6.023e23), # 1/#/L/Day
        Koff = Koff_orig*(60*60*24), # 1/Day
        Density_TAA = 12590, # also 10000 # Approximate TAA per BCMA positive cells in circulation
        Density_CAR = 15000,  # Lentivirus transduction-based CAR-density assessment ( a value needs to be updated)
        Kgtumor0 = 0.008,
        IC50 = 2.24 # from .doc
    )
}


varied_params <- function() {
    list(
        # Inputs
        Kexp_max = 1.73, # Table 1 PKPD mean #0.9168, # Table 1 mean
        EC50 = 10, # Table 1 PKPD mean#1.15, # Table 1 mean
        rm = 0.00002, # Table 1 PKPD mean
        K12 = 1.71, # Table 1 PKPD mean #20304, # Table 1 
        K21 = 0.176, # Table 1 PKPD mean #0.3288, # Table 1 mean (note changes elsewhere to 0.176)
        Kel_e = 113, # Table 1 mean PKPD
        Kel_m = 0.219, # Table 1 mean PKPD
        Kkill_max0 = 0.343 # Table 1 mean PKPD
    )
}



# TODO: 
#  - make a function that puts the varied params and fixed params together