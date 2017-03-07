/*M
.SH NAME
pmsupmsrem - polynomial over modular singles univariate polynomial over modular singles remainder, (recursive)
 
.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmsupmsrem(r, m, P1, P2) 
single r, m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r 
is an integer number, 0 <= r < BASIS.
.TP 4
.B m
is a prime number, 0 < m < BASIS.
.TP 4
.B P1
is a polynomial in r variables over Z/mZ.
.TP 4
.B P2
is an univariate polynomial over Z/mZ, P2 != 0.
.PP
pmsupmsrem returns the remainder on dividing P1 by P2. 

M*/

/*H
	Version 1	08.05.95	Wolfgang Schwarz
   DATE pmsupmsrem    : 951201
H*/

#include <_pol1.h>

pol pmsupmsrem(r,m,P,F)
single r,m;
pol P, F;
{pol R;
 single e;
 list L;
   bind(P,F);
   init(R,L);

   if (!r) R = P;
   else if (r==1) R = upmsrem(m,P,F);
   else {r--;
	 L = _0;
	 while (P != _0) 
	  { e = lfirst(P);
	    R = lsecond(P);
	    P = lred2(P);
	    R = pmsupmsrem(r,m,R,F);
	    if (R) L = lcomp2(R,e,L);
	  }
	 R = linv(L);
	 if (R == _0) R = 0;
	}
   return(R);
} 
			

	 
