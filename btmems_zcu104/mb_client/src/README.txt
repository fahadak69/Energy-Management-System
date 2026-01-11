Various define directives and code sections are structured based on following philosophy:


STCH_MG_ACTUAL:
Tesla Read and Write are via STCH MG PLC Enbala Interface
POI Meter data is read directly from axion meter in STCH MG

STCH_MG_HIL:
Tesla read data is directly read from Tesla model in HIL
Tesla write commands are via Enbala inerface of HIL PLC
POI Meter data is read directly from axion meter in HIL

EIT_TESLA_MEGAPACK:
Tesla read and write are via Tesla megapack model in HIL
POI Meter read is via SEL 735 meter model in HIL

STCH_MG_ACTUAL_EIT_HIL_HYBRID:
Tesla Read and Write are via STCH MG PLC Enbala Interface
POI Meter read is via SEL 735 meter model in HIL


To configure code for one of these (4) cases:

1: Define desired directive from the (4) different cases above (only one at a time), in main_defines.h  

2: Undefine ENABLE_PLC_THREAD directive in main_defines.h for EIT_TESLA_MEGAPACK case, Define it for other three cases (define it only when PLC is being used)

