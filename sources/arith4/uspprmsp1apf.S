/*M
.SH NAME
uspprmsp1apf - univariate separable polynomial over poly-nomial ring over modular single prime, transcendence degree 1, approximation of P-adic factorization

.SH SYNOPSIS
.nf
#include<_arith4.h>

list uspprmsp1apf(p, P, F, k)  
single p, k; 
pol P, F;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS. 
.TP 4
.B P
is a monic prime polynomial in (Z/pZ)[x].
.TP 4
.B F
is a monic, irreducible and univarite polynomial over (Z/pZ)[x], deg(F) > 1.
.TP 4
.B k
is an integral number >1. Let t be the smallest power of 2 greater or equal to 2*k, then t*deg(P) must still be a single. P^k must not
divide the reduced dicrimi-nant of F (s.upprmsp1redd).
.PP
uspprmsp1apf returns a list, say L, containing univariate polynomials f_1, ..., f_r over (Z/pZ)[x] of positive degree , such that
.IP
F = f_1 * ... * f_r mod  P^(2*k) 
.PP
holds. Let F = P_1 * ... * P_s be a factorization of F into monic and irreducible polynomials P_i, then s = r holds and (under a suitable renumbering) P_i = F_i mod P^(2*k). 
The coefficients of f_i are of degree smaller 2*k*deg(P).

.SH SEE ALSO
upprmsp1redd

M*/
           
/*H
	Version 1       10.02.1993	J.Schmitt
	Version 2	01.11.1993	von 'pol4 nach 'arith4 (nur vor-
					laeufig, bis 'pol5 existiert).  PS
   DATE uspprmsp1apf  : 930531.931130
H*/


#include <_arith4.h>

static list usppsubr(single,pol,pol,list,pol,pol);

list uspprmsp1apf(p,P,F,k)
single p;
pol P,F;
single k;
{
	single l;
	pol P1,P2,A1,A3,Q;
	list L1,L2,L3,L4;
	bind(P,F);
	init(P1,P2,A1,A3,Q,L1,L2,L3,L4);
               
	            
	P1 = F;
	A1 = _0;        
	Q  = pmsexp(1,p,P,k);
	while ( P1 != _0 ) {
		l  = lfirst(P1);
		P1 = lred(P1);
		A3 = lfirst(P1);
		P1 = lred(P1);
		A3 = pmsrem(1,p,A3,P);
		if (A3) A1 = lcomp2(A3,l,A1);
	}
	P1 = linv(A1);
	L2 = gfsalgen(p,lfirst(P),P);
	L3 = upgfscfacts(p,L2,P1);
	L1 = _0;
	L4 = _0;
	while ( L3 != _0 ) {
		A1 = lfirst(L3);
		L3 = lred(L3); 
		L4 = lcomp(A1,L4);
		l  = lfirst(L3);
		L3 = lred(L3);
		if ( l != 1 ) A1 = pgfsexp(1,p,L2,A1,l);			
		L1 = lcomp(A1,L1);
	}
   	L3 = linv(L1);          
	L4 = linv(L4);            

	k  = 2 * k;              
	P2 = pmsprod(1,p,Q,Q);	
	P1 = upprmsp1hfa(p,F,P,L3,k);
        
	L1 = _0;
	while ( P1 != _0) {
		A1 = lfirst(P1);
		P1 = lred(P1);                 
		A3 = _0;
		while ( A1 != _0 ) {
			l  = lfirst(A1);
			A1 = lred(A1);
			L3 = pmsrem(1,p,lfirst(A1),P2);
			A1 = lred(A1);
			if ( L3 ) A3 = lcomp2(L3,l,A3);
		}
		A1 = linv(A3);
		A3 = lfirst(L4);
		L4 = lred(L4);
		L3 = usppsubr(p,A1,P,L2,Q,A3);		
		if ( L3 == _0 ) L1 = lcomp(A1,L1);
		else            L1 = lconc(L3,L1);
	}

	return(L1);
}                                


/*c
	usppsubr ist ein static modul zu uspprmsp1apf.
c*/                               
/*H
	Version 1       10.02.93	J.Schmitt                          
H*/

