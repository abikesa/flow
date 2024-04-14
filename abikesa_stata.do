capture log close 
log using work/abikesa_stata.log, replace

if 0 {

// Basic (observed data)
1. c(N) and c(k)
2. ds, has(type numeric)
3. ds, has(type string)
4. Is any one of the variables a date?
5. keep one exemplar of each type
6. save dataset
7. program a table 1 & figure 1 from regression output

// Intermediate (expected data)
1. Do the observed data match the expected data?
2. How do we formally test this?
3. Is missingness "observed" or "expected"?
4. Lets decide that by modifying table 1 & figure 1 from the basics class
5. expected

// Advanced
1. Hierarchical clustering
2. Do we always have to acknowledge hierarchies in data?
3. When may we be able to ignore hierarchies in data?
4. How do we formally test this?
5. Lets roll back to the basics class and modify table 1 & figure 1

}

// Stata Programming I (Basic)
// Import data
use donor_live_keep, clear

// Dimensions of data
di "Obs: `c(N)', Vars: `c(k)'"

// Classify variables as continuous, binary, or categorical

ds, has(type numeric)
return list
ds, has(type string)
return list

// Summarize continuous variables
sum if type == "numeric"`'

// Summarize binary variables
tab if type == 1

// Summarize categorical variables
tab if type == 2

// Has labels
ds, has(vallabel)


// Stata Programming II (Intermediate)

// Stata Programming III (Advanced)
log close 
