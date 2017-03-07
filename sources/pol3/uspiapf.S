/*M
.SH NAME
uspiapf - univariate separable polynomial over the integers, approximation of p-adic factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list uspiapf(p, P, k)  
int p; 
pol P; 
single k;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P 
is a monic, separable and univariate polynomial over Z of degree greater than 1.
.TP 4
.B k
is an integer number greater than 1, such that the smallest power of 2, greater or equal to 2*k, is still a single. p^k is not allowed to divide the reduced discriminant of P (s. upireddisc).
.PP
uspiapf returns a list (f_1, ..., f_r) of univariate polynomials f_i over Z of positive degree, such that 
.PP
P = f_1 * ... * f_r mod p^(2*k).
.PP
Let P = P_1 * ... * P_s be the factorization of P over the p-adic integers, then r = s holds and, with suitable numeration, P_i = f_i mod p^(2*k).
.PP
.nf
The coefficients of the f_i are elements in 
[0, p^(2*k)-1].
        
.SH SEE ALSO
upireddisc

M*/
                           
/*H
	Version 1       12.02.90	J.Schmitt
	Version 2	03.02.93	Hensel-Faktorisierung bis 2*k.  JS
	Version 3	09.06.93	Dokumentation geaendert.	JS
	Version 3.1 	17.01.1995	U.Schneiders (p integer)
   DATE uspiapf       : 900301.9011__.9109__.9203__.930115.930531.951201
H*/

/*c
	uspiapfsubr ist ein static modul zu uspiapf.
c*/
/*H
	Version 1   	19.02.90	J.Schmitt
	Version 1.1   	17.01.1995	U.Schneiders (p integer)
H*/

#include <_pol3.h>

