/*M
.SH NAME
miindidl - modular integers individual discrete logarithm

.SH SYNOPSIS
.nf
#include<_arith2.h>

int miindidl(P, a, b, S, L, HB) 
int P, b, HB; 
single a; 
list S, L;

.SH DESCRIPTION
.TP 4
.B P
is a prime number.
.TP 4
.B a
is a primitive root modulo P (a in S1, s. below).
.TP 4
.B b 
is an integer numbers, 1 < b < P.
.PP
There exist integer numbers, say n and m, so that for 
.IP
M := exp((1+(1/n)) * sqrt(log P * loglog P)).
.IP
M[1/2] := sqrt(M) = M^(1/2), and
.IP
M[1/2 + eps] := M^(1/2 + 1/m), 
.IP
S1 = {p_1, ... p_r} = {q prime | q < M[1/2]}, where p_i < p_{i+1},
.IP
S2 = {H+1, H+2, ..., H+c}, where H = floor(sqrt(P))+1 and c = floor(M[1/2 + eps]) holds.
.TP 4
.B S
= S1 U S2 = {p_1, ... p_r, H+1, ... H+c}.  
.TP 4
.B L
contains the discrete logarithms of the elements in S.
.TP 4
.B HB
= M^2 (higer bound).
.PP
miididl returns an integer number, say I, where 0 < I < P, and 
.IP
a^I = b 
.PP
holds.
   
M*/

/*H
	Version 1	15.09.94	Joachim Schmitt
   DATE miindidl      : 941201
H*/

#include<_arith2.h>

int miindidl(P,a,b,S,L,HB)
int P;
single a;
int b;
list S,L;
int HB;
{
	int I,q,M;
	list F,S2,L2;
	single w,e;

	init(I,q,M,F);
	bind(P,b,S,L,HB);

	for(w=1;;w++) {
		I  = iexp(a,w);
		I  = iprod(I,b);
		I  = mihom(P,I);
		F  = _0;
		S2 = S;
		while(S2!=_0) {
			q  = lfirst(S2);
			S2 = lred(S2);
			e  = 0;
			while(!irem(I,q)) {
				I = iquot(I,q);
				e++;
			}
			if(e) {
				F = lcomp(q,F);
				F = lcomp(e,F);
			}
			if( I==1 ) break;
		}
		S2 = lfirst(S)+1;
		if(I==1) break;
		S2 = ifact(I);
		q  = lfirst(llast(S2));
		if(icomp(q,HB)>0) continue;
		while(S2!=_0) {
			q  = lfirst(S2);
			S2 = lred(S2);
			e  = 0;
			while(!irem(I,q)) {
				I = iquot(I,q);
				e++;
			}
			F  = lcomp(q,F);
			F  = lcomp(e,F);
			while(S2!=_0) {
				if(!icomp(q,lfirst(S2))) S2 = lred(S2);
				else break;
			}
		}
		if(I==1) break;
	}
	F = linv(F);

	q  = idif(P,1);
	I  = mineg(q,w);
	S2 = S;
	L2 = L;
	M  = lfirst(F);
	while(S2!=_0) {
		if(!icomp(M,lfirst(S2))) {
			F = lred(F);
			w = lfirst(F);
			F = lred(F);
			I = misum(q,I,miprod(q,w,lfirst(L2)));
			if(F==_0) {
				for(e=llength(S2);e;e--) L2 = lred(L2);
				break;
			}
			else M = lfirst(F);
		}
		S2 = lred(S2);
		L2 = lred(L2);
	}
	HB = iroot(HB,4,&w);
	while(F!=_0) {
		M = lfirst(F);
		F = lred(F);
		w = lfirst(F);
		F = lred(F);
		M = sufindindlog(P,M,S,L,HB);
		I = misum(q,I,miprod(q,w,M));
	}
	return(I);
}

int sufindindlog(P,M,S,L,HB)
int P,M,HB;
list S,L;
{
	int q,y,y2,v,v2,V,z,z2,I,I2;
	list S2,L2;
	bind(P,M,S,L,HB);
	init(q,y,y2,v,v2,V,z,z2,I,I2);

	q = idif(P,1);
	v = iroot(P,2,&V);
	v = isum(v,1);
	V = isum(v,HB);
	y = iquot(v,M);
	if(!y) y = 1;
	for(;;y=isum(y,1)) {
		y2 = y;
		S2 = S;
		L2 = L;
		I  = 0;
		while(S2!=_0) {
			z2 = lfirst(S2);
			S2 = lred(S2);
			while(!irem(y2,z2)) {
				y2 = iquot(y2,z2);
				I  = midif(q,I,lfirst(L2));
			}
			L2 = lred(L2);
		}
		if(y2==1) {
			for(v2=isum(v,1);icomp(V,v2)>=0;v2=isum(v2,1)) {
				z  = iprod(v2,y);
				z  = iprod(z,M);
				z  = mihom(P,z);
				z2 = z;
				S2 = S;
				L2 = L;
				I2 = 0;
				while(S2!=_0) {
					y2 = lfirst(S2);
					S2 = lred(S2);
					while(!irem(z2,y2)) {
						z2 = iquot(z2,y2);
						I2 = misum(q,I2,lfirst(L2));
					}
					L2 = lred(L2);
				}
				if(z2==1) {
					break;
				}
			}
			if(z2==1) break;
		}
	}
	I = misum(q,I,I2);
	while(S!=_0) {
		S = lred(S);
		L = lred(L);
	}
	V = iroot(P,2,&z2);
	V = isum(V,2);
	V = idif(v2,V);
	for(;V--;L=lred(L));
	I = midif(q,I,lfirst(L));
	return(I);
}
