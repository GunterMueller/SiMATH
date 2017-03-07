/*M
.SH NAME
nfsneg - number field, sparse representation, negation
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfsneg(F,a)  
pol F; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a
is an element of K, represented as univariate sparse polynomial over Q of degree < r.
.PP
nfsneg returns the additive inverse of a, which is represented in the same way as a.
   
M*/
                        
/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE nfsneg        : 890501.941201
H*/
/*
	For the definition of nfsneg please refer to the header file _arith2.h.
*/
