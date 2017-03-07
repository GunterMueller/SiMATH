/*M
.SH NAME
vepepuspmsp1 - values of the extensions of the P-adic val-uation of an element of the polynomial order of a univari-ate separable polynomial over the polynomial ring over modular single prime, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith4.h>

list vepepuspmsp1(p, F, a, P, k, v)  
pol F, a, P; 
single p, k, v;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.PP
Let R be the polynomial ring (Z/pZ)[x] over Z/pZ and let K be the rational function field (Z/pZ)(x).
.TP 4
.B F
is a monic and separable polynomial in the variable y over R, deg(F) > 1. 
.TP 4
.B a
is an element in the polynomial order R[y]/(F*R[y]), a is represented by a univariate polynomial over R of degree < deg(F).
.TP 4
.B P
is a monic prime polynomial in R.
.TP 4
.B k
is an integral number >1. Let t be the smallest power of 2 greater or equal to 2*k, then t*deg(P) must still be a single. P^k must not divide the reduced dicrimi-nant of F. 
.TP 4
.B v 
is a non negative integral number. The smallest number z >= v, such that z/k is a power of 2 must still be a single.
.PP
vepepuspmsp1 returns a list, containig two lists, say L1 and L2, where:
.TP 4
L1 = (F_1, k_1, ..., F_r, k_r).
F_i is a monic, univariate and irreducible polynomial over R of positive degree such that
.IP
F = F_1 * ... * F_r mod P^(2*k)
.IP
holds. Let F = A_1 * ... * A_s be a factorization of F into monic and irreducible polynomials A_i, then s = r holds and (under a suitable renumbering) A_i= F_i mod P^(2*k).
.PP
Let O be the ring of integers in K[y]/(F*K[y]) and let (P) be principal idel spanned by P in O. Then (P) has a decomposition in r distinct prime ideals (P_1), ..., (P_r) in O (r as above).
.IP
(P) = P*O = (P_1)^e_1 * ... (P_r)^e_r.
.PP
Let O_i be the ring of integers in K_i := K[y]/(F_i*K[y]). The principal ideal spanned by P in O_i has a decomposi-tion (R_i)^e_i, R_i prime ideal in O_i. Then
.TP 4
k_i
is a positive integral number, such that
.IP
k_i * e_i = deg(F_i) = deg(A_i)
.IP
holds. In all likelihood, k_i is the residual class degree of the primideal P_i.
.TP 4
L2 = (v_1, ..., v_r).
v_i is an integral number, v_i > -3.
Let V_(P_i) be the monic extension of the p-adic valuation v_p, given by the prime ideal P_i. Let K* be the set of the non zero-divisors of (K[y] / (F * K[y])) \ {0}, then V_(P_i) (K*) = Z holds. i
.IP
If v = 0, v_i is not = -1, v_i = -2 if V_(P_i)(a) is equal to infinity  and v_i = V_(P_i)(a) else.
.IP
If v > 0 and v_1 != -1 the above holds. For v_i = -1, V_(P-i)(a) >= (s/k_i), where s is the smallest number greater or equal to v, suchn that s/k is a power of 2. If only a upper bound S of die V_(P_i)-values is needed, v can be choosen as S*deg(F), because 
.IP
k_i <= deg(F_i) <= deg(F) and
.IP
V_(P_i)(a) >= (s/k_i) >= (v/k_i) >= (V/deg(F)) = S.
 
M*/
         
/*H
	Version 1	14.02.93	J.Schmitt
	Version 2	01.07.93	Dokument. wesentl. veraendert.  JSch
   DATE vepepuspmsp1  : 930531.931130
H*/


#include<_arith4.h>

static list vepepuspsubr(single,pol,pol,list,pol,pol);

