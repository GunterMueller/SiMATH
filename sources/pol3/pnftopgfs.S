/*M
.SH NAME
pnftopgfs - polynomial over number field to polynomial over Galois field with single characteristic
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnftopgfs(r, p, AL, P) 
single r, p; 
list AL; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4              
.B p
is a prime number, p < BASIS.
Let K be a number field and let H be the generating polynomial of K, then
.TP 4
.B AL 
is the arithmetic list of a finite field, say F, of characteristic p, such that the generating polynomial of F mod p divides H. (If H mod p squarefree, F is the residue class field of K at a prime spot over p).
.TP 4
.B P
is a polynomial in r variables over K.     
.PP
If the coefficients of P are coprime to p, pnftopgfs returns the regarding polynomial of P over the residue class field, and else, pnftopgfs returns ERROR.
    
M*/
 
/*H
	Version 1	21.03.95	Wolfgang Schwarz
   DATE pnftopgfs     : 951201
H*/

#include <_pol3.h>

gfel pnftopgfs(r,p,AL,G)
single r,p;
list AL;
pol G;
{nfel x;
 list H;
 single e;
	init(x,H);
	bind(AL,G);

	if (!G) return(0);
	if (!r) return(nftogfs(p,AL,G));

	r--;
	for (H=_0;G!=_0;G=lred(G))
	  {	e = lfirst(G);
		G = lred(G);
		x = pnftopgfs(r,p,AL,lfirst(G));
		if (x==ERROR) return(ERROR);
		if (x) H = lcomp2(x,e,H);
	  }
	H = linv(H);
	if (H==_0) H=0;
	return(H);
}	
