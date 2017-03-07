/*M
.SH NAME
upgf2modexps - univariate polynomial over Galois-field with characteristic 2, modular exponentiation, special version

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf2modexps(G, F, m, P, pM)  
obj G; 
pol F, P; 
single m; 
matrix *pM; 
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B F
is a polynomial over GF(2^n) in the variable x, the coefficients of F are given in special bit-representation. If F != 0, F must be congruent to x^(2^m) modulo P(x) (s. below).
.TP 4
.B m
is a positive single.
.TP 4
.B P 
is a polynomial in the variable x over GF(2^n) of positive degree, the coefficients of P are given in special bit-representation.                    
.PP
upgf2modexps returns a polynomial, say R, and writes a matrix, say M, to *pM, where
.PP
for deg(P) := l = 1 or 2^m < l, M is irrelevant,
.PP
for F = 0, M is the empty list and R(x) = x^(2^m) mod P(x),
.PP
for F != 0, M is a lxl matrix (= {a_ij} (1<=i,j<=l)), with entries in GF(2^n) in special bit-representation, such that 
.PP
for 1 <= h <= l and k = (l+1)-h 
.PP 
.nf
a_1k * x^(l-1) + ... + a_lk * x^0 = x^(2^4 * (h-1)) mod P(x)
holds.
.PP
In this case, R(x) = x^((2^m)^2) mod P(x) holds.    

.SH SEE ALSO
udpm2tosb

M*/
                          
/*H
	Version 1	14.09.93	J.Schmitt
   DATE upgf2modexps  : 931130
H*/

# include <_pol3.h>

pol upgf2modexps(G,F,m,P,pM)
obj G;
pol F;
single m;
pol P;
matrix *pM;
{
	single k,w,n,l;
	pol fp, Xq, fw, fh, G1, A, B;
	list Lx;
	bind(G,F,P,*pM);
	init(fp,Xq,fw,fh,G1,A,B,Lx);

	Lx = *pM;
	fw = list2(0,1);
	n  = lfirst(P);

	
	if( n == 1 ) {
                if(llength(P)==2) return(0);
                else {
                        if (!F) fh = lfourth(P);
			else fh = lsecond(F);
			for(l=0;l<m;l++) fh = gf2squ(G,fh);
                        fh = list2(0,fh);
                        return(fh);
                }
        }
        if (!F) A = ip2prod(1,m);
       	else    A = ip2prod(1,2*m);
	if (icomp(A,n)<0) {
		fw = list2(A,fw);
		return(fw);
	}


	fp = ptodp(1,P);
       	G1 = gf2inv(G,lsecond(P));

	B  = list1(fw);
       	for(k=1;k<n;k++) B = lcomp(0,B);
       	A  = list1(B);
       	
	B  = list5(fw,0,0,0,0);
	B  = lconc(B,list4(0,0,0,0));
	B  = lconc(B,list4(0,0,0,0));
	B  = lconc(B,list4(0,0,0,0));
	if( n < 17 ) {
		Xq = lcomp(16,B);
		Xq = udpgf2remsp(G,Xq,fp,G1);
		k  = lfirst(Xq);
		B  = lred(Xq);
       		for(k++;k<n;k++) B = lcomp(0,B);
	}		
       	else for(k=17;k<n;k++) B = lcomp(0,B);
       	Xq = lcopy(B);
	A  = lcomp(B,A);

	if ( Lx == _0 ) {
       		fh = list2(16,fw);
       		fh = lconc(fh,list4(0,0,0,0));
       		fh = lconc(fh,list4(0,0,0,0));
       		fh = lconc(fh,list4(0,0,0,0));
       		fh = lconc(fh,list4(0,0,0,0));
       	
       		for(w=2;w<n;w++) {
			fh = lconc(fh,list4(0,0,0,0));
			fh = lconc(fh,list4(0,0,0,0));
			fh = lconc(fh,list4(0,0,0,0));
			fh = lconc(fh,list4(0,0,0,0));
			k  = lfirst(fh);
			k  = k + 16;
			lsfirst(fh,k);
			if( k >= n ) fh = udpgf2remsp(G,fh,fp,G1);
			k  = n - lfirst(fh); 
			for(Lx=lcopy(lred(fh));--k;Lx=lcomp(0,Lx));
			A  = lcomp(Lx,A);
       		}
		Lx = matransp(A);
	}

	if (!F) l = m/4;
	else {
		l  = m/4 + 1;
		Xq = ptodp(1,F);
		k  = lfirst(Xq);
		Xq = lred(Xq);
		for(w=n-k;--w;Xq=lcomp(0,Xq));
	}
	for(w=1;w<l;w++) {
		A = Xq;

		while( A != _0 ) { 
			B = gf2squ(G,lfirst(A));
			B = gf2squ(G,B);
			B = gf2squ(G,B);
			B = gf2squ(G,B);
			lsfirst(A,B);
			A = lred(A);
		}
		A  = Lx;
		fw = _0;
		while ( A != _0 ) {
			B = lfirst(A);
			A = lred(A);
			G1 = Xq;
			fp = 0;
			while ( B != _0 ) {
				fh = gf2prod(G,lfirst(B),lfirst(G1));
				B  = lred(B);
				G1 = lred(G1);
				fp = gf2sum(G,fp,fh);
			}
			fw = lcomp(fp,fw);
		}
		Xq = linv(fw);
	}

	k  = n - 1;
	while ( !lfirst(Xq) ) Xq = lred(Xq), k--;
	Xq = lcomp(k,Xq);
	Xq = dptop(1,Xq);
	if ( m<4 ) Xq = list2(1,list2(0,1));
	if ( m%4 ) {
		Xq = pgf2square(1,G,Xq);
		if( lfirst(Xq) >= n ) pgf2qrem(1,G,Xq,P,&Xq);
		if ( m%4 > 1 ) {
			Xq = pgf2square(1,G,Xq);
			if( lfirst(Xq) >= n ) pgf2qrem(1,G,Xq,P,&Xq);
		}
		if ( m%4 > 2 ) {
			Xq = pgf2square(1,G,Xq);
			if( lfirst(Xq) >= n ) pgf2qrem(1,G,Xq,P,&Xq);
		}
	}
	*pM = Lx;
	return(Xq);
}
