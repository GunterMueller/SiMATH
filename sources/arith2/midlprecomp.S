/*M
.SH NAME
midlprecomp - modular integers discrete logarithms, precomputation for fixed primitive root

.SH SYNOPSIS
.nf
#include<_arith2.h>

matrix midlprecomp(P, a, n, m)  
int P; 
single a; 
int n, m;
 
.SH DESCRIPTION
.TP 4
.B P
is a prime number.
.TP 4
.B a
is a primitive root modulo P.
.TP 4
.B n, m 
are integer numbers.
.TP 4
Let
L := exp((1+(1/n)) * sqrt(log P * loglog P)).  
.IP
L[1/2] := sqrt(L) = L^(1/2), and 
.IP
L[1/2 + eps] := L^(1/2 + 1/m).
.PP 
Furthermore, 
.TP 4
let
S1 := {p_1, ... p_r} = {q prime | q < L[1/2]}, where p_i < p_{i+1}, a must be in S1. 
.IP
S2 := {H+1, H+2, ..., H+c}, where H = floor(sqrt(P))+1 and c = floor(L[1/2 + eps]).
.IP
S := S1 U S2 = {p_1, ... p_r, H+1, ... H+c}. 
.PP
midlprecomp returns a matrix, say MA, with |S| columns and |S| + |S|^(1/3) rows.(For P > 10^20, MA can be assumed to have full rank.)
.PP
Every row
 (e_1, ..., e_r, 0, ..., 0, 1, 0, ..., 0, 1, 0, ..., 0), or
 (e_1, ... e_r, 0, ..., 0, 2, 0, ..., 0) of MA represents an equation of the shape
.PP
 ( (H+c1) * (H+c2) ) mod P = p_1^(e_1) * ... * p_r^(e_r), with 0 < c1 <= c2 <=c.  
M*/
                           
/*H
	Version 1	15.09.94	Joachim Schmitt
   DATE midlprecomp   : 941201
H*/

#include<_arith2.h>

