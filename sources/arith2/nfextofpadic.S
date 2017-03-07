/*M
.SH NAME   
nfextofpadic - number field extensions of the p-adic valuation

.SH SYNOPSIS
.nf
#include<_arith2.h> 

list nfextofpadic(F, p, a)  
pol F, a; 
single p;

.SH DESCRIPTION
Let x be a variables name.
.TP 4
.B F  
is a monic, irreducible polynomial in x over Z with
degree(F) > 1. F is given in dense-representation.
.TP 4
.B p
is a single prime.
.TP 4
.B a
is an element of Z[x] / (F * Z[x]) and is represented
by a dense-polynomial in one variable over Z with degree
lower than the degree of F.
.PP
nfextofpadic returns a 
list (n_1, ... , n_r) with non negative integers
n_i. Then the p-adic valuation of Q has exactly r extensions
v_i of the number field Q[x] / (F * Q[x]), and it is
v_i(a) = n_i (suitably numbered).
(cf. vepvelpruspi)

.SH SEE ALSO
vepvelpruspi

M*/

/*H
	Version 1       10.12.1993      J.Schmitt
   DATE nfextofpadic  : 941201
H*/

#include<_arith2.h>

static list nfextpadicsu(pol,pol,single,single);

nfextofpadic( F, p, a)
pol F, a;
single p;
{
/*D
	Z bezeichne die ganzen und Q die rationalen Zahlen, x sei eine
	Unbestimmte ueber Q.
	F ist ein normiertes, irreduzibles Polynom in x ueber Z mit 
	Grad(F) > 1. F muss in dense-Darstellung gegeben sein.
	a ist ein Element aus Z[x] / ( F * Z[x] ) und wird durch
	ein dense-Polynom in einer Veraenderlichen ueber Z mit Grad
	kleiner als dem Grad von F repraesentiert.           
	p ist eine single Primzahl.	
	Dann ist L eine Liste der Form ( n_1, ... , n_r ) mit nicht
 	negativen ganzen Zahlen n_i, so dass die p-adische
	Bewertung von Q genau r verschiedene Fortsetzungen v_i
	auf den Zahlkoerper Q[x] / ( F * Q[x] ) besitzt,
	und dass bei geeigneter Numerierung v_i(a) = n_i ist. 
	(Siehe auch vepvelpruspi.)
D*/
	int M11,p_k;
	pol A1,A2,A3,T,h,M3;
	single k,v,k2,z,l,i,j,m,an,ao,ap,aq,as,s,ent;
	list M1,M2,V2,L1,L2,L3,L4,MM,L7,Lh2,Lhh,N1,N2,N3,N4;
	bind(F,a);
	init(M11,p_k,A1,A2,A3,T,h,M3);
	init(M1,M2,V2,L1,L2,L3,L4,MM,L7,Lh2,Lhh,N1,N2,N3,N4);

	F  = dptop(1,F);
	a  = dptop(1,a);
	v  = 0;
	M1 = upireddiscc(F,&M2);
	k  = iaval(p,M1);
	if(k) k++;
	else k = 2;
	
	h  = pitopms(1,F,p);	
	L3 = upmscfacts(p,h);
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
	L7 = L4;

	M11 = iexp(p,k);
	M11 = iprod(M11,M11);
	if ( lred(L3) == _0 ) {
		p_k = p;
		while ( icomp(M11,p_k) == 1 ) p_k = iprod(p_k,p_k);
		M3 = pitopmi(1,F,p_k);
		A1 = list1(M3);
		A2 = list2(0,1);
		A2 = list1(A2);
		L2 = list2(A1,A2);
	}
	else {
	        L2 = upihli(p,h,L3);
	        L1 = L3;
	        A1 = list2(0,1);
  	        while ( L1 != _0 ) {
			A1 = piprod(1,A1,lfirst(L1));
			L1 = lred(L1);
 	        }
	        L2  = list3(L3,L2,A1);
	        p_k = p;
	        while ( icomp(M11,p_k) == 1 ) {
		 L2 = upihlqs(p,p_k,1,F,lfirst(L2),lsecond(L2),lthird(L2));
 		 p_k = iprod(p_k,p_k);
	        }
	        M3 = lthird(L2);
	}                     
	M1  = lfirst(L2);
	M2  = lsecond(L2);

	k2  = k;                                  
	N1  = _0;
	Lh2 = _0;
	T   = pigcdcf(1,F,a,&A1,&A2);

    for ( ; ; ) {
                        
	if ( k2 > k ) {                                  
		L2  = upihlqs(p,p_k,1,F,M1,M2,M3);
		p_k = iprod(p_k,p_k);
		M1  = lfirst(L2);
		M2  = lsecond(L2);
		M3  = lthird(L2);
		M11 = iprod(M11,M11);                                              
		N3  = N4;
		N1  = linv(N2);
	}                 
	N2  = _0;

	L2 = lfirst(L2);

	L1 = _0;
        L4 = L7;
	while ( L2 != _0) {
		A1  = lfirst(L2);
		L2  = lred(L2);                 
		A3  = lfirst(L4);  
		m   = pdegree(1,A3);
		L4  = lred(L4);
		if ( N1 == _0 ) {
		  L3 = nfextpadicsu(A1,A3,p,k2);
		  an = (-1);
		}
		else {
		  an = lfirst(N1);
		  if ( (an) && (an != 1) ) L3 = nfextpadicsu(A1,A3,p,k2);
 		  else L3 = _0;
		  N1 = lred(N1);
		}			

		if ( L3 == _0 ) {
		  if ( an == (-1) ) N2 = lcomp(1,N2);
		  else  N2 = lcomp(an,N2);
		  L1 = lcomp2(A1,m,L1);	                                    
		}
		else {
		  L1 = lconc(L3,L1);
		  if ( an == (-1) ) {
			an = llength(L3);
			an = an / 2;
		  }
		  N2 = lcomp(an,N2);
		}
	}
	if ( k2 == k ) {
		MM = L1;
		N1 = N2;
		N3 = N2;
		N4 = N2;
	}               
	else N1 = linv(N2);
	N2  = _0;            
	as  = 0;                                              
	Lhh = _0;                                     
	ent = 0;

	i = v % 2;
	v = v / 2;
	v = v + i;

	while ( L1 != _0 ) {          
		A1 = lfirst(L1);
		L1 = lred(L1);	                 
		m  = lfirst(L1);
		L1 = lred(L1);	 
		if ( as == 0 ) {
			ao = lfirst(N3);
			N3 = lred(N3);                
			an = lfirst(N1);
			N1 = lred(N1);
			as = ao;
			s  = 0;
		}                               
		as = as - 1;
        	if (!an) { 
			N2 = lcomp(0,N2);
			for (j=1;j<=ao;j++) {
				ap  = lfirst(Lh2);
				Lh2 = lred(Lh2);		  
                        	Lhh = lcomp(ap,Lhh);
			}
			if (L1==_0) {
				Lh2 = linv(Lhh);	
			 	if ( !ent || ((v)&&(v<=k2)) ) {
					MM = list2(MM,Lh2);
					return(Lh2);
				}	
			}                
			as = 0;
		}			 
      		else {                  
			aq = 0;	
			if ( Lh2 != _0 ) {
				ap  = lfirst(Lh2);
				Lh2 = lred(Lh2);
				if ( ap != (-1) ) {
					Lhh = lcomp(ap,Lhh);
					if ( as == 0 ) {
					  if (!s) N2 = lcomp(0,N2);
					  else    N2 = lcomp(an,N2);
					}
					if (L1==_0) {
					  Lh2 = linv(Lhh);	
			 		  if ( !ent || ((v)&&(v<=k2)) ) {
						MM = list2(MM,Lh2);
						return(Lh2);
					  }	
					}                
				}
				else aq = 1;
			}                   
			else aq = 1;
			if (aq) {
				h = pmirem(1,M11,T,A1);
				if (!h) {
					if ( as == 0 ) {
					  if (!s) N2 = lcomp(0,N2);
					  else    N2 = lcomp(an,N2);
					}
					Lhh = lcomp((-2),Lhh);
					if (L1==_0) {
					  Lh2 = linv(Lhh);	
					  if ( !ent || ((v)&&(v<=k2)) ) {
						MM = list2(MM,Lh2);
						return(Lh2);
					  }	
					}
				}
			        else {  
					h = pitopmi(1,a,M11);
					h = pmirem(1,M11,h,A1);
					V2 = normelpruspi(A1,h);
					V2 = irem(V2,M11);
					if ( !V2 ) {
					  s   = 1;
					  if ( as == 0 ) N2 = lcomp(an,N2);
					  ent = (-1);  
					  Lhh = lcomp(ent,Lhh);
					  if ( L1 == _0 ) {
						Lh2 =  linv(Lhh);
						if ( ((v)&&(v<=k2)) ) {
							MM = list2(MM,Lh2);
							return(Lh2);
						}
					  }
					}		
					else {
					  z = iaval(p,V2);
					  z = iquot(z,m);
					  Lhh = lcomp(z,Lhh);
					  if ( as == 0 ) {
					    if (!s) N2 = lcomp(0,N2);
					    else    N2 = lcomp(an,N2);
					  }
					  if ( L1 == _0 ) {
					    Lh2 = linv(Lhh);
					    if ( !ent || ((v)&&(v<=k2)) ) {
						MM = list2(MM,Lh2);
						return(Lh2);
					    }
					  }	   
				 	}
				}
			}
		}
	} 
	k2  = k2 + k2; 
    }
}



