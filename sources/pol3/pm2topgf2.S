/*M
.SH NAME
pm2topgf2 - polynomial over modular 2 to polynomial over Galois-field with characteristic 2
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pm2topgf2(r, P)  
single r; 
pol P;
  
.SH DESCRIPTION
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over Z/2Z.
.PP
pm2topgf2 returns the representation of P as a polynomial over GF(2^n).

M*/
              
/*H
	Version 1	03.06.93	S.Schmitt
   DATE pm2topgf2     : 931130
H*/


#include <_pol3.h>

pol pm2topgf2(r,P)
single r;
pol P;
{ 	obj k, e;
	pol Q;
	init(k,e,Q);
	bind(P);

/* P gleich 0 */

	if (P == 0) Q = 0;

/* r gleich 0 */

	else if (r == 0) 
	{       P=list2(0,P);
		Q=udpm2tosb(P);
	}

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0)
		{ 	e = lfirst(P);
			k = lsecond(P);
			P = lred2(P);
			k = pm2topgf2(r,k);
			if(k)   Q = lcomp2(k,e,Q);
		}
		Q = linv(Q);
	}

/* Ausgabe */

	return(Q);
}
