/*M
.SH NAME
pgf2efe - polynomial over Galois-field with characteristic 2 embedding in field extension
(recursive)

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol pgf2efe(r, GmtoGn, P)  
single r; 
list GmtoGn; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r 
is an integer number, 0 < r < BASIS.
.TP 4
.B GmtoGn
describes the embedding of a finite field of char-   acteristic 2 with 2^m elements in a field extension with 2^n (m divides n) elements (s. gf2ies).
.TP 4
.B P
is a polynomial in r variables over GF(2^m).
.PP
pgf2efe returns the embedding of P in GF(2^n).
       
.SH SEE ALSO
gf2ies

M*/
            
/*H
	Version  1      07.10.1993      S.Schmitt/U.Schneiders
   DATE pgf2efe       : 931130
H*/
 
#include <_pol4.h>

pol pgf2efe( r,GmtoGn,P)
single r;
list GmtoGn;
pol P;
{ 
	pol Q;
	obj a;
	single e;
	init(Q, a);
	bind(GmtoGn,P);


/* P gleich 0 */

	if (P == 0) Q = 0;

/* r gleich 0 */

	else if (r == 0)     Q=gf2efe(GmtoGn,P);

/* allgemeiner Fall: P,r ungleich 0*/

	else 
	{ 	r--;
		Q = _0;
		while(P!=_0) 
		{ 	e = lfirst(P);
			a = lsecond(P);
			P = lred2(P);
			a = pgf2efe(r,GmtoGn,a);
			if(a)   Q = lcomp2(a,e,Q);
		}
		if(Q==_0)  Q=0;
		else  Q = linv(Q);
	}
	return(Q);
}
