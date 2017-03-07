/*M
.SH NAME
rquot - rational number quotient 

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rquot(R,S)
rat R,S;

.SH DESCRIPTION
rquot() returns R / S for S!=0.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE rquot         : 890501.941201
H*/
#include <_arith1.h>
rat rquot(R,S) 
	rat R, S; 
	{ 
	bind(R,S); 
	return ((R)?rprod(R,rinv(S)):0); 
	} 
