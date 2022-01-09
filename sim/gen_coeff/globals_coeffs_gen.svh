import    pkg_fir::*;
  
parameter coeffs_t DEFAULT_COEFFS = '{0,0,0,0,0,0,0,0,0};
//---- general reports
parameter string UVC_COEFFS_RPTS_CFG_GETTING_FAILURE = "Cannot get the configuration from uvm_config_db";
parameter string UVC_COEFFS_RPTS_IF_GETTING_FAILURE  = "Cannot get the interface from uvm_config_db";
parameter string UVC_COEFFS_RPTS_SQI_RND_FAILURE     = "Randomization failure, please check constraints";
parameter string UVC_COEFFS_RPTS_SQI_CAST_FAILURE    = "Cast failure, please check types";
