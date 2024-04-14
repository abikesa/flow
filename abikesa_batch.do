clear 
set obs 100
g age = rnormal(40,15)
hist age
graph export age.png, replace 