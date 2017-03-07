/*M
.SH NAME
itoc - integer to complex number  (MACRO)

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex itoc(A)
int  A;

.SH DESCRIPTION
itoc() returns the value of the integer A
as a complex number a + b*i with b=0.
The relative error is at most:
.PP
| ( A - a ) / A | < 1/2 * (2^30)^( 1 - FL_EPS )
M*/

/*H    
	Version 1       22.12.1993      S.Schmitt/U.Schneiders
   DATE itoc          : 951201
H*/
/*
	For the definition of itoc please refer to the header file _arith1.h.
*/
