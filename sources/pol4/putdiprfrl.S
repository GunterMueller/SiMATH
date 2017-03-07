/*M
.SH NAME
putdiprfrl - put distributive polynomial over rational functions over the rationals list
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol4.h>

single putdiprfrl(r1, r2, PL, VL1, VL2) 
single r1, r2; 
list PL, VL1, VL2;

.SH DESCRIPTION
.TP 4
.B r1,r2
are integral numbers, 0 <= r1, r2 < BASIS.
.TP 4
.B VL1, VL2
are list of r1 or r2 variables names, respectively (s. pmakevl).
.PP
Let X_1, ..., X_r2 be the variables names of VL2, and let F denote the function field Q(X_1, ..., X_r2).
.TP 4
.B PL
is a list of distributive polynomials in r1 variables over F.
.PP
putdiprfrl writes PL to stdout in the shape
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.  

M*/
          
/*H
	Version 1	30.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdiprfrl    : 931130.941201
H*/
/*
	For the definition of putdiprfrl please refer to the header file _pol4.h.
*/
