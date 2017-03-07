/*M
.SH NAME
fldif - floating point difference 

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating fldif(f,g)
floating f,g;

.SH DESCRIPTION
fldif() returns f - g.
M*/
/*H    
	Version 1       21.03.1991      Marc Conrad
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fldif         : 910715.941201
H*/
#include<_arith1.h>

floating fldif(f,g) 
	floating f,g; 
	{ 
	bind(f,g); 
	return flsum(f,flneg(g)); 
	} 
