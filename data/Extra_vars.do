clear
set more off

cd "/Users/VK/Google Drive/Thesis/Production Sharing and Development/Data/Controls/"

use exp_imp_34_new, clear
drop imports_ams_ik imports_ams_k-nat_res_exp_t_3 avg_nat_res_exp_sha_t_3-natres_exprtr_5
drop if y==2009|y==2010

bys isic year: egen exports_i=total(exports_ik)
bys year: egen exports=total(exports_ik)

gen trca=(exports_ik/exports_k)/(exports_i/exports)
keep c is y n t

merge m:1 ctry year using WDI_GDPPC_constant_newest.dta
drop if _m==2
drop _m g l m h

merge m:1 ctry year using "/Users/VK/Google Drive/WB Consultancy/Work/Data/Source data/WEO_controls.dta"
drop if _m==2
drop _m

outsheet using "/Users/VK/Documents/Github/OECD-TiVA-LMIC-GVCs/data/Extra_vars.csv", comma noquote replace