matrix midlprecomp(P,a,n,m)
int P;
single a;
int n;
int m;
{
	list S,S2;
	matrix Ma;
	vec V,V2;
	rat eps; 
	floating ree,L;
	int I,G,H,J,K,qff,P_1;
	single y,y2,q,qf,d,c1,c2,f,vl,i,j,anz_pz,zei_ma,anz_gl,neu_start;
	bind(P,n,m);
	init(S,S2,Ma,V,V2,eps,ree,L,I,G,H,J,K,qff,P_1);

	P_1 = idif(P,2);
/* Berechnung relevanter Groessen wie L, H, J, y = L[1/2] und y2 = L[1/2+eps] */
  neu_start = 0;
  while(llength(_0)==0) {
	L   = itofl(P);
	ree = fllog(L);
	ree = flprod(ree,fllog(ree));
	ree = flsqrt(ree);
	L   = itor(1);
	L   = rsum(L,list2(1,m));
	L   = flprod(ree,rtofl(L));
	L   = flexp(L);
	H   = isqrt(P);
	H   = isum(H,1);
	J   = iprod(H,H);
	J   = idif(J,P);
	ree = flsqrt(L);
	y   = flfloor(ree);
	if (y<=a) y = a+1;
	eps = list2(1,n);
	ree = rsum(eps,list2(1,2));
	ree = rtofl(ree);
	ree = flpow(L,ree);
	y2  = flfloor(ree);
	if(!issingle(y2)) {
/*		printf("\n Primzahl P oder epsilon zu gross !!"); */
		exit(0);
	}
	if(y2<y) y2=y;
	if(neu_start) {
		for(i=0;i<neu_start;i++) {
			y  = 2*y;
			y2 = 2*y2;
		}
	}

/* Bilden der Primzahlliste S = {p prim | p < y} */

	d = 0;
	S = _0;
	while(++d<=y) if(issprime(d,&c1)==1) S=lcomp(d,S);
	anz_pz = llength(S);
	zei_ma = anz_pz + y2;
	d = iroot(zei_ma,3,&c1);
	zei_ma = zei_ma + d;

/* Bestimmen der ersten Gleichung */

	V = S;
	d = 1;
	while(V!=_0) {
		if(a==lfirst(V)) break;
		d++;
		V = lred(V);
	}
/*	if(V==_0) printf("\n a keine Primzahl aus Primzahlliste S.\n"); */
	
	V = _0;
	for(c1=0;c1<y2;c1++) V=lcomp(0,V);
	for(c1=1;c1<d;c1++) V=lcomp(0,V);
	V = lcomp(1,V);
	d = anz_pz-d;
	for(c1=0;c1<d;c1++) V=lcomp(0,V);
	anz_gl = 1;
	Ma = list1(V);

/* Sammeln von Gleichungen */

	for(c1=1;c1<=y2;c1++) {
		I  = isum(H,c1);
		G  = iprod(H,c1);
		G  = isum(G,J);
		G  = ineg(G);
		V  = _0;
		for(q=0;q<y2;q++) V = lcomp(0,V);

		S2 = S;
		while(S2!=_0) {
			q  = lfirst(S2);
			S2 = lred(S2);
			d  = miinv(q,mihom(q,I));
			if(!d) continue;
			ree = itofl(q);
			ree = fllog(ree);
			f  = 1;
			qf = q;
			while(llength(_0)==0) {
				d  = miprod(qf,d,mihom(qf,G));
				if(!d) d = qf;
				V2 = V;
				vl = y2;
				vl = vl-d;
				vl = iquot(vl,qf);
				vl++;
				qff = iprod(qf,q);
				for(j=1;j<d;j++) V2 = lred(V2);
				c2 = d;
				for(i=1;i<=vl;i++) {
					if(c1<=c2) {
						L = lfirst(V2);
						if(icomp(y,qff)>0) {
							L = flsum(L,ree);
						}		
						else {
							K = miprod(P,c2,I);
							K = idif(K,G);
							K = mihom(P,K);
							K = iaval(q,K);
							K = K-f;
							K++;
							if(K>0) {
								K = itofl(K);
								K = flprod(ree,K);
								L = flsum(L,K);
							}
						}
						lsfirst(V2,L);
					}
					if(i<vl) for(j=0;j<qf;j++) V2=lred(V2);
					c2 += qf;
				}
				if(icomp(y,qff)>0) {
					qf = qff;
					d  = miinv(qf,mihom(qf,I));
					f++;
				}
				else break;
			} /* Festes q, variables f. */
		} /* Arbeite PZ-Liste S durch. */

		for(i=1;i<c1;i++) V=lred(V);
		c2  = c1;
		eps = rtofl(list2(37,19)); /* 37/19 < 2 = min S */
		eps = fllog(eps);
		V2  = _0;
		while(V!=_0) {
			ree = lfirst(V);
			V   = lred(V);
			if(ree) {
				K = miprod(P,c2,I);
				K = idif(K,G);
				K = mihom(P,K);
				K = itofl(K);
				K = fllog(K);
				K = fldif(K,eps);
				if (flcomp(ree,K)>0) V2 = lcomp(c2,V2);
			}
			c2++;
		}
		while(V2!=_0) {
			c2 = lfirst(V2);
			V2 = lred(V2);
			K  = miprod(P,c2,I);
			K  = idif(K,G);
			K  = mihom(P,K);
			if (K==1) continue;
			L  = ifact(K);
			K = lfirst(llast(L));
			if(K>y) {
/* printf("\n Fuer c1 = %d und c2 = %d gilt (H+c1)*(H+c2) > 2*P.\n",c1,c2); */
				continue;
			}
			L  = ifel(L);
/* printf("\n FE-Liste zu c1=%d, c2=%d : ",c1,c2); putli(L); printf("\n"); */
			V = _0;
			for(i=1;i<c1;i++) V = lcomp(0,V);
			if(c1==c2) V = lcomp(idif(P,3),V);
			else {
				V = lcomp(P_1,V);
				for(i++;i<c2;i++) V = lcomp(0,V);
				V = lcomp(P_1,V);
			}
			for(i++;i<=y2;i++) V = lcomp(0,V);
			V  = linv(V);
			S2 = S;
			while (S2!=_0) {
				if(L==_0) {
					for(;S2!=_0;S2=lred(S2)) V=lcomp(0,V);
					break;
				}
				j = lfirst(L);
				L = lred(L);
				i = lfirst(S2);
				S2 = lred(S2);
				while(i!=j) {
					i  = lfirst(S2);
					S2 = lred(S2);
					V  = lcomp(0,V);
				}
				V = lcomp(lfirst(L),V);
				L = lred(L);
			}
/* printf("\n Zugehoeriger Vektor : "); putli(V); printf("\n"); */
			Ma = lcomp(V,Ma);			
			anz_gl++;
			if(anz_gl>=zei_ma) break;
		}
		if(anz_gl>=zei_ma) break;
	} /* Nehme neues c1, bis genuegend Gleichungen gefunden sind. */
	if(anz_gl<zei_ma) {
		neu_start++;
	}
	else break;
  } /* Grosse while-Schleife, falls y2 zu klein "vermutet" wurde. */
  return(Ma);
}
