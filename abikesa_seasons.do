* Document session using .log file

capture log close 
log using abikesa_nhanes.log, replace 

* Setting timeout to 10000 milliseconds
set timeout1 10000 

* Comment indicating external data source  
//global repo "https://github.com/muzaale/got/raw/main/act_5/act_5_9/"

* Actual loading of data
//use ${repo}donor_live_keep.dta, clear
use donor_live_keep, clear

* Change directory and load the dataset
//cd "~/dropbox/1f.ἡἔρις,κ/1.ontology"


if 1 {
	
	* Recode donor relationship and race variables
    recode don_relation (1/4=1)(5/999=0), gen(related)
    recode don_race (8=1)(16=2)(2000=3)(64=4)(24/1500 .=5), ///
	    gen(racecat)
    
	* Create year and month variables based on donation recovery date
    gen year = year(don_recov_dt)
    gen month = month(don_recov_dt)
    
	* Tabulate donations by year
    tab year 
	
	* Tabulate month and calculate the June-to-January ratio
    tab month, matcell(cellvalues)
    local freq_jan = cellvalues[1,1]
    local freq_jun = cellvalues[6,1]
    local ratio = `freq_jun' / `freq_jan'
    di `ratio'
    
	* Create a constant variable 'count' and recode 'month' for summer vs. rest of the year
    gen count = 1
    recode month (1/5 9/12=0)(6/8=1), gen(summer)
	
}

    
* Currently deactivated by 'if 0': but more efficient than "collapse"
if 0 { 

	* Count donations by year and by month-year
    egen n_month = count(don_recov_dt), by(year month summer related)
    
}

* We have individual-level data to this point
* Preserve the original dataset
preserve
    collapse (count) donations=pers_id, by(summer)
    di (donations[2]/3)/(donations[1]/9) //back-of-envelope irr
restore 
preserve 
    * Collapse the data by year, month, summer, and relation
    collapse (count) donations=pers_id, by(year month summer related)
	
	* Generate and save graphs for related and unrelated donors
    twoway ///
	    (scatter donations year if related==1)  ///
		(lowess donations year if related==1, ///
		   legend(off) ///
		   xlab(1990(10)2020) ///
		   xti("") ///
		 )
	graph save related.gph, replace  
    twoway ///
	    (scatter donations year if related==0)  ///
		(lowess donations year if related==0, ///
		   legend(off) ///
		   xlab(1990(10)2020) ///
		   xti("") ///
		 )
	graph save unrelated.gph, replace 
	
	* Combine graphs and save as PNG
	graph combine related.gph unrelated.gph, ///
	    ycommon  ///
		ti("Number of living kidney donors per month")
	graph export donations_years.png, replace 
    
	* Save the collapsed data to a temporary file
    tempfile aggregated_data
    save `aggregated_data'
restore 

* Merge the aggregated count back to the individual-level data
merge m:1 year month summer related using `aggregated_data'

* Now, you've both group-level and individual-level variables as predictors
* Run the single-level Poisson model first to get starting estimates
poisson donations summer related, irr iter(5)

* Capture the estimates for future use
matrix start_vals = e(b)

if 0 {

* Placeholder for setting initial estimates
matrix list start_vals  * To check the starting values before using them

* Run multilevel Poisson model using initial estimates
mepoisson donations || summer:, irr from(start_vals) iter(3)

}

log close 