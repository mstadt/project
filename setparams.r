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