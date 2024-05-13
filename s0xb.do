qui {
global repo https://github.com/abikesa/flow/raw/main/
import delimited "${repo}b.csv", clear 
rename (beta1 beta2 beta3)(donor nondonor genpop)
mkmat donor nondonor genpop, matrix(b)
matrix list b
matrix define SV = (1, 0, 0) 
matrix loghr = SV*b'
import delimited "${repo}s0.csv", clear
g f0 = (1 - s0)*100
g f1 = f0*exp(loghr[1,1])
sum f1 if _t < 12
//Segev, JAMA, 2010
noi di "Donor mortality at 12-year follow-up:" r(max) "%" 
#delimit;
line f1 _t if inrange(_t,1,15), 
    sort 
	connect(step step) 
	ylab(0(10)40, 
	    format(%2.0f)
	) 
	xlab(0(3)15)
	yti("%")
	xti("Years")
	;
#delimit cr
}