static list usppsubr(p,F,P,A,Q,mp)
single p;              
pol F,P,Q,mp;                  
list A;
{
	single n,na,wy,e4,r,i,e,k,l,d,t,ph2;
	int  ph3,l1,k1;
	rat  va,vb,vc;
	list M,B,B2,Bl;
	pol  Fh,Pp,P2,Ph,MOD,R2,E,U,G,y;
	pol  a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb;
	bind(F,P,Q,mp,A);
	init(ph3,l1,k1,va,vb,vc,M,B,B2,Bl,Fh,Pp,P2,Ph,MOD,R2,E,U,G,y);
	init(a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb);

	e4 = 1;           
	Fh = 0;	                   
	E  = list2(0,1);
	n  = lfirst(F);
	U  = list3(E,1,E);

	a1 = F; 
	a2 = _0;
	while ( a1 != _0 ) {
		t  = lfirst(a1);
		a1 = lred(a1);
		b1 = pmsrem(1,p,lfirst(a1),P);
		a1 = lred(a1);
		if (b1) a2 = lcomp2(b1,t,a2);
	}
	a2 = linv(a2);
	a2 = pgfsquot(1,p,A,a2,mp);
	a1 = pmsdif(2,p,F,pmsprod(2,p,a2,mp));
	a1 = pmsupmsquot(2,p,a1,P);
	b1 = _0;
	while ( (a1) && (a1 != _0) ) {
		t  = lfirst(a1);
		a1 = lred(a1);
		b2 = pmsrem(1,p,lfirst(a1),P);
		a1 = lred(a1);
		if (b2) b1 = lcomp2(b2,t,b1);
	}
	if ( b1 != _0 ) a1 = linv(b1);
	else a1 = 0;                
 	a1 = upgfsgcd(p,A,a1,a2);
	if ( lfirst(a1) == 0 ) return(_0);

	wy = 1;
	y  = 0;
	if ( lred2(mp) == _0 ) {   
		a1  = list2(0,(p-1));
		a0  = list5(E,1,E,0,a1);
		ma0 = list4(1,E,0,E);
	}
	else {
		a0  = U;
		ma0 = mp;
	}

	while (1) {
	    while (1) {
		if ( e4 == 1 ) {
			na = lfirst(ma0);
			na = n / na;
			if ( na == 1 )  {
				y  = 0;
				wy = 1;
			}
			if ( na == wy ) return(_0);
			va = afmsp1regul(p,F,P,Q,a0,ma0,&a1,&a2);
			i  = rden(va);
			if ( i == na ) return(_0);
			Pp = P;
			if ( i % wy ) {
			    alb = afmsp1idpval(p,F,P,a0,a2,i,y,wy,&y,&wy);
			}
			else {
				if ( i == 1 ) Pp = pmsprod(1,p,P,P);
				if ( rnum(va) == 1 ) break;     
				alb = cdprfmsp1sum(p,a0,a2);
				
			}
		}
		e4  = 1;                    
		ma0 = afmsp1pptf(p,F,P,Q,Pp,a0,alb);
		alb = lsecond(ma0);
                if (llength(ma0)==2) ma0=lfirst(ma0);
		else {
			M = lsecond(ma0);
			a1 = lfirst(M);
			M  = lred(M);
			a2 = usppsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list1(a1);
			b1 = lfirst(M);
			b2 = usppsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) a2 = lcomp(b1,a2);
			else a2 = lconc(b2,a2);
			return(a2);
		}
		a0  = alb;
	    }

	    y   = a2;
	    wy  = rden(va);
	    clb = list3(E,0,E);
	    B   = list2(U,a0);
	    B   = oprmsp1basfg(p,F,B);
	    B   = cdprfmsp1lfm(B,p);
	    P2  = pmsprod(1,p,P,P);
	    b0  = afmsp1expsp(p,F,a2,wy,P2);
	    b0  = cdprfmsp1upq(p,b0,P);
	    if ( modprmsp1elt(B,p,b0) == 0 ) { 
		a1  = a2;
		Pp  = P;
		MOD = E;
	    }
	    else {                
		B   = list1(a0);
		B   = oprmsp1basfg(p,F,B);
		B   = cdprfmsp1lfm(B,p);
		B2  = B;
		MOD = E;
		while ( B2 != _0 ) {
			Bl  = lfirst(B2);
			B2  = lred(B2);
			MOD = pmsprod(1,p,MOD,lthird(Bl));
		}                         

		Ph = pmsquot(1,p,Pp,upmsgcd(p,Pp,MOD));
		P2 = pmsprod(1,p,MOD,Ph);
		a1 = cdprfmsp1mh(p,a1,P2);

                Pp = P;
		Ph = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		P2 = pmsprod(1,p,MOD,Ph);
		P2 = pmsprod(1,p,P2,P);
		b0 = afmsp1expsp(p,F,a1,wy,P2);
		b0 = cdprfmsp1upq(p,b0,P);
	    }                            
               
	    if ( !Fh ) {
	        B2 = F;
	        Bl = _0;
	        while ( B2 != _0 ) {
			t  = lfirst(B2);
			B2 = lred(B2);
			R2 = list2(lfirst(B2),E);
			B2 = lred(B2);
			Bl = lcomp2(R2,t,Bl);
		}
	        Fh = linv(Bl);	
	    }

	    while (1) {                         
		mb0 = afmsp1pptf(p,F,P,Q,P,a0,b0);
		b1  = lsecond(mb0);
                if (llength(mb0)==2) mb0 = lfirst(mb0);
		else {                     
			M = lsecond(mb0);
			a1 = lfirst(M);
			M  = lred(M);
			a2 = usppsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list1(a1);
			b1 = lfirst(M);
			b2 = usppsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) a2 = lcomp(b1,a2);
			else a2 = lconc(b2,a2);
			return(a2);
		}

		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		P2  = pmsprod(1,p,MOD,Ph);
		b0  = cdprfmsp1mh(p,b0,P2);
		alb = cdprfmsp1sum(p,a0,b0);
		i   = lfirst(ma0);
		r   = lfirst(mb0);
		if ( i % r ) {
			e4 = 0;
			break;
		}
	 	vb = afmsp1regul(p,F,P,Q,b0,mb0,&b1,&b2);
		i  = rden(va);
		r  = rden(vb);
		if ( i % r ) {                             
			alb = afmsp1idpval(p,F,P,a0,a2,i,b2,r,&y,&wy);
			e4 = 0;
			break;
		}              
		B2 = afmsp1pptf(p,F,P,Q,P,a0,alb);
		Bl = lsecond(B2);
                if (llength(B2)==2) B2=lfirst(B2);
		else {
			M = lsecond(B2);
			a1 = lfirst(M);
			M  = lred(M);
			a2 = usppsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list1(a1);
			b1 = lfirst(M);
			b2 = usppsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) a2 = lcomp(b1,a2);
			else a2 = lconc(b2,a2);
			return(a2);
		}         
		R2  = pmsprod(1,p,Q,MOD);
   		e   = upmsaddval(p,P,R2);
		l1  = na * e;
		l1  = l1 - 1;
		ph3 = p - 1;
		do {
			k1  = l1;
			l1  = isum(l1,na);
			l1  = idif(l1,ph3);
			ph3 = isprod(ph3,p);
		} while ( icomp(l1,k1) == 1 );            
		B2  = itor(k1);
		Bl  = itor(na);
		B2  = rquot(B2,Bl);
		l1  = rceil(B2);
		ph3 = iexp(p,l1);     
		blb = afmsp1expsp(p,F,b0,ph3,R2);
		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		P2  = pmsprod(1,p,MOD,Ph);
		blb = cdprfmsp1mh(p,blb,P2);
		B2  = pmsneg(2,p,lred(b0));
		lsred(b0,B2);
		B2  = cdprfmsp1sum(p,blb,b0);
		c0  = afmsp1prodsp(p,F,B2,clb,0);
		mc0 = list2(1,E);
		vc  = afmsp1regul(p,F,P,Q,c0,mc0,&c1,&c2);
		t   = rfloor(vc);
		t   = t + 1;
		Pp  = pmsexp(1,p,P,t);
		Ph  = pmsquot(1,p,Pp,upmsgcd(p,Pp,MOD));
		R2  = pmsprod(1,p,Ph,MOD);
		c0  = cdprfmsp1mh(p,c0,R2); 
		i   = rden(va);
		r   = rden(vc);
		if ( i % r ) {
			alb = afmsp1idpval(p,F,P,a0,a2,i,c2,r,&y,&wy);
			e4 = 0;
			break;
		}
		B2  = rquot(vc,va);
		k   = rnum(B2);
		clb = afmsp1expsp(p,F,a1,k,R2);
                Ph  = uprfmsp1fcdp(p,clb);
		b0  = list2(P2,E);
		b0  = list2(0,b0);
		do {
			B2 = uprfmsp1egcd(p,Fh,Ph,&Bl,&R2);
			if ( lfirst(B2) ) Ph = prfmsp1sum(1,p,Ph,b0);
		} while ( lfirst(B2) );                         
		clb = cdprfmsp1fup(p,Ph);         
		Bl  = cdprfmsp1inv(p,Fh,clb);
		ph2 = upmsaddval(p,P,MOD);
		R2  = pmsexp(1,p,P,ph2);
		R2  = pmsquot(1,p,MOD,R2);
		P2  = lfirst(Bl);
		Bl  = lred(Bl);
		ph2 = upmsaddval(p,P,P2);
		P2  = pmsexp(1,p,P,ph2);
		Bl  = pmsupmsprod(2,p,Bl,R2);
		Bl  = lcomp(P2,Bl);
		b0  = afmsp1prodsp(p,F,c0,Bl,0);
	    }
	}
}