vepepuspmsp1( p, F, a, P, k, v )
single p;
pol F, a, P;
single k, v;
{
	pol M11,p_k,A1,A2,A3,T,h,M3,H1,H2;
	single wz,k2,z,l,i,j,m,an,ao,ap,aq,as,s,ent;
	list ZW,A,M1,M2,V2,L1,L2,L3,L4,MM,L7,Lh2,Lhh,N1,N2,N3,N4;
	bind(F,a,P);
	init(M11,p_k,A1,A2,A3,T,h,M3,H1,H2);
	init(ZW,A,M1,M2,V2,L1,L2,L3,L4,MM,L7,Lh2,Lhh,N1,N2,N3,N4);
                            
	L1 = _0;
	L2 = F;
	while ( L2 != _0 ) {
		l  = lfirst(L2);
		L2 = lred(L2);
		L3 = lfirst(L2);
		L2 = lred(L2);
		L3 = pmsrem(1,p,L3,P);
		if ( L3 ) L1 = lcomp2(L3,l,L1);
	}
	h  = linv(L1);                   
	A  = gfsalgen(p,lfirst(P),P);
	L3 = upgfscfacts(p,A,h);

	L1 = _0;
	L4 = _0;
	while ( L3 != _0 ) {
		A1 = lfirst(L3);
		L3 = lred(L3); 
		L4 = lcomp(A1,L4);
		l  = lfirst(L3);
		L3 = lred(L3);
		if ( l != 1 ) A1 = pgfsexp(1,p,A,A1,l);			
		L1 = lcomp(A1,L1);
	}
   	L3 = linv(L1);          
	L4 = linv(L4);
	L7 = L4;                    
	k2 = 2*k;
	wz = 1;
              
	if ( lred(L3) == _0 ) {
		p_k = P;
		while ( k2 > wz ) {
			p_k = pmsprod(1,p,p_k,p_k);
			wz  = 2 * wz;
		}
		M3 = _0;
		L2 = F;
		while ( L2 != _0 ) {
			l  = lfirst(L2);
			L2 = lred(L2);
			A1 = lfirst(L2);
			L2 = lred(L2);
			A1 = pmsrem(1,p,A1,p_k);
			if ( A1 ) M3 = lcomp2(A1,l,M3);
		}
		M3 = linv(M3);                   
		A1 = list1(M3);
		A2 = list2(0,1);
		A2 = list2(0,A1);
		A2 = list1(A2);
		L2 = list2(A1,A2);
	}
	else {
	    L2 = upprmsp1hli(p,h,P,L3);
	    L1 = L3;
	    A1 = list2(0,1);        
	    A1 = list2(0,A1);
  	    while ( L1 != _0 ) {
		A1 = pmsprod(2,p,A1,lfirst(L1));
		L1 = lred(L1);
 	    }
	    L2  = list3(L3,L2,A1);
            ZW  = list5(P,1,0,P,list2(0,1));
	    while ( wz < k2 ) {
		L2 = upprmsp1hqs(p,F,ZW,lfirst(L2),lsecond(L2),lthird(L2));
   		wz = 2 * wz;
		ZW = pmsprod(1,p,lfourth(ZW),lfourth(ZW));
		ZW = list5(P,wz,0,ZW,list2(0,1));
	    }
	    M3 = lthird(L2);
	}                     
	M1  = lfirst(L2);
	M2  = lsecond(L2);
        M11 = pmsexp(1,p,P,k);
	k2  = k;                                  
	p_k = pmsprod(1,p,M11,M11);
	N1  = _0;
	Lh2 = _0;                                                           

	A1  = _0;
	A2  = F;                 
	T   = list2(0,1);
	while ( A2 != _0 ) {
		l  = lfirst(A2);
                A2 = lred(A2);
		A3 = lfirst(A2);
		A2 = lred(A2);
		A3 = list2(A3,T);
		A1 = lcomp2(A3,l,A1);
	}
	N3 = linv(A1);

	A1 = _0;
	A2 = a;                 
	while ( (A2) && (A2 != _0) ) {
		l  = lfirst(A2);
                A2 = lred(A2);
		A3 = lfirst(A2);
		A2 = lred(A2);
		A3 = list2(A3,T);
		A1 = lcomp2(A3,l,A1);
	}
	if ( A1!=_0 ) A2 = linv(A1);

	T  = uprfmsp1egcd(p,N3,A2,&A1,&A3);              

	if ( pdegree(1,T) ) {
		H2 = lred(T);
		A1 = lfirst(H2);
		H2 = lred(H2);				
		A1 = lsecond(A1);
		while ( H2 != _0 ) {
			H2 = lred(H2);				
			A3 = lfirst(H2);
			H2 = lred(H2);	
			A3 = lsecond(A3);
			A2 = pmsquot(1,p,A3,upmsgcd(p,A1,A3));			
			A1 = pmsprod(1,p,A1,A2);
		}
	        H1 = _0;
		while ( T != _0 ) {
			l  = lfirst(T);
			T  = lred(T);
			A2 = lfirst(T);
			T  = lred(T);
			A3 = pmsquot(1,p,A1,lsecond(A2));
			A3 = pmsprod(1,p,A3,lfirst(A2));
			H1 = lcomp2(A3,l,H1);
		}
		T = linv(H1);
	}
	else {
		T = list2(0,1);
		T = list2(0,T);
	}
	
    for ( ; ; ) {

	if ( k2 > k ) {                                  
		L2  = upprmsp1hqs(p,F,ZW,M1,M2,M3);
   		wz  = 2 * wz;
		ZW  = pmsprod(1,p,lfourth(ZW),lfourth(ZW));
		ZW  = list5(P,wz,0,ZW,list2(0,1));
		M1  = lfirst(L2);
		M2  = lsecond(L2);
		M3  = lthird(L2);
		M11 = p_k;
		p_k = pmsprod(1,p,p_k,p_k);                                              
		N3  = N4;
		N1  = linv(N2);
	}                 
	N2 = _0;

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
		  L3 = vepepuspsubr(p,A1,P,A,M11,A3);
		  an = (-1);
		}
		else {
		  an = lfirst(N1);
		  if ( (an) && (an != 1) ) L3 = vepepuspsubr(p,A1,P,A,M11,A3);
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

	i = v % 2 ;
	v = v / 2 ;
	v = v + i ;
	/*i = 1;*/
	
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
					return(MM);
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
						return(MM);
					  }	
					}                
				}
				else aq = 1;
			}                   
			else aq = 1;
			if (aq) {
				h = pmsrem(2,p,T,A1);
				if (h) {
					while (h!=_0) {
						l = lfirst(h);
						h = lred(h);
						H1 = pmsrem(1,p,lfirst(h),M11);
						if (H1) { 
							l = (-1);
							break;
						}
						h = lred(h);
					}
					if (l==(-1)) h=1;
					else h=0;
				}
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
						return(MM);
					  }	
					}
				}
			        else {
					H1 = _0;
					H2 = a;
                                    	while ( (H2) && (H2 != _0) ) {
					  l  = lfirst(H2);
					  H2 = lred(H2);
					  h  = pmsrem(1,p,lfirst(H2),p_k);
					  H2 = lred(H2);
					  if ( h ) H1 = lcomp2(h,l,H1);
					}									
	                                if (H1!=_0) h  = linv(H1);
                                        else h = 0;

					h  = pmsrem(2,p,h,A1);

					H1 = _0;
					H2 = h;
					while ( (H2) && (H2 != _0) ) {
					  l  = lfirst(H2);
					  H2 = lred(H2);
					  h  = pmsrem(1,p,lfirst(H2),p_k);
					  H2 = lred(H2);
					  if ( h ) H1 = lcomp2(h,l,H1);
					}									
	                                if (H1!=_0) h  = linv(H1);
                                        else h = 0;

					V2 = nepousppmsp1(p,A1,h);
					V2 = pmsrem(1,p,V2,p_k);
					if ( !V2 ) {
					  s   = 1;
					  if ( as == 0 ) N2 = lcomp(an,N2);
					  ent = (-1);  
					  Lhh = lcomp(ent,Lhh);
					  if ( L1 == _0 ) {
						Lh2 =  linv(Lhh);
						if ( ((v)&&(v<=k2)) ) {
							MM = list2(MM,Lh2);
							return(MM);
						}
					  }
					}		
					else {
					  z = upmsaddval(p,P,V2);
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
						return(MM);
					    }
					  }	   
				 	}
				}
			}
		}
	        /*i++;*/
	} 
	k2  = k2 + k2; 
    }
}



