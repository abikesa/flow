use esrdRisk_t02tT, clear
tab donor rSMGJcEdF_d
g entry = rSMGJcEdF_t0
replace entry = d(01jan1994) if ///
    entry < d(01jan1994) & ///
	rSMGJcEdF_tT > d(01jan1994)
stset rSMGJcEdF_tT, ///
    origin(rSMGJcEdF_t0) ///
	entry(`entry') ///
	fail(rSMGJcEdF_d==2) ///
	scale(365.25) 
sts list, fail by(donor) at(5 10 15) saving(km, replace )
preserve 
    use km, clear 
	replace failure=failure*100
    sum failure if donor==1 & time==5
	local don5y: di %3.2f r(mean)
    sum failure if donor==1 & time==10
	local don10y: di %3.2f r(mean)
	sum failure if donor==1 & time==15
	local don15y: di %3.2f r(mean)
	//
    sum failure if donor==2 & time==5
	local hnd5y: di %3.2f r(mean)
    sum failure if donor==2 & time==10
	local hnd10y: di %3.2f r(mean)
	sum failure if donor==2 & time==15
	local hnd15y: di %3.2f r(mean)
	//
    sum failure if donor==3 & time==5
	local gpop5y: di %3.2f r(mean)
    sum failure if donor==3 & time==10
	local gpop10y: di %3.2f r(mean)
	sum failure if donor==3 & time==15
	local gpop15y: di %3.2f r(mean)
restore 
sts graph, ///
    by(donor) ///
    fail ///
	per(100) ///
	ylab(0(10)40, ///
	    format(%2.0f)) ///
	tmax(15) ///
	risktable(, color(stc1) group (1) ///
	    order(3 " " 2 " " 1 " ") ///
		ti("#") ///
	) ///
	risktable(, color(stc2) group(2)) ///
	risktable(, color(stc3) group(3)) ///
	legend(on ///
	ring(0) ///
	    pos(11) ///
	   order(3 2 1) ///
	   lab(3 "General population") ///
	   lab(2 "Healthy nondonor") ///
	   lab(1 "Living donor") ///
	) ///
	ti("Mortality") ///
	text(`don5y' 5 "`don5y'%", col(stc1)) ///
	text(`don10y' 10 "`don10y'%", col(stc1)) ///
	text(`don15y' 15 "`don15y'%", col(stc1)) ///
	text(`hnd5y' 5 "`hnd5y'%", col(stc2)) ///
	text(`hnd10y' 10 "`hnd10y'%", col(stc2)) ///
	text(`hnd15y' 15 "`hnd15y'%", col(stc2)) ///
	text(`gpop5y' 5 "`gpop5y'%", col(stc3)) ///
	text(`gpop10y' 10 "`gpop10y'%", col(stc3)) ///
	text(`gpop15y' 15 "`gpop15y'%", col(stc3))
