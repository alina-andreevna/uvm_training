//------------------------------------------------------------------------------
//
//  *** *** ***
// *   *   *   *
// *   *    *     Quantenna
// *   *     *    Connectivity
// *   *      *   Solutions
// * * *   *   *
//  *** *** ***
//     *
//------------------------------------------------------------------------------
`ifndef GLOBALS_SVH
  `define GLOBALS_SVH

    parameter time CLK_PERIOD = 10ns;

    parameter int INPUT_DATA_WIDTH = 15;
    parameter int OUTPUT_DATA_WIDTH = 18;
    parameter coeffs_t DEFAULT_COEFFS = '{0, 1, 2, 3, 4, 5, 6, 7, 8};
  //---- general reports
    parameter string TB_RPTS_CFG_GETTING_FAILURE = "Cannot get configuration from the uvm_config_db";
    parameter string TB_RPTS_IF_GETTING_FAILURE  = "Cannot get an interface from the uvm_config_db";
    parameter string TB_RPTS_MM_GETTING_FAILURE  = "Cannot get the memory model from the uvm_config_db";
    parameter string TB_RPTS_SQI_RND_FAILURE     = "Randomization failure, please check constraints";
    parameter string TB_RPTS_SQI_CAST_FAILURE    = "Cast failure, please check types";
`endif
