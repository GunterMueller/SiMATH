/*M
.SH NAME
rdif - rational number difference 

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rdif(R,S)
rat R,S;

.SH DESCRIPTION
rdif() returns R - S.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE rdif          : 890501.941201
H*/

#include <_arith1.h>
rat rdif(R, S)  
	rat R, S; 
	{ 
	bind(R,S); 
	return(rsum(R,rneg(S))); 
	} 
