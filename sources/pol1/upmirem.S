/*M
.SH NAME
upmirem - univariate polynomial over modular integers remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmirem(M, P1, P2)  
int M; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B M
 is an integer number, M > 0.
.TP 4
.B P1, P2
 are univariate polynomials over Z/(M*Z).
 The leading coefficient of P2 is an unit in Z/(M*Z).
.PP
upmirem returns the remainder on dividing P1 by P2. 

M*/

/*H
	Version 1       24.07.91	J.Schmitt
   DATE upmirem       : 910915
H*/

#include <_pol1.h>

pol upmirem(ip,P1,P2)
int ip;
pol P1, P2;
{
	single e2, e2s, d;
	pol P3, P3S, P2S, H;
	int k3, k2s, f2;
	bind(ip,P1,P2);
	init(P3,P3S,P2S,H,k3,k2s,f2);

	if (!P1) return(0);
	
	P3 = lcopy(P1);
	e2 = lfirst(P2);

	if ( pdegree(1,P3) >= e2 ) {
	  if ( llength(P2) == 2 ) {
		do { P3 = lred2(P3); } 
		while ( P3 != _0 && lfirst(P3) >= e2 );
	  }
	  else {
	    P2 = lred(P2);
	    f2 = miinv(ip,lfirst(P2));
	    P2 = lred(P2);
	    while (P3 != _0  &&  lfirst(P3) >= e2) {
	      d  = lfirst(P3)-e2;
	      P3 = lred(P3);
	      k3 = miprod(ip,lfirst(P3),f2);
	      P3S = P3;
	      P2S = P2;
	      while (P2S != _0) {
		  e2s = lfirst(P2S)+d;
		  P2S = lred(P2S);
		  k2s = lfirst(P2S);
		  P2S = lred(P2S);
	          while (lred(P3S)!=_0 && lsecond(P3S)>e2s) P3S=lred2(P3S);
		  if (   lred(P3S)!=_0 && lsecond(P3S) == e2s) {
			H = lthird(P3S);
			k2s = midif(ip,H,miprod(ip,k2s,k3));
			if (k2s) {
				P3S = lred2(P3S);
				lsfirst(P3S,k2s);
		  	}
		  	else {
				H = lred3(P3S);
				lsred(P3S,H);
			}
		  }
		  else {
			H = mineg(ip,miprod(ip,k2s,k3));
			H = lcomp2(e2s,H,lred(P3S));
			lsred(P3S,H);
			P3S = lred2(P3S);
		  }
	      }
	      P3 = lred(P3);
	    }
	  }
	  if (P3 == _0) P3 = 0;
	}

	return(P3);
} 
