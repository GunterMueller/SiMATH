/*M
.SH NAME
ecgf2fmoplam - elliptic curve over Galois-field with characteristic 2, finding a multiple of the order of a point with the Pollard Lambda method

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecgf2fmoplam(G, a1, a2, a3, a4, a6, PL, L, N)
obj G; 
gf2el a1, a2, a3, a4, a6; 
list PL, L; 
int N;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ). 
.TP 4
.B a1, a2, a3, a4, a6
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation.
The a_i's are the coefficients of an elliptic curve (say E) in Weierstrass normal form over GF(2^n).
.TP 4
.B PL
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on the curve E. 
.TP 4
.B L
is either a list of positive integer numbers or a non negative single, which should be between 3 and 30. For L = 0, ecgf2fmoplam will use the list L = (1, 2, 2^2, ..., 2^19).
.TP 4
.B N
is a non negative integer number. For N = 0, ecgf2fmoplam will use N = sqrt(2*sqrt(2^n)). N should be of this magnitude.
.PP
ecgf2fmoplam computes with help of a technique, basing on the Pollard-Lampda method, an integer number, say M, where
.IP
M * P = O, where O denotes the neutral element of 
           the group of rational points E(GF(2^n)).  
.PP
ecgf2fmoplam returns M by success and -1 else.

.SH SEE ALSO 
 udpm2tosb
 Literature: A.K. Lenstra and H.W. Lenstra: Algorithms in 
             number theory, Technical Report of the 
             University of Chicago, May 1987.  

M*/
                                                      
/*H
	Version 1	22.04.93	Joachim Schmitt
   DATE ecgf2fmoplam  : 930531
H*/

#include<_ec2.h>

int ecgf2fmoplam(G,a1,a2,a3,a4,a6,P,L,N)
obj G;
gf2el a1,a2,a3,a4,a6;
list P,L;
int N;
{
	single i,h;
	list LZ,LP;
	int E1,E2,A;
	list Y,Z;
	bind(G,a1,a2,a3,a4,a6,P,L,N);
	init(LZ,LP,E1,E2,A,Y,Z);

	if ( issingle(L) ) {
		if( !L ) i = 20; 
		else i = L;
		LZ = _0;
		for(h=i-1;h;h--) { 
			A = iexp(2,h);
			LZ = lcomp(A,LZ);
		}
		LZ = lcomp(1,LZ);
	}
	else {	
		LZ = L;
		i  = llength(LZ);
	}
	L  = LZ;
	LP = _0;
	while ( L != _0 ) {
		E2 = lfirst(L);
		L  = lred(L);
		Z  = ecgf2mul(G,a1,a2,a3,a4,a6,E2,P);
		if (!lfirst(Z)) if (!lthird(Z)) return(E2);
		LP = lcomp(Z,LP);
	}
	LP = linv(LP);

	E1 = iexp(2,lfirst(G));
	E2 = isum(isqrt(E1),1);
	E2 = ip2prod(E2,1);
	A  = idif(E1,E2);
	if (!N) N = isqrt(E2);
	E2 = isum(E2,E1);
	Z  = ecgf2mul(G,a1,a2,a3,a4,a6,E2,P);
	if (!lfirst(Z)) if (!lthird(Z)) return(E2);

	while (N) {
		N = idif(N,1);
		if ( lred2(lfirst(Z)) == _0 ) h = mshom(i,lsecond(lfirst(Z)));
		else h = mshom(i,lred(lfirst(Z)));
		h++;
		E2 = isum(E2,lelt(LZ,h));
        	Z = ecgf2sum(G,a1,a2,a3,a4,a6,lelt(LP,h),Z);
		if (!lfirst(Z)) if (!lthird(Z)) return(E2);
	}

	A  = idif(E2,A);
	E1 = lfirst(LZ);
	Y  = lfirst(LP);
	for(;;) {
		if ( oequal(Y,Z) ) {
			E1 = idif(E1,E2);
			E1 = iabs(E1);
			return(E1);
		}
		if ( lred2(lfirst(Y)) == _0 ) h = mshom(i,lsecond(lfirst(Y)));
		else h = mshom(i,lred(lfirst(Y)));
		h++;
		E1 = isum(E1,lelt(LZ,h));
		if ( icomp(E1,A) > 0 ) return(-1);
		Y = ecgf2sum(G,a1,a2,a3,a4,a6,lelt(LP,h),Y);
		if (!lfirst(Y)) if(!lthird(Y)) return(E2);
	}
}
