interface if_coeffs_gen ();

  import pkg_fir::*;

  coeffs_t  coeffs;

  modport mst (
    output coeffs
  );

  modport slv (
    input  coeffs
  );

endinterface
