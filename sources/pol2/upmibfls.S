/*M
.SH NAME
upmibfls - univariate polynomial over modular integers Berlekamp factorization, last step

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmibfls(p, P, B, d)  
int p; 
pol P; 
list B; 
single d;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an univariate monic and square-free polynomial over Z/pZ of degree > 1.
.TP 4
.B B
= (B1, ..., Br) ; for r > 1;
 is a list of univariate and monic polynomials, 
 especially B1 = 1.
 The Bi's form a basis of the vector space of all 
 polynomials C with deg(C) < deg(P) so that 
.IP
    P divides C^p - C.
.TP 4
.B d
is an integer number, 0 < d < BASIS, so that P has no irreducible factor of degree < d.
.PP
upmibfls returns a list, consisting of all monic and irreducible factors of P with positive degree.   

M*/

/*H
	Version 1	30.07.91	J.Schmitt
   DATE upmibfls      : 910915
H*/

# include <_pol2.h>

list upmibfls(ip,P,B,d)
int ip;
pol P;
list B;
single d;
{
	single k,r,i,e,f,s;
	int r1;
	pol B1,A1,C,c,Bz;
	list L,L1,L2,Lz;

	bind(ip,P,B);
	init(r1,B1,A1,C,c,Bz,L,L1,L2,Lz);

	L = list1(P);
	r = llength(B);
	if ( r == 1 ) return(L);

	B = lred(B);
	k = 1;
	c = list2(0,1);
	do {
		L1 = _0;
		B1 = Bz = lfirst(B);
		B  = lred(B);
		Lz = upmibfzm(ip,r,P,Bz);
		do {
		    A1 = lfirst(L);
		    L  = lred(L);
		    e  = lfirst(A1);
		    if ( e > d ) {
			s  = 0;
			L2 = Lz;
			do {
				r1 = lfirst(L2);
				L2 = lred(L2);
				if ( r1 ) {
					r1 = mineg(ip,r1);
					c  = list2(0,r1);
					B1 = pmisum(1,ip,c,Bz);
				}
				else B1 = Bz;
				C = upmigcd(ip,A1,B1);
				f = lfirst(C);
				if ( f > 0 ) {
				    if ( f == e ) s = 1;
				    else {
					L1 = lcomp(C,L1);
					A1 = pmiquot(1,ip,A1,C);
					k  = k + 1;
					if ( k == r ) {
					    L1 = lcomp(A1,L1);
					    L  = lconc(L1,L);
					    return(L);
					}
					e = lfirst(A1);
					if ( e == d ) s = 1;
				    }
				}
			} while ( L2 != _0 && s != 1 );
		    }
		    L1 = lcomp(A1,L1);
		} while ( L != _0 );
		L = L1;
	} while ( s != 2 );
}
