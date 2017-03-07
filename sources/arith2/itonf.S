/*M
.SH NAME
itonf - integer to number field element
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel itonf(A)  
int A;

.SH DESCRIPTION
.TP 4
.B A
is an integer number.
.PP
itonf returns the representation of A as a number field element (for representation of number field elements s. fputnfel).

.SH SEE ALSO
fputnfel

M*/
                                
/*H
	Version 1       01.03.1989      Christine Hollinger
	Version 2       23.11.1989      itonf ist jetzt Macro.  A.Stein
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE itonf         : 890601.900315.9109__.941201
H*/
/*
	For the definition of itonf please refer to the header file _arith2.h.
*/
