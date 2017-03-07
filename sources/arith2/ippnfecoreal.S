/*M
.SH NAME
ippnfecoreal - integral p-primary number field element, core algorithm

.SH SYNOPSIS
.nf
#include<_arith2.h>

list ippnfecoreal(F, p, Q, mp)  
pol F, mp; 
single p; 
int Q;   
    
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers.
.TP 4
.B p
is a single prime number.
.TP 4
.B Q
is a power of p, the product of Q and an arbitrary element in a p-maximal overorder of the polynomial order of F is in the polynomial order.      
.PP
Let the unknown of F be denoted by x, and let u be an element of A, with
.IP
u = x mod (F) is p-primary.
.TP 4
.B mp
is the p-minimal poylnomial of u, i.e. mp is the unique (modulo p) prime polynomial divisor of the minimal polynomial of u.
.PP
ippnfecoreal returns a list, say M, whereat M contains either one element, a CD matrix, whose rows are the coefficients lists of CD polynomials, representing elements  in A, which form an integral basis of the p-maximal over order of the polynomial order of F (s. cdprfcl and cdmarid);
.PP
or M contains two lists, say M = (Lfact, Lort), whereat
.TP 4
Lfact
is a list, containing two univariate and monic polynomials (say f1 and f2) over the integer numbers, so that
.IP
F = f1 * f2 modulo Q^2 holds.
.TP 4
Lort
is a list, containing two CD-polynomials over the rational number (say e1, e2), representing two elements in A, so that
.IP
e1 * e2 = 0 modulo Q^2 * Z[u],
.IP
e1 + e2 = 1 modulo Q^2 * Z[u], and
.IP
e1 and e2 are modulo Q^2 * Z[u] idempotent.

.SH SEE ALSO
 cdprfcl
 cdmarid                                                 
.PP
Literature: Dissertation D.J.Ford, p.45-49, or
.PP
            Diplomarbeit von R. Boeffgen p.72,
            Universitaet des Saarlandes.
                                                   
M*/
                       
/*H
	Version 1       06.06.89        J.Schmitt                          
	Version 2	27.12.89	J.Schmitt  Zeile 206:
					       lred2(mpa0) -> lred2(B2)	
   DATE ippnfecoreal  : 891101.900101.9203__
H*/

#include<_arith2.h>

list ippnfecoreal(F,p,Q,mp)
pol F;
single p;
int Q;
pol mp;
{
	list M,B,B2,Bl;
	single n,na,wy,ent4,r,i,e,k,l,d;
	rat va,vb,vc;
	int pp,p2,MOD,R2;
	pol U,G,H,y;
	pol a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb;
	bind(F,Q,mp);
	init(M,B,B2,Bl,va,vb,vc,pp,p2,MOD,R2,U,G,H,y);
	init(a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb);

	ent4 = 1;
	n = lfirst(F);
	U = list3(1,1,1);
	G = pitopms(1,F,p);
	G = pmsquot(1,p,G,mp);
	H = piprod(1,mp,G);
	H = pidif(1,F,H);
	H = piiquot(1,H,p);
	H = pitopms(1,H,p);
	G = upmsgcd(p,G,H);

	if ( lfirst(G) == 0 ) {
		U = list1(U);
		M = oibasisfgen(F,U);   
		M = list1(M);
		return(M);
	}
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
			if ( na == wy ) {
				if ( y != 0 ) M = list3(U,a0,y);
				else          M = list2(U,a0);
				M = oibasisfgen(F,M);
				M = list1(M);
				return(M);
			}
			va = ippnferegul1(F,p,Q,a0,mpa0,&a1,&a2);
			i = rden(va);
			if ( i == na ) {
				M = list3(U,a0,a2);
				M = oibasisfgen(F,M);
				M = list1(M);
				return(M);
			}
			pp = p;
			sqrem(0,i,wy,&d,&r);
			if ( r != 0 ) {
			       alb = ippnfeidpval(F,p,a0,a2,i,y,wy,&y,&wy);
			}
			else {
				if ( i == 1 ) pp = iprod(p,p);
				if ( rnum(va) == 1 ) break;
				alb = cdprsum(a0,a2);
			}
		}
		ent4 = 1;
		mpa0 = infepptfact(F,p,Q,pp,a0,alb);
		alb=lsecond(mpa0);
                if (llength(mpa0)==2) mpa0=lfirst(mpa0);
		else {
			M = lred2(mpa0);
			return(M);
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
		mpb0 = infepptfact(F,p,Q,p,a0,b0);
		b1=lsecond(mpb0);
                if (llength(mpb0)==2) mpb0=lfirst(mpb0);
		else {                     
			M = lred2(mpb0);
			return(M);
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
		vb = ippnferegul1(F,p,Q,b0,mpb0,&b1,&b2);
		i = rden(va);
		r = rden(vb);
		sqrem(0,i,r,&i,&r);
		if ( r != 0 ) {
			i = rden(va);
			r = rden(vb);
			alb = ippnfeidpval(F,p,a0,a2,i,b2,r,&y,&wy);
			ent4 = 0;
			break;
		}
		B2 = infepptfact(F,p,Q,p,a0,alb);
		Bl = lsecond(B2);
                if (llength(B2)==2) B2=lfirst(B2);
		else {
			M = lred2(B2);
			return(M);		
		}
		R2 = iprod(Q,MOD);
		e = iaval(p,R2);
		l = na * e;
		l = l - 1;
		p2 = p - 1;
		do {
			k = l;
			l = l + na;
			l = l - p2;
			p2 = isprod(p2,p);
		} while ( l > k );
		B2 = itor(k);
		Bl = itor(n);
		B2 = rquot(B2,Bl);
		l = rceil(B2);
		k = lfirst(mpa0);
		k = k * l;
		p2 = iexp(p,k);
		blb = nfeexpspec(F,b0,p2,R2);
		p2 = ilcm(p,MOD);
		blb = cdprzmodhom(blb,p2);
		B2 = pineg(1,lred(b0));
		lsred(b0,B2);
		B2 = cdprsum(blb,b0);
		c0 = nfeprodspec(F,B2,clb,0);
		mpc0 = list2(1,1);

		vc = ippnferegul1(F,p,Q,c0,mpc0,&c1,&c2);
		p2 = rfloor(vc);
		p2 = p2 + 1;
		p2 = iexp(p,p2);
		R2 = ilcm(p2,MOD);
		c0 = cdprzmodhom(c0,R2);
		i = rden(va);
		r = rden(vc);
		sqrem(0,i,r,&i,&r);
		if ( r != 0 ) {
			i = rden(va);
			r = rden(vc);
			alb = ippnfeidpval(F,p,a0,a2,i,c2,r,&y,&wy);
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
		R2 = intpp(p,MOD);
		R2 = iquot(MOD,R2);

		p2 = lfirst(Bl);
		Bl = lred(Bl);
		p2 = intpp(p,p2);

		Bl = piiprod(1,Bl,R2);
		Bl = lcomp(p2,Bl);

		b0 = nfeprodspec(F,c0,Bl,0);
	    }
	}
}