/*c
	vepepuspsubr ist ein static modul zu vepepuspmsp1
c*/                               

static list vepepuspsubr(p,F,P,A,Q,mp)
single p;              
pol F,P,Q,mp;                  
list A;
{
	single m,n,na,wy,e4,r,i,e,k,l,d,t,/*ph,*/ph2;
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
	/*ph = pdegree(1,P);*/
	m  = pdegree(1,mp);

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

	for ( ; ; ) {
	    for ( ; ; ) {
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
			a2 = vepepuspsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list2(a1,m);
			b1 = lfirst(M);
			b2 = vepepuspsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) b2 = list2(b1,m);
			a2 = lconc(b2,a2);
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

	    for ( ; ; ) {                         
		mb0 = afmsp1pptf(p,F,P,Q,P,a0,b0);
		b1  = lsecond(mb0);
                if (llength(mb0)==2) mb0 = lfirst(mb0);
		else {                     
			M = lsecond(mb0);
			a1 = lfirst(M);
			M  = lred(M);
			a2 = vepepuspsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list2(a1,m);
			b1 = lfirst(M);
			b2 = vepepuspsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) b2 = list2(b1,m);
			a2 = lconc(b2,a2);
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
			a2 = vepepuspsubr(p,a1,P,A,Q,mp);
			if ( a2 == _0 ) a2 = list2(a1,m);
			b1 = lfirst(M);
			b2 = vepepuspsubr(p,b1,P,A,Q,mp);
			if ( b2 == _0 ) b2 = list2(b1,m);
			a2 = lconc(b2,a2);
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

