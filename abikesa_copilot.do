//create log file
capture log close
log using abikesa_copilot.log, replace 

//simulate dataset
/* clear  */
/* set obs 1000 */
set seed 123
gen x=rnormal()

log close 