static list uspiapfsubr(F,mp,p,t)
pol F, mp;
int p;
single t;
{

	list M,B,B2,Bl,M1,M1H;
	single n,wy,ent4,r,i,e,d;
	rat va,vb,vc;
	int na,k,l;
	int pp,p2,MOD,R2,Q;
	pol U,G,H,y;
	pol a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb;
	bind(F,mp,p);
	init(M,B,B2,Bl,M1,M1H,va,vb,vc,na,k,l,pp,p2,MOD,R2,Q,U,G,H,y);
	init(a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb);

	Q  = iexp(p,t);	
	ent4 = 1;
	n = lfirst(F);
	U = list3(1,1,1);
	G = pitopmi(1,F,p);
	G = pmiquot(1,p,G,mp);
	H = piprod(1,mp,G);
	H = pidif(1,F,H);
	H = piiquot(1,H,p);
	H = pitopmi(1,H,p);
	G = upmigcd(p,G,H);

	if ( lfirst(G) == 0 ) return(_0);                

	wy = 1;
	y = 0;
	if ( lred2(mp) == _0 ) {
		a0 = list5(1,1,1,0,-1);
		mpa0 = list4(1,1,0,1);
	}
	else {
		a0 = U;
		mpa0 = mp;
	}

	for ( ; ; ) {
	    for ( ; ; ) {
		if ( ent4 == 1 ) {
			na = lfirst(mpa0);
			na = n / na;
			if ( na == 1 ) {
				y  = 0;
				wy = 1;
			}
			if ( na == wy ) return(_0);                

			va = ippnferegip(F,p,Q,a0,mpa0,&a1,&a2);
			i = rden(va);
			if ( i == na ) return(_0);                   

			pp = p;
			sqrem(0,i,wy,&d,&r);
			if ( r != 0 ) {
			       alb = ippnfeidpvip(F,p,a0,a2,i,y,wy,&y,&wy);
			}
			else {
				if ( i == 1 ) pp = iprod(p,p);
				if ( rnum(va) == 1 ) break;
				alb = cdprsum(a0,a2);
			}
		}
		ent4 = 1;
		mpa0 = infepptfip(F,p,Q,pp,a0,alb);
		alb=lsecond(mpa0);
                if (llength(mpa0)==2) mpa0=lfirst(mpa0);
		else {
			M = lred2(mpa0);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = uspiapfsubr(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list1(M1);
			M1 = lfirst(M);
			M = uspiapfsubr(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp(M1,M1H);
			else M1H = lconc(M,M1H);
			return(M1H);
		}
		a0 = alb;
	    }

	    y = a2;
	    wy = rden(va);
	    clb = list3(1,0,1);
	    B = list2(U,a0);
	    B = oibasisfgen(F,B);
	    B = cdprlfcdmar(B);
	    p2 = iprod(p,p);
	    b0 = nfeexpspec(F,a2,wy,p2);
	    b0 = cdpriquot(b0,p);
	    if ( modielemtest(B,b0) == 0 ) {
		a1 = a2;
		pp = p;
		MOD = 1;
	    }
	    else {
		B = list1(a0);
		B = oibasisfgen(F,B);
		B = cdprlfcdmar(B);
		B2 = B;
		MOD = 1;
		while ( B2 != _0 ) {
			Bl = lfirst(B2);
			B2 = lred(B2);
			MOD = iprod(MOD,lthird(Bl));
		}
		p2 = ilcm(pp,MOD);
		a1 = cdprzmodhom(a1,p2);
		pp = p;
		p2 = ilcm(p,MOD);
		p2 = iprod(p2,p);
		b0 = nfeexpspec(F,a1,wy,p2);
		b0 = cdpriquot(b0,p);
	    }

	    for ( ; ; ) {
		mpb0 = infepptfip(F,p,Q,p,a0,b0);
		b1=lsecond(mpb0);
                if (llength(mpb0)==2) mpb0=lfirst(mpb0);
		else {
			M = lred2(mpb0);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = uspiapfsubr(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list1(M1);
			M1 = lfirst(M);
			M = uspiapfsubr(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp(M1,M1H);
			else M1H = lconc(M,M1H);
			return(M1H);
		}
		p2 = ilcm(p,MOD);
		b0 = cdprzmodhom(b0,p2);
		alb = cdprsum(a0,b0);
		i = lfirst(mpa0);
		r = lfirst(mpb0);
		sqrem(0,i,r,&i,&r);
		if ( r != 0 ) {
			ent4 = 0;
			break;
		}
		vb = ippnferegip(F,p,Q,b0,mpb0,&b1,&b2);
		i = rden(va);
		r = rden(vb);
		sqrem(0,i,r,&i,&r);
		if ( r != 0 ) {
			i = rden(va);
			r = rden(vb);
			alb = ippnfeidpvip(F,p,a0,a2,i,b2,r,&y,&wy);
			ent4 = 0;
			break;
		}
		B2 = infepptfip(F,p,Q,p,a0,alb);
		Bl=lsecond(B2);
                if (llength(B2)==2) B2=lfirst(B2);
		else {
			M = lred2(B2);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = uspiapfsubr(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list1(M1);
			M1 = lfirst(M);
			M = uspiapfsubr(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp(M1,M1H);
			else M1H = lconc(M,M1H);
			return(M1H);
		}
		R2 = iprod(Q,MOD);
		e = iavalint(p,R2);
		l = na * e;
		l = l - 1;
		p2 = idif(p,1);
		do {
			k = l;
			l = isum(l,na);
			l = idif(l,p2);
			p2 = iprod(p2,p);
		} while ( icomp(l,k)>0 );
		B2 = itor(k);
		Bl = itor(n);
		B2 = rquot(B2,Bl);
		l = rceil(B2);
		k = lfirst(mpa0);
		k = iprod(k,l);
		p2 = iexp(p,k);
		blb = nfeexpspec(F,b0,p2,R2);
		p2 = ilcm(p,MOD);
		blb = cdprzmodhom(blb,p2);
		B2 = pineg(1,lred(b0));
		lsred(b0,B2);
		B2 = cdprsum(blb,b0);
		c0 = nfeprodspec(F,B2,clb,0);
		mpc0 = list2(1,1);

		vc = ippnferegip(F,p,Q,c0,mpc0,&c1,&c2);
		p2 = rfloor(vc);
		p2 = isum(p2,1);
		p2 = iexp(p,p2);
		R2 = ilcm(p2,MOD);
		c0 = cdprzmodhom(c0,R2);
		i = rden(va);
		r = rden(vc);
		sqrem(0,i,r,&i,&r);
		if ( r != 0 ) {
			i = rden(va);
			r = rden(vc);
			alb = ippnfeidpvip(F,p,a0,a2,i,c2,r,&y,&wy);
			ent4 = 0;
			break;
		}

		B2 = rquot(vc,va);
		k = rnum(B2);
		clb = nfeexpspec(F,a1,k,R2);

		b0 = list3(1,0,p2);
		do {
			B2 = pigcdcf(1,F,lred(clb),&Bl,&R2);
			if ( lfirst(B2) ) clb = cdprsum(clb,b0);
		} while ( lfirst(B2) );

		Bl = cdprinv(F,clb);
		/*R2 = intpp(p,MOD);*/
		R2 = iavalint(p,MOD);
		R2 = iexp(p,R2);
		R2 = iquot(MOD,R2);

		p2 = lfirst(Bl);
		Bl = lred(Bl);
		/*p2 = intpp(p,p2);*/
		p2 = iavalint(p,p2);
		p2 = iexp(p,p2);

		Bl = piiprod(1,Bl,R2);
		Bl = lcomp(p2,Bl);

		b0 = nfeprodspec(F,c0,Bl,0);
	    }
	}
}

list uspiapf(p,P,k)
int p;
pol P;
single k;
{
	single l;
	int M;
	pol P1,A1,A3;
	list L1,L2,L3,L4;
	bind(p,P);
	init(M,P1,A1,A3,L1,L2,L3,L4);

	P1 = pitopmi(1,P,p);	
	L3 = upmicfacts(p,P1);
	L1 = _0;
	L4 = _0;
	while ( L3 != _0 ) {
		A1 = lfirst(L3);
		L3 = lred(L3); 
		L4 = lcomp(A1,L4);
		l  = lfirst(L3);
		L3 = lred(L3);
		if ( l != 1 ) A1 = pmiexp(1,p,A1,l);
		L1 = lcomp(A1,L1);
	}
	L3 = linv(L1);
	L4 = linv(L4);
               
	l  = 2 * k;
	M  = iexp(p,l);
	L2 = upihlfaip(p,P,L3,l);
        
	L1 = _0;
	while ( L2 != _0) {
		A1  = lfirst(L2);
		A1  = pitopmi(1,A1,M);
		L2  = lred(L2);
		A3  = lfirst(L4);
		L4  = lred(L4);
		L3  = uspiapfsubr(A1,A3,p,k);
		if ( L3 == _0 ) L1 = lcomp(A1,L1);
		else		L1 = lconc(L3,L1);
	}

	return(L1);
}
