#define BIT_BESS_EN 				COIL_BIT_0
#define BIT_Genset_EN 				COIL_BIT_1
#define BIT_Loadbank_EN 			COIL_BIT_2

#define BIT_POIBrk_Status 			COIL_BIT_3			//ERCOT Point

#define HLD_REG_MG_CTRLMODE 		HLD_REG_0
#define HLD_REG_BESSKW_SP 			HLD_REG_1
#define HLD_REG_GensetKW_SP 		HLD_REG_2
#define HLD_REG_LoadbankKW_SP 		HLD_REG_3

#define HLD_REG_TARGET_KW 			HLD_REG_4			//ERCOT Point

//Reg 5 to 7 are reserved for future setpoints

#define HLD_REG_AGGR_KW 			HLD_REG_8								//ERCOT Point
#define HLD_REG_AGGR_KVAR 			HLD_REG_9								//ERCOT Point
#define HLD_REG_MPC_KW 				HLD_REG_10								//ERCOT Point
#define HLD_REG_LPC_KW 				HLD_REG_11								//ERCOT Point
#define HLD_REG_BESS_RRate 			HLD_REG_12								//ERCOT Point

#define	MAX_ERCOT_COMMIT			200										//Maximum ERCOT commitment
#define BESS_MAX_RSRV 				100										//Maximum BESS Reserve, must be less than MAX_ERCOT_COMMIT
#define GENSET_MAX_RSRV				(MAX_ERCOT_COMMIT - BESS_MAX_RSRV)

#define OFFSET 						5000
