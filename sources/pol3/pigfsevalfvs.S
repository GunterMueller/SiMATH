/*M
.SH NAME
pigfsevalfvs - polynomial over integers Galois-field with single characteristic element evaluation first variable special version
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pigfsevalfvs(r, p, AL, P)  
single r, p; 
list AL; 
pol P;
           
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a polynomial over Z in r variables.
.PP
.PP
Let F denotes the finite field determined by AL and let f denotes the generating element of F.
.PP
pigfsevalfvs returns a polynomial in r-1 variables over F, which arises by the substitution of the first variable found in the list of variable names belonging to P by f.

.SH SEE ALSO
gfsalgen

M*/
        
/*H
	Version 1	03.06.93	S.Schmitt
   DATE pigfsevalfvs  : 931130
H*/


#include <_pol3.h>

pol pigfsevalfvs(r,p,AL,P)
single r,p;
list AL;
pol P;
{	obj k, e;
	pol Q;
	init( k, e, Q );	
	bind( AL, P );

/* P gleich 0 */

	if (P == 0) Q = 0;

/* r gleich 1 */

	else if (r == 1) 
	{	AL=lfirst(AL);
		Q=pmsrem(1,p,pitopms(1,P,p),AL);
	}

/* allgemeiner Fall: P ungleich 0, r ungleich 1*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0)
	 	{ 	e = lfirst(P);
			k = lsecond(P);
			P = lred2(P);
			k = pigfsevalfvs(r,p,AL,k);
			if(k)   Q = lcomp2(k,e,Q);
		}
		if(Q==_0)  Q=0;
		else  Q = linv(Q);
	}

/* Ausgabe */

	return(Q);
}	
