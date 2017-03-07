/*M
.SH NAME
nftogfs - number field element to Galois field of single characteristic

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel nftogfs(p, AL, a) 
single p; 
list AL; 
nfel a;

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B AL
is the arithmetic list of a finite field, say K, of characteristic p. The generating polynomial of K had to be a divider modulo p of the generating polynomial, say F, of a number field (If F mod p is square free, K is the residue class field of the number field at a prime spot over p).
.TP 4
.B a 
is an element in the number field.
.PP
if the denominator of a is coprime to p, nftogfs returns the representation of a as an element in K, and ERROR else.
  
M*/
    
/*H
	Version 1	21.03.95	Wolfgang Schwarz
   DATE nftogfs       : 951201
H*/

#include <_arith2.h>

gfel nftogfs(p,AL,a)
single p;
list AL;
nfel a;
{int n;
 pol A;
	init(n,A);
	bind(AL,a);

	if (!a) return(0);
	
	n = lfirst(a);
	n = mshom(p,n);
	if (!n) return(ERROR);
	n = msinv(p,n);

	A = dptop(1,lred(a));
	A = pitopms(1,A,p);
	A = pmsrem(1,p,A,lfirst(AL));
	A = pmsmsprod(1,p,A,n);
	return(A);
}	
