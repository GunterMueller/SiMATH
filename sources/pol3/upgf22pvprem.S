/*M
.SH NAME
upgf22pvprem - univariate polynomial over Galois-field with characteristic 2, 2^m-th power of variable, polynomial, remainder

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgf22pvprem(G, m, P)  
obj G; 
single m; 
pol P;
     
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4 
.B m
is s positive single.
.TP 4
.B P
is a polynomial of positive degree in the variable x over GF(2^n) with coefficients in special bit-representation.
.PP
upgf22pvprem returns a polynomial, say R, such that
.IP
R(x) = x^(2^m) mod P(x).
 
.SH SEE ALSO
udpm2tosb

M*/                                            

/*H
	Version 1	14.05.93	J.Schmitt
   DATE upgf22pvprem  : 931130
H*/

# include <_pol3.h>

pol upgf22pvprem(G,m,P)
pol G;
single m;
pol P;
{
	single k,w,n,l;
	pol fp, Xq, fw, fh, G1, A, B;
	list Lx;
	
	bind(G,P);
	init(fp,Xq,fw,fh,G1,A,B,Lx);

	n  = lfirst(P);
	if(n==1) {
		if(llength(P)==2) return(0);
		else {
			fh = lfourth(P);
			for(l=0;l<m;l++) fh = gf2squ(G,fh);
			fh = list2(0,fh);
			return(fh);
		}
	}
       	fw = list2(0,1);
       	for(w=0,l=1;w<m;w++) {l=2*l; if (n<=l) {l=0; break;}}
	if(l) {fh = list2(l,fw); return(fh);}
	
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
		Xq = list6(16,fw,0,0,0,0);
		Xq = lconc(Xq,list4(0,0,0,0));
		Xq = lconc(Xq,list4(0,0,0,0));
		Xq = lconc(Xq,list4(0,0,0,0));
		Xq = udpgf2remsp(G,Xq,fp,G1);
		k  = lfirst(Xq);
		B  = lred(Xq);
       		for(k++;k<n;k++) B = lcomp(0,B);
	}		
       	else for(k=17;k<n;k++) B = lcomp(0,B);
       	Xq = lcopy(B);
	A  = lcomp(B,A);

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

	l = m/4;
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
	return(Xq);
}
