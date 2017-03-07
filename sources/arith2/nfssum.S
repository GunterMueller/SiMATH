/*M
.SH NAME
nfssum - number field, sparse representation, sum
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfssum(F,a,b)  
pol F; 
nfel a, b;
   
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a, b
are elements of K, represented as univariate sparse polynomials over Q of degree < r.
.PP
nfssum returns an element of K, say c, where
.IP
c = a + b.
.PP
c is represented in the same way as a and b.   

M*/
                               
/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE nfssum        : 890501.941201
H*/
/*
	For the definition of nfssum please refer to the header file _arith2.h.
*/
