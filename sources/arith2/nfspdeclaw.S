/*M
.SH NAME
nfspdeclaw - number field, single prime decomposition law

.SH SYNOPSIS
.nf
#include<_arith2.h>

list nfspdeclaw(F, p)  
pol F; 
single p;

.SH DESCRIPTION
.TP 4
.B F
is a monic, irreducible and univariate polynomial over the integer numbers of degree > 1. F must be given in dense representation.
.TP 4
.B P
is a single prime.
.PP
Let z be a root of F, and let K denote the field, arising by the adjunction of z to the rational numbers, K = Q(z), and let O denote the ring of integers in K.
.PP
For P_1^e_1 * ... * P_r^e_r being the decomposition of the ideal (P) in O into prime ideals P_i in O, and f_i being the residue degree of O modulo P_i,
in all likelihood,  nfspdeclaw returns the list (e_1, f_1, ..., e_r, f_r).
 
M*/
                                     
/*H
	Version 1	08.09.91	J.Schmitt
	Version 2	03.02.93	Hensel-Faktorisierung bis 2*k.  JS
	Version 3	09.06.93	k=(-1) --> k=0  in Zeile 53 und
					k==0   --> k==1 in Zeile 62.    JS
   DATE nfspdeclaw    : 910915.9203__.930115.930531.9311__
H*/

#include <_arith2.h>

static list nfspdeclaws(pol,pol,single,single);

list nfspdeclaw(F,p)
pol F;
single p;
{
	single k,l,r;
	int M;
	pol P,P1,A1,A3;      
	list L1,L2,L3,L4;
	bind(F);
	init(M,P,P1,A1,A3,L1,L2,L3,L4);

	P  = dptop(1,F);
	L1 = upireddiscc(P,&L2);
	
	k  = 0;
	L2 = 0;
	while( !L2 ) {
		isqrem(L1,p,&L1,&L2);
		k = k + 1;
	}

	P1 = pitopms(1,P,p);	
	L3 = upmscfacts(p,P1);
	if ( k == 1 ) {
        	L2 = _0;
		while ( L3 != _0 ) {
			L2 = lcomp(lsecond(L3),L2);
			L2 = lcomp(lfirst(lfirst(L3)),L2);
			L3 = lred2(L3);
		}
		L2 = linv(L2);
		return(L2);
	}

	L1 = _0;
	L4 = _0;
	while ( L3 != _0 ) {
		A1 = lfirst(L3);
		L3 = lred(L3); 
		L4 = lcomp(A1,L4);
		l  = lfirst(L3);
		L3 = lred(L3);
		if ( l != 1 ) A1 = pmsexp(1,p,A1,l);			
		L1 = lcomp(A1,L1);
	}
   	L3 = linv(L1);          
	L4 = linv(L4);

	l  = 2 * k;
	M  = iexp(p,l);
	L2 = upihlfa(p,P,L3,l);

	L1 = _0;
	while ( L2 != _0) {
 		A1 = lfirst(L2);
		A1 = pitopmi(1,A1,M);
		L2 = lred(L2);                 
		A3 = lfirst(L4);
		L4 = lred(L4);	
		L3 = nfspdeclaws(A1,A3,p,k);
		while ( L3 != _0 ) {
			A1 = lfirst(L3);
			L3 = lred(L3);
			l  = pdegree(1,lfirst(A1));
			A1 = lthird(A1);
			r  = pdegree(1,A1);
			l  = l / r;
			L1 = lcomp2(r,l,L1);
		}
	}
	L1 = linv(L1);
	return(L1);
}                                      


/*c
	nfspdeclaws ist ein static modul zu nfspdeclaw.
c*/
/*H
	Version 1    	 08.08.91	J.Schmitt
H*/

static list nfspdeclaws(F,mp,p,t)
pol F, mp;
single p, t;
{

	list M,B,B2,Bl,M1,M1H;
	single n,na,wy,ent4,r,i,e,k,l,d;
	rat va,vb,vc;
	int pp,p2,MOD,R2,Q;
	pol U,G,H,y;
	pol a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb;
	bind(F,mp);
	init(M,B,B2,Bl,M1,M1H,va,vb,vc,pp,p2,MOD,R2,Q,U,G,H,y);
	init(a0,mpa0,a1,a2,alb,b0,mpb0,b1,b2,blb,c0,mpc0,c1,c2,clb);

	Q  = iexp(p,t);	
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
		M1 = list3(F,U,mp);
		M1 = list1(M1);
		return(M1);                
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
				M1 = list3(F,a0,mpa0);
				M1 = list1(M1);
				return(M1);
			}

			va = ippnferegul1(F,p,Q,a0,mpa0,&a1,&a2);
			i = rden(va);
			if ( i == na ) { 
				alb = cdprsum(a0,a2);          
				M   = infeminpmpp(F,alb,p,1,Q);
				if ( pdegree(1,M) == n ) {
					M1 = list3(F,alb,mpa0);
					M1 = list1(M1);
					return(M1);
                                }
				pp = lfirst(a0);
				a0 = lred(a0);
				if ( !irem(pp,p) ) pp = iquot(pp,p);
				else a0 = piiprod(1,a0,p);
				a0 = lcomp(pp,a0);

                                for ( ; ; ) {
					alb = cdprsum(alb,a0);
 					M   = infeminpmpp(F,alb,p,1,Q);
					if ( pdegree(1,M) == n ) {
						M1 = list3(F,alb,mpa0);
						M1 = list1(M1);
						return(M1);
                        	        }
			        }
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
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = nfspdeclaws(M1,mp,p,t);
			M1 = lfirst(M);
			M = nfspdeclaws(M1,mp,p,t);
			M1H = lconc(M,M1H);
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
		mpb0 = infepptfact(F,p,Q,p,a0,b0);
		b1=lsecond(mpb0);
                if (llength(mpb0)==2) mpb0=lfirst(mpb0);
		else {
			M = lred2(mpb0);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = nfspdeclaws(M1,mp,p,t);
			M1 = lfirst(M);
			M = nfspdeclaws(M1,mp,p,t);
			M1H = lconc(M,M1H);
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
		Bl=lsecond(B2);
                if (llength(B2)==2) B2=lfirst(B2);
		else {
			M = lred2(B2);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = nfspdeclaws(M1,mp,p,t);
			M1 = lfirst(M);
			M = nfspdeclaws(M1,mp,p,t);
			M1H = lconc(M,M1H);
			return(M1H);
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
