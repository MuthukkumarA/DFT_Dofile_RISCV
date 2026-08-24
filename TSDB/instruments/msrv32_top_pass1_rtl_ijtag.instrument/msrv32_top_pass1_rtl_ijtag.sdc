#--------------------------------------------------------------------------
#
#  Unpublished work. Copyright 2021 Siemens
#
#  This material contains trade secrets or otherwise confidential 
#  information owned by Siemens Industry Software Inc. or its affiliates 
#  (collectively, SISW), or its licensors. Access to and use of this 
#  information is strictly limited as set forth in the Customer's 
#  applicable agreements with SISW.
#
#--------------------------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2022.2
#       Created on: Tue Apr  7 17:29:57 IST 2026
#--------------------------------------------------------------------------

   
       
proc  msrv32_top_pass1_rtl_tessent_tap_main {args} {
           
  create_clock tck -period 100.0 -name tessent_tck -add
}
   
       
proc  msrv32_top_pass1_rtl_tessent_tdr_sri_ctrl {args} {
           
  create_clock ijtag_tck -period 100.0 -name tessent_tck -add
}
   
       
proc  msrv32_top_pass1_rtl_tessent_sib_1 {args} {
           
  create_clock ijtag_tck -period 100.0 -name tessent_tck -add
}
       
proc  msrv32_top_pass1_rtl_tessent_sib_2 {args} {
           
  create_clock ijtag_tck -period 100.0 -name tessent_tck -add
}
   
   
   
   
        
   
   