/*c
	nfextpadicsu ist ein static modul zu nfextofpadic.
c*/
/*cS
	nfextpadicsu ist rekursiv
	und ruft auf: cdprinv, cdpriquot, cdprlfcdmar, cdprsum, cdprzmodhom
		iaval, iexp, ilcm, infepptfact, intpp, ippnfeidpval
		ippnferegul1, iprod, isprod, itor, lcomp, lconc, llength
		modielemtest, nfeexpspec, nfeprodspec, oibasisfgen
		pidif, pigcdcf, piiprod, piiquot, pineg, piprod, pitopms
		rceil, rfloor, sqrem, upmsgcd
	Macros: iquot, lcomp2, lfirst, list1, list2, list3, list4, list5
		lred, lred2, lsecond, lsred, lthird, pdegree, pmsquot, rden
		rnum, rquot
Sc*/

static list nfextpadicsu(F,mp,p,t)
pol F, mp;
single p, t;
{

	list M,B,B2,Bl,M1,M1H;
	single n,na,wy,ent4,r,i,e,k,l,d,m;
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
	m = pdegree(1,mp);
	U = list3(1,1,1);
	G = pitopms(1,F,p);
	G = pmsquot(1,p,G,mp);
	H = piprod(1,mp,G);
	H = pidif(1,F,H);
	H = piiquot(1,H,p);
	H = pitopms(1,H,p);
	G = upmsgcd(p,G,H);

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

			va = ippnferegul1(F,p,Q,a0,mpa0,&a1,&a2);
			i = rden(va);
			if ( i == na ) return(_0);                   

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
			M1H = nfextpadicsu(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list2(M1,m);
			M1 = lfirst(M);
			M = nfextpadicsu(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp2(M1,m,M1H);
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
		mpb0 = infepptfact(F,p,Q,p,a0,b0);
		b1=lsecond(mpb0);
                if (llength(mpb0)==2) mpb0=lfirst(mpb0);
		else {
			M = lred2(mpb0);        
			M = lfirst(M);
			M1 = lfirst(M);
			M  = lred(M);
			M1H = nfextpadicsu(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list2(M1,m);
			M1 = lfirst(M);
			M = nfextpadicsu(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp2(M1,m,M1H);
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
			M1H = nfextpadicsu(M1,mp,p,t);
			if ( M1H == _0 ) M1H = list2(M1,m);
			M1 = lfirst(M);
			M = nfextpadicsu(M1,mp,p,t);
			if ( M == _0 ) M1H = lcomp2(M1,m,M1H);
			else M1H = lconc(M,M1H);
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
