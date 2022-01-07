`ifndef PKG_FIR 
    `define PKG_FIR

    package pkg_fir;

        parameter int fir_order = 9;
        parameter int coeff_width = 14;

        typedef logic [coeff_width-1:0] coeffs_t [fir_order-1:0];
        
    endpackage

`endif
