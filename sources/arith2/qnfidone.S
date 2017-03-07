/*M
.SH NAME
qnfidone - quadratic number field ideal one

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfidone( D )  
int D;
   
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.PP
Let O_K be the ring of integers in K, then qnfidone generates the unit ideal 
1 * O_K (for the representation of ideals s. qnfidprod) and returns 
.PP
 ( 1 1 0 1 ), for D = 2, 3 mod 4
 ( 1 2 1 2 ), for D = 1    mod 4


.SH SEE ALSO
qnfidprod

M*/

/*H
	Version 1       20.10.1993      Josef Gebel
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE qnfidone      : 931130.941201
H*/
/*
	For the definition of qnfidone please refer to the header file _arith2.h.
*/
