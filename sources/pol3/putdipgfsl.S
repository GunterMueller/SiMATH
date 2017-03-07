/*M
.SH NAME
putdipgfsl - put distributive polynomial over Galois-field with single characteristic list
(MACRO)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single putdipgfsl(r, p, AL, PL, VL, Vgfs)  
single r, p;
list AL, PL, VL, Vgfs;
      
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).              
.TP 4
.B PL
is a list of distributive polynomials, say P1,....,Pm, in r variables over GF(p^n).
.TP 4
.B VL 
is the list of variables names, used by the polynomials in PL (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).
.PP
putdipgfsl writes PL to stdout in the shape 
.IP
{P1#, ..., Pm#}
.PP
and returns 0 by success and ERROR else.

.SH SEE ALSO
.nf
gfsalgen
pmakevl

M*/

/*H
	Version 1	30.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdipgfsl    : 931130.941201
H*/
/*
	For the definition of putdipgfsl please refer to the header file _pol3.h.
*/
