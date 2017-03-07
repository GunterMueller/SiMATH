/*M
.SH NAME
udpirf - univariate dense polynomial over integers root finding  (MACRO)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single udpirf(P, sort, pROOTS)
pol P;
single sort;
list *pROOTS;

.SH DESCRIPTION
udpirf() computes all real and complex roots of the polynomial P over integers.
See the documentation of udprf() for a complete description.

.SH SEE ALSO
udprf, lflbsort, flinit
M*/

/*H
	Version 1	27.12.1994	Th. Weis
   DATE udpirf        : 951201
H*/
/*
	For the definition of udpirf please refer to the header file _pol1.h.
*/

