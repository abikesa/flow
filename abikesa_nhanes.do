//cls
if 1 {
   nhanes_fena, ys(2013) ye(2018) mort	
   di "Y"
   *table1_fena
}
if 0 {
	riagendr mortstat
	ridreth1
	seqn ridageyr permth_int permth_exm
}
if 1 {
	g years=permth_exm/12
    stset years, fail(mortstat==1)
    label define Race ///
       1 "Mexican" ///
       2 "Hispanic" ///
       3 "White" ///
       4 "Black" ///
       5 "Asian"
    label values ridreth1 Race 
}
if 1 {
	sts graph, ///
    by(ridreth1) ///
    fail ///
    per(100) ///
    ti("Mortality") ///
    ylab(0(3)12, ///
       format(%2.0f) ///
    ) ///
    xlab(0(1)7) ///
    xti("Years") ///
    yti("%", orientation(horizontal)) ///
    caption("Source: NHANES",size(2)) ///
    legend(on ///
       ring(0) ///
	   pos(11) ///
	   lab(1 "Mexican") ///
	   lab(2 "Hispanic") ///
	   lab(3 "White") ///
	   lab(4 "Black") ///
	   lab(5 "Asian") ///
	   order(3 4 1 2 5) ///
    )
   graph export mortality_race.png, replace 
}

if 1 {
   stcox i.ridreth1
}

ds