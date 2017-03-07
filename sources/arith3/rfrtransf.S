/*M
.SH NAME
rfrtransf - rational function over the rationals transformation

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrtransf(r1, R1, V1, r2, R2, V2, pV3) 
single r1, r2; 
rfunc R1, R2; 
list V1, V2 *pV3;
                                               
.SH DESCRIPTION
.TP 4
.B r1
is an integer number, 0 < r1 < BASIS.
.TP 4
.B r2
is an integer number, 0 <= r2 < BASIS.         
.TP 4
.B R1, R2
are rational functions over the rational numbers in r1,  r2 variables respectively. 
.TP 4
.B V1, V2
are lists of variables names used by R1, R2 resp..
.TP 4
.B Vn
is a variable name of V1.
.PP   
rfrtransf returns the function R, which arises from the substitution of Vn in
R1 by R2.
.PP
The list of variables names used by R ( the union of V1 and V2 ), will be alphabetized and stored in *pV3.    

.SH CAUTION
If the transformation of Vn results in a denominator equal to 0, rfrtransf returns -BASIS-1.
 
M*/
          
/*H
	Version 1       15.03.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrtransf     : 890501
H*/


#include <_arith3.h>

rfunc rfrtransf(r1,R1,V1,r2,R2,V2,Vn,pV3)
single r1;
rfunc R1;
list V1;
single r2;
rfunc R2;
list V2;
list Vn;
list *pV3;
{
	list V3;
	rfunc R3;
	pol R1Z;
	bind(R1,R2,V1,V2,Vn);
	init(R1Z,R3,V3);

/* R1 gleich 0 */

	if (!R1) R3 = 0, V3 = vlsort(usunion(V1,V2),&R1);

/* R1 ungleich 0 */

	else {
		R1Z = lfirst(R1);
		R1 = lsecond(R1);
		R1 = pirtransf(r1,R1,V1,r2,R2,V2,Vn,&V3);
		if (R1) {
			R1Z = pirtransf(r1,R1Z,V1,r2,R2,V2,Vn,&V3);
			r1 = llength(V3);
			R3 = rfrquot(r1,R1Z,R1);
			}
		else R3 = -BASIS-1;
		}

/* Ausgabe */

	*pV3 = V3;
	return(R3);
}
