/*M
.SH NAME
putdipnfl - put distributive polynomial over number field list
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putdipnfl(r, F, PL, VL, Vnf)  
single r; 
pol F; 
list PL, VL, Vgfs;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.  
.TP 4
.B PL
is a list of distributive polynomials, say P1,....,Pm, in r variables over K.
.TP 4
.B VL
is the list of variables names, used by the polynomials in PL (s. pmakevl).
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.
.PP
putdipnfl writes PL to stdout in the shape
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.

.SH SEE ALSO
.nf         
pmakevl
              
M*/
     
/*H
	Version 1	30.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdipnfl     : 931130.941201
H*/
/*
	For the definition of putdipnfl please refer to the header file _pol3.h.
*/
