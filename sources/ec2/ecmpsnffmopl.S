/*M
.SH NAME
ecmpsnffmopl - elliptic curve over modular primes, short normal form, finding a multiple of the order of a point with the Pollard Lambda method

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecmpsnffmopl(p, a4, a6, PL, L, N)  
int p, a4, a6, N; 
list PL, L;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p > 37.
.TP 4
.B a4, a6
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ.
.TP 4
.B PL
is a list of three elements of Z/pZ, defining a point, say P, on E in projective representation.
.TP 4
.B L
is either a list of positive integer numbers or a non negative single, which should be between 3 and 30. For L = 0, ecmpsnffmopl will use the list L = (1, 2, 2^2, ..., 2^19).
.TP 4
.B N
is a non negative integer number. For N = 0, ecmpsnffmopl will use N = sqrt(2*sqrt(p)). N should be of this magnitude.
.PP
ecmpsnffmopl computes with help of a technique, basing on the Pollard-Lampda method, an integer number, say M, where
.IP
M * P = O, with O being the neutral element of the 
           group of rational points E(Z/pZ).   
.PP
ecmpsnffmopl returns M by success and -1 else.

.SH SEE ALSO
A.K. Lenstra and H.W. Lenstra: Algorithms in number 
 theory, Technical Report of the University of Chicago, 
 May 1987. 

M*/

/*H
	Version 1 	14.01.93	Joachim Schmitt
   DATE ecmpsnffmopl  : 930531
H*/

#include<_ec2.h>

int ecmpsnffmopl(p,a,b,P,L,N)
int p, a, b;
list P;
list L;
int N;
{
	single i,h;
	list LZ,LP;
	int E1,E2,A;
	int x1,x2,y1,y2,z1,z2;
	bind(p,a,b,P,L,N);
	init(LZ,LP,E1,E2,A,x1,x2,y1,y2,z1,z2);

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
		z2 = ecmpsnfmul(p,a,b,E2,P);
		if (!lfirst(z2)) if (!lthird(z2)) return(E2);
		LP = lcomp(z2,LP);
	}
	LP = linv(LP);

	E2 = isqrt(p);
	E2 = isum(E2,1);
	E2 = ip2prod(E2,1);
	A  = idif(p,E2);
	if (!N) N = isqrt(E2);
	E2 = isum(E2,p);
	
	z2 = ecmpsnfmul(p,a,b,E2,P);
	if (!lfirst(z2)) if (!lthird(z2)) return(E2);
	z1 = lfirst(z2);
	z2 = lsecond(z2);

	while (N) {
		N = idif(N,1);
		h = mshom(i,z1);
        	h++;
		E2 = isum(E2,lelt(LZ,h));
		x1 = lfirst(lelt(LP,h));
		x2 = lsecond(lelt(LP,h));
        	ecmpsnfsums(p,a,b,&x1,&x2,&z1,&z2);
		if (z1==-1) if (z2==-1) return(E2);
	}
	
	A  = idif(E2,A);
	E1 = lfirst(LZ);
	y1 = lfirst(lelt(LP,1));
	y2 = lsecond(lelt(LP,1));
	for(;;) {
		if ( icomp(y1,z1) == 0 ) if ( icomp(y2,z2) == 0 ) {
			E1 = idif(E1,E2);
			E1 = iabs(E1);
			return(E1);
		}
		h = mshom(i,y1);
		h++;
		E1 = isum(E1,lelt(LZ,h));
		if ( icomp(E1,A) > 0 ) return(-1);
		x1 = lfirst(lelt(LP,h));
		x2 = lsecond(lelt(LP,h));
		ecmpsnfsums(p,a,b,&x1,&x2,&y1,&y2);        	
		if (y1==-1) if(y2==-1) return(E2);
	}
}
