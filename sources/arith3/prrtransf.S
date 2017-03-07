/*M
.SH NAME
prrtransf - polynomial over the rationals rational transformation

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc prrtransf(r1, P1, V1, r2, R2, V2, pV3) 
single r1, r2; 
pol P1; 
list V1, V2, Vn, *pV3;
rfunc R2; 
    
.SH DESCRIPTION
.TP 4
.B r1
is an integer number, 0 < r1 < BASIS.
.TP 4
.B r2
is an integer number, 0 <= r2 < BASIS.
.TP 4
.B P1
is a polynomial in r1 variables over the rational numbers.
.TP 4
.B R2
is a rational function in r2 variables over the rational numbers.
.TP 4
.B V1, V2
are lists of variables names used by P1, R2 resp..
.TP 4
.B Vn
is a variable name of V1.
.PP
prrtransf returns the function R, which arises from the substitution of Vn in P1 by R2.
.PP
The list of variables names used by R ( the union of V1 and V2 ), will be alphabetized and stored in *pV3.
   
M*/
               
/*H
	Version 1       19.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE prrtransf     : 890501
H*/


#include <_arith3.h>

rfunc prrtransf(r1,P1,V1,r2,R2,V2,Vn,pV3)
single r1;
pol P1;
list V1;
single r2;
rfunc R2;
list V2;
list Vn;
list *pV3;
{
	rfunc R3;

	bind(P1,R2,V1,V2,Vn);
	init(R3);


	P1 = prtorfr(r1,P1);
	R3 = rfrtransf(r1,P1,V1,r2,R2,V2,Vn,pV3);

	return(R3);
}
