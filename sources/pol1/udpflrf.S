/*M
.SH NAME
udpflrf - univariate dense polynomial over floating point numbers root finding  (MACRO)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single udpflrf(P, sort, pROOTS)
pol P;
single sort;
list *pROOTS;

.SH DESCRIPTION
udpflrf() computes all real and complex roots of 
the polynomial P over floating point numbers.
See the documentation of udprf() for a complete description.

.SH SEE ALSO
udprf, lflbsort, flinit
M*/


/*H
	Version 1	27.12.1994	Th. Weis
   DATE udpflrf       : 951201
H*/
/*
	For the definition of udpflrf please refer to the header file _pol1.h.
*/

