//.dta -> .csv for use in ChatGPT
use donor_live_keep, clear 
export delimited using donor_live_keep.csv, replace

