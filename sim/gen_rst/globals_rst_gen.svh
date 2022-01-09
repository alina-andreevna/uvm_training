typedef enum {ACTIVE, PASSIVE} rst_level_t;
//---- general reports
parameter string RST_GEN_RPTS_CFG_GETTING_FAILURE = "Cannot get the configuration from uvm_config_db";
parameter string RST_GEN_RPTS_IF_GETTING_FAILURE  = "Cannot get the interface from uvm_config_db";
parameter string RST_GEN_RPTS_SQI_RND_FAILURE     = "Randomization failure, please check constraints";
parameter string RST_GEN_RPTS_SQI_CAST_FAILURE    = "Cast failure, please check types";
