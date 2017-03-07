/*M
.SH NAME
afmsp1coreal - algebraic function over modular single primes, transcendence degree 1, core algorithm 

.SH SYNOPSIS
.nf
#include<_arith4.h>

list afmsp1coreal(p, F, P, Q, mp)  
single p; 
pol F, P, Q, mp;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic and separable polynomial with unknown y over the polynomial ring (Z/pZ) [x].   
.TP 4
.B P
is a monic and irreducible polynomial in (Z/pZ) [x].
.TP 4
.B Q
is a power of P. The product of Q with an arbitrary element in the P-maximal over-order of the polynomial order of F lies in the
polynomial order. u := y mod (F) must be P-primary.
.TP 4
.B mp
is the P-minimal polynomial of u, i.e. mp is the (modulo P unique) irreducible factor of F.
.PP
afmsp1coreal returns a list, either consisting of a CD-matrix, say M, or of two lists, say Lfac and Lort.     
.PP
The rows of M represent CD-polynomials, these polynomials again represent elements in A (s. cdprfmsp1fcl and cdmarfmsp1id). These elements form a (Z/pZ) [x]-basis of the P-maximal over-order of the polynomial order of F. 
.PP
Lfac contains two monic polynomials, say f1 and f2, in y over (Z/pZ)[x] and Lort contains two CD-polynomials, say e1 and e2, over (Z/pZ)(x), representing elements in A, such that
.IP
.nf
F = f1 * f2 mod ( Q^2 * (Z/pZ) [x] ) [y];
e1 + e2 = 1 mod ( Q^2 * (Z/pZ) [x] ) [u];
e1 * e2 = 0 mod ( Q^2 * (Z/pZ) [x] ) [u];  
e1 and e2 are idempotent modulo ( Q^2 * (Z/pZ) [x] ) [u].
 
.SH SEE ALSO
.nf
cdprfmsp1fcl
cdmarfmsp1id

M*/
         
/*H
	Version 1       06.02.90	J.Schmitt                          
   DATE afmsp1coreal  : 901120.9203__
H*/

#include<_arith4.h>

list afmsp1coreal(p,F,P,Q,mp)
single p;              
pol F,P,Q,mp;
{
	single n,na,wy,e4,r,i,e,k,l,d,t,ph,ph2;
	int  ph3;
	rat  va,vb,vc;
	list M,B,B2,Bl,AL;
	pol  Fh,Pp,P2,Ph,MOD,R2,E,U,G,H,y;
	pol  a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb;
	bind(F,P,Q,mp);
	init(ph3,va,vb,vc,M,B,B2,Bl,AL,Fh,Pp,P2,Ph,MOD,R2,E,U,G,H,y);
	init(a0,ma0,a1,a2,alb,b0,mb0,b1,b2,blb,c0,mc0,c1,c2,clb);

	e4 = 1;           
	Fh = 0;	                   
	E  = list2(0,1);
	n  = lfirst(F);
	U  = list3(E,1,E);
	ph = pdegree(1,P);
	AL = gfsalgen(p,ph,P);

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
	a2 = pgfsquot(1,p,AL,a2,mp);
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
 	a1 = upgfsgcd(p,AL,a1,a2);
	if ( lfirst(a1) == 0 ) {
		U = list1(U);
		M = oprmsp1basfg(p,F,U);   
		M = list1(M);
		return(M);
	}                          

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

	for ( ; ; ) {
	    for ( ; ; ) {
		if ( e4 == 1 ) {
			na = lfirst(ma0);
			na = n / na;
			if ( na == 1 )  {
				y  = 0;
				wy = 1;
			}
			if ( na == wy ) {    
				if(y) M = list3(U,a0,y);
				else  M = list2(U,a0);
				M = oprmsp1basfg(p,F,M);
				M = list1(M);
				return(M);
			}
			va = afmsp1regul(p,F,P,Q,a0,ma0,&a1,&a2);
			i  = rden(va);
			if ( i == na ) {
				M = list3(U,a0,a2);
				M = oprmsp1basfg(p,F,M);
				M = list1(M);   
				return(M);
			}
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
			M = lred(ma0);
			return(M);
		}
		a0  = alb;
	    }

	    y   = a2;
	    wy  = rden(va);
	    clb = list3(E,0,E);
	    B   = list2(U,a0);
	    B   = oprmsp1basfg(p,F,B);
	    B   = cdprfmsp1lfm(B,p);
	    Ph  = pmsprod(1,p,P,P);
	    b0  = afmsp1expsp(p,F,a2,wy,Ph);
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
		Ph = pmsprod(1,p,MOD,Ph);
		a1 = cdprfmsp1mh(p,a1,Ph);

                Pp = P;
		Ph = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph = pmsprod(1,p,MOD,Ph);
		Ph = pmsprod(1,p,Ph,P);
		b0 = afmsp1expsp(p,F,a1,wy,Ph);
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

	    for ( ; ; ) {                         
		mb0 = afmsp1pptf(p,F,P,Q,P,a0,b0);
		b1  = lsecond(mb0);
                if (llength(mb0)==2) mb0 = lfirst(mb0);
		else {                     
			M = lred(mb0);
			return(M);
		}

		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph  = pmsprod(1,p,MOD,Ph);
		b0  = cdprfmsp1mh(p,b0,Ph);
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
			M = lred(B2);
			return(M);		
		}         
		R2  = pmsprod(1,p,Q,MOD);
   		e   = upmsaddval(p,P,R2);                      
                e   = iprod(e,n);
		ph2 = iprod(ph,lfirst(ma0));
		ph2 = iexp(p,ph2);
		ph3 = ph2;
		while ( icomp(e,ph3) == 1 ) ph3 = iprod(ph3,ph2);
		blb = afmsp1expsp(p,F,b0,ph3,R2);
		Ph  = pmsquot(1,p,P,upmsgcd(p,P,MOD));
		Ph  = pmsprod(1,p,MOD,Ph);
		blb = cdprfmsp1mh(p,blb,Ph);
		B2  = pmsneg(2,p,lred(b0));
		lsred(b0,B2);
		B2  = cdprfmsp1sum(p,blb,b0);
		c0  = afmsp1prodsp(p,F,B2,clb,0);
		mc0 = list2(1,E);
		vc  = afmsp1regul(p,F,P,Q,c0,mc0,&c1,&c2);
		t   = rfloor(vc);
		t   = t + 1;
		P2  = pmsexp(1,p,P,t);
		Ph  = pmsquot(1,p,P2,upmsgcd(p,P2,MOD));
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
		Ph  = lfirst(Bl);
		Bl  = lred(Bl);
		ph2 = upmsaddval(p,P,Ph);
		Ph  = pmsexp(1,p,P,ph2);
		Bl  = pmsupmsprod(2,p,Bl,R2);
		Bl  = lcomp(Ph,Bl);
		b0  = afmsp1prodsp(p,F,c0,Bl,0);
	    }
	}
}
