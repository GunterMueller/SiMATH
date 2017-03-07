/*M
.SH NAME
maihermltpe - matrix over integers, Hermite normal form (lower triangular form with positive entries) (MACRO)

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix maihermltpe(A)
matrix A;

.SH DESCRIPTION
maihermltpe() returns the Hermite normal form H of M,
where H is in lower triangular form with positive entries.
I.e. there is a matrix K with det(K) = +-1, H = A * K
and H has the form
.PP
.nf
(1)   hii  > 0 for i = 1..n,
(2)   hij  = 0 for i,j = 1..n, i<j,
(3)   hij  > 0 for i,j = 1..n, i>j,
(4)  |hij| < hii for i,j = 1..n, i>j
.fi


.PP
.TP 4
.B M
is a square matrix of integers with a non-zero determinant.


.SH REFERENCES
The computation is based on the "modular" algorithm of
P.D. Domich, R. Kannan and L.E. Trotter,
"Hermite Normal Form Computation Using Modulo Determinant
Arithmetic", Mathematics of Operations Research, Vol. 12, No 1, February 1987.
This ensures that no "entry explosion" occurs during the calculations.
It holds that |x| <= |det(A)| for all intermediate values x.

.SH SEE ALSO
maihermltne
M*/



/*H
	Version 1       13.12.1988      Klaus Petry
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE maihermltpe   : 890501.9107__.941201
H*/
/*
	For the definition of maihermltpe please refer to the header file _matr2.h.
*/
