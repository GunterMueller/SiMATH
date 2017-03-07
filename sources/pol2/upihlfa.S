/*M
.SH NAME
upihlfa - univariate polynomial over the integers, Hensel lemma factorization approximation

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upihlfa(p, P, L, k) 
single p, k; 
pol P; 
list L;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P
is an univariate polynomial over Z/pZ of degree > 1.   p does not divide the leading coefficient of P.
.TP 4
.B L
= ( P1, ..., Pr )
is a list, consisting of coprime univariate polynomials over Z/pZ. Except for P1, the Pi's had to be monic, and 
.IP
P = P1 * ... * Pr mod p.
.TP 4
.B k
is an integer number > 1, so that the least power of 2, which is greater or equal to k, is still a single.
.PP
upihlfa returns a list L1 = (f1, ..., fr) of univariate polynomials over the integer numbers, 
 where for 1 <= i <= r 
.IP
 fi = Pi mod p,
 P = f1 * ... * fr mod M, with M = p^k.
.PP
The factorization still holds for p^t, whereat t is the least power of 2, greater or equal to k.
.PP
The coefficients of the fi's are in [0,p^t-1].
          
M*/

/*H
	Version 1       02.03.88        J.Schmitt
	Version 2       10.05.88        reduzierte Koeffizienten f.d.Pol.
					aus L vorgeschrieben.
					P1 in reduzierter Form an upihli()
					uebergeben.          RB
	Version 3       27.02.90        llength(L) == 1 gesondert behandelt
								 J. Schmitt	
   DATE upihlfa       : 890501.900301
H*/

# include <_pol2.h>

list upihlfa(p,P,L,k)
single p,k;
pol P;
list L;
{
	pol P1,P2,A1;
	int M,p_k,lk,li;
	list L1,L2,L3;
	bind(P,L);
	init(M,p_k,lk,li,P1,P2,A1,L1,L2,L3);

	M = iexp(p,k);

	p_k = p;
	while ( icomp(M,p_k) == 1 ) { p_k = iprod(p_k,p_k); }
  
	if ( lred(L) == _0 ) {
		A1 = pitopmi(1,P,p_k);
		L2 = list1(A1);
		return(L2);
	}

	lk = lsecond(P);                         
	if ( lk != 1 ) {
		li = miinv(p_k,lk);
		P1 = pmimiprod(1,p_k,P,li);
		L3 = lcopy(L);
		A1 = pmimiprod(1,p_k,lfirst(L3),li);                
		A1 = pitopms(1,A1,p);
		lsfirst(L3,A1);
        }
	else {
		P1 = pitopmi(1,P,p_k);
		L3 = L;
	}

	L2 = upihli(p,pitopms(1,P1,p),L3);
	L1 = L3;
	A1 = list2(0,1);
  	while ( L1 != _0 ) {
		A1 = piprod(1,A1,lfirst(L1));
		L1 = lred(L1);
	}

	L2 = list3(L3,L2,A1);
	p_k = p;
	while ( icomp(M,p_k) == 1 ) {
		L2 = upihlqs(p,p_k,1,P1,lfirst(L2),lsecond(L2),lthird(L2));
		p_k = iprod(p_k,p_k);
	}
	L2 = lfirst(L2);

	if ( lk != 1 ) {
		A1 = pmimiprod(1,p_k,lfirst(L2),lk);
		lsfirst(L2,A1);
	}

	return(L2);
}
