/*M
.SH NAME
ecmspsnfsha - elliptic curve over modular single primes, short normal form, Shanks' algorithm

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecmspsnfsha(p, a4, a6)  
single p, a4, a6;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p >= 37.
.TP 4
.B a4, a6
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ.
.PP
ecmspsnfsha computes the number of Z/pZ rational points on E via the Shank-algorithm and returns that number.
.PP
If ecmspsnfsha returns a negative number, the computation could not execute successful. 

M*/
                             
/*H
	Version 1	15.05.1991 	Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3       06.09.1991      Fehler beseitigt.  JG
	Version 4 	29.11.1991	ecmspsnfsha ist jetzt ein Macro
					und gehoert nach 'ec2.
					Dokumentation veraendert.  MP
	Version 5	18.11.94	Macro nur noch im Header definiert. MP
   DATE ecmspsnfsha   : 910715.910915.920331.941201
H*/
/*
	For the definition of ecmspsnfsha please refer to the header file _ec2.h.
*/
