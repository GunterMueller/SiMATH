/*M
.SH NAME
afmsp1pptf - algebraic function over modular single prime, transcendence degree 1, P-primality test and factorization of the defining polynomial or the minimal polynomial

.SH SYNOPSIS
.nf
#include<_arith4.h>

list afmsp1pptf(p, F, P, Q, Pp, a0, z) 
single p; 
pol F, P, Q, Pp, a0, z;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, univariate and separable polynomial over the polynomial ring (Z/pZ) [x].
.PP
The algebra A arises by the adjunction of a seperable ele-ment, say u, to (Z/pZ) (x).
.TP 4
.B P
is a monic and irreducible polynomial in (Z/pZ) [x]. 
.TP 4
.B Q and Pp
are powers of P. The product of Q with an arbitrary element in the P-maximal over-order of the polynomial order of F lies in the polynomial order.
.TP 4
.B a0
is a CD-polynomial, representing a P-primary integral element in A (s.cdprfmsp1fcl).
.TP 4
.B z
is a CD-polynomial, representing an integral element in A.
.PP
afmsp1pptf returns a list L equal to
.TP 4
1.)
(mp, pzet), if z is P-primary,
.TP 4
2.) 
(pzet, Lfac, Lort), if z is not P-primary.
.PP
Thereby, mp is the unique irreducible factor of z modulo P.
.PP
pzet is an integral element in A, representet by a CD-polynomial. The minimal polynomial has the same degree as F. 
.PP
pzet = z + ( Pp * a0 * m ) modulo ( Pp * (Z/pZ) [x] ) [u],
.PP
for a non negative integer m.
.PP
Lfac contains two monic and univariate polynomials, say f1 and f2, over (Z/pZ)[x] and Lort contains two CD-polynomi-als, say e1 and e2, over (Z/pZ)(x), representing elements in A, such that
.IP
.nf
F = f1 * f2 mod ( Q^2 * (Z/pZ) [x] ) [u];
e1 + e2 = 1 mod ( Q^2 * (Z/pZ) [x] ) [u];
e1 * e2 = 0 mod ( Q^2 * (Z/pZ) [x] ) [u];
e1 and e2 are idempotent modulo ( Q^2 * (Z/pZ) [x] ) [u].

.SH SEE ALSO
cdprfmsp1fcl

M*/
                           
/*H
	Version 1       11.01.1990      J.Schmitt
	Version 2       04.07.1991      ueberfl. Zuweisung s=... beseitigt.  PS
   DATE afmsp1pptf    : 901120.910715.9203__
H*/

#include<_arith4.h>

list afmsp1pptf(p,F,P,Q,Pp,a0,z)
single p;
pol F,P,Q,Pp,a0,z;
{
	pol Hl,M1,M2,M3,r2,e1,e2,pz,Qp,Q2;
	list L,L1;
	single i,j,s,n,n2;
	bind(F,P,Q,Pp,a0,z);
	init(Hl,M1,M2,M3,r2,e1,e2,pz,Qp,Q2,L,L1);

        pz = cdprfmsp1mh(p,z,Pp);
	r2 = afmsp1minpol(p,F,pz);
	n  = lfirst(F);
	n2 = 0;
	while ( pdegree(1,r2) < n ) {
		if ( !n2 ) {
			n2 = 1;                   
			M3 = lfirst(a0);
			M1 = upmsgcd(p,Pp,M3);
			M2 = pmsquot(1,p,M3,M1);
			M3 = pmsquot(1,p,Pp,M1);
			Hl = pmsupmsprod(2,p,lred(a0),M3);
			Hl = lcomp(M2,Hl);
		}
		pz = cdprfmsp1sum(p,pz,Hl);
		r2 = afmsp1minpol(p,F,pz);
	}       
                       
	M1 = _0;
	while ( r2 != _0 ) {
		i  = lfirst(r2);
		r2 = lred(r2);
		M2 = pmsrem(1,p,lfirst(r2),P);
		r2 = lred(r2);
		if ( M2 ) M1 = lcomp2(M2,i,M1);
	}
	r2 = linv(M1);
                                           
	Qp = gfsalgen(p,lfirst(P),P);
	L  = upgfscfacts(p,Qp,r2);
	L1 = _0;
	while ( L != _0 ) {
		M1 = lfirst(L);
		L  = lred(L);
		n2 = lfirst(L);
		L  = lred(L);
		M2 = pgfsexp(1,p,Qp,M1,n2);
		L1 = lcomp(M2,L1);
	}
	if ( lred(L1) == _0 ) {                            
		L  = list2(M1,pz);
		return(L);          
	}          

	do {
		L = L1;
		s = 0;
		while ( lred(L) != _0 ) {
			M1 = lfirst(L);
			M3 = lred(L);
			M2 = lfirst(M3);
			if ( lfirst(M1) < lfirst(M2) )  {
				lsfirst(L,M2);
				lsfirst(M3,M1);
				s = 1;
			}
			L  = M3;
		}
	} while ( s );

	M1 = lfirst(L1);
	L1 = lred(L1);
	M2 = lfirst(L1);
	L1 = lred(L1);
	while ( L1 != _0 ) {
		M3 = lfirst(L1);
		L1 = lred(L1);
		M2 = pgfsprod(1,p,Qp,M2,M3);
		if ( lfirst(M2) > lfirst(M1) ) {
			M3 = M2;
			M2 = M1;
			M1 = M3;
		}
	}

	n2 = lfirst(M2);	        
	L  = upgfsegcd(p,Qp,M1,M2,&Q2,&r2);
	L1 = pgfsprod(1,p,Qp,M2,r2);
	Qp = pmsprod(1,p,Q,Q);
	e1 = upprmsp1afes(p,F,L1,pz);
       	Hl = cdprfmsp1mh(p,e1,P);
	do {
		e1 = Hl;
		if ( p != 2 ) L1 = pmsmsprod(2,p,lred(e1),2);
		else L1 = 0;
		if ( p != 3 ) {
			M2 = lfirst(e1);
			M2 = pmsmsprod(1,p,M2,3);
			L  = list2(0,M2);
		}
		else L = 0;
		Hl = pmsdif(2,p,L,L1);
		Hl = lcomp(lfirst(e1),Hl);
		Q2 = pmsprod(1,p,lfirst(e1),Qp);
		Hl = afmsp1prodsp(p,F,Hl,e1,Q2);
		Hl = afmsp1prodsp(p,F,Hl,e1,Qp);
	} while ( !oequal(e1,Hl) );

	e2 = uprfmsp1fcdp(p,e1);
	M1 = list2(0,1);
	M3 = list2(M1,M1);
	M1 = list2(0,M3);
	e2 = prfmsp1dif(1,p,M1,e2);
	e2 = cdprfmsp1fup(p,e2);
	r2 = list2(e1,e2);
 
	M3 = list2(0,1);  
	M3 = list2(1,M3);
	Q2 = pmsprod(1,p,Qp,lfirst(e2));
	e1 = lred(e2);
	L  = _0;
	for(i=n;i>0;i--) {
		L1 = _0;
		for (j=(n+n2+1);j>0;j--) {
			if ( i==j ) L1 = lcomp(Q2,L1);
			else        L1 = lcomp(0,L1);
		}
		L = lcomp(L1,L);
	}
	for (i=0;i<=n2;i++) {
		M1 = list2(0,1);
		M2 = _0;
		for (j=n2;j>=0;j--) {
			if ( i==j ) M2 = lcomp(M1,M2);
			else        M2 = lcomp(0,M2);
		}                         
		M1 = sclfuprfmsp1(e1,n);
		M1 = lconc(M1,M2);
		for (j=1;j<=n;j++) {
			if ( lelt(M1,j) ) {
				L1 = lelt(L,j);
				vecupmsunimt(p,L1,M1,j,&L1,&M2);
				Hl = vecpmstovpmp(1,p,Q2,L1);
				M1 = vecpmstovpmp(1,p,Q2,M2);
				leset(L,j,Hl);
			}
		}
		if ( i == n2 ) break;
		M2 = pmsprod(2,p,e1,M3);
		M2 = pmsrem(2,p,M2,F);
		e2 = _0;
		while ( (M2) && (M2 != _0) ) {
			j  = lfirst(M2);
			M2 = lred(M2);
                        e1 = lfirst(M2);
			M2 = lred(M2);
			e1 = pmsrem(1,p,e1,Q2);
			if (e1) e2 = lcomp2(e1,j,e2);
		}
		if ( e2 != _0 ) e1 = linv(e2);
		else e1 = 0;
	}
	M1 = lreduct(M1,n);
	M1 = vecpmstovpmp(1,p,Qp,M1);
	e2 = uprfmsp1fscl(M1);

	Q2 = pmsquot(2,p,F,e2);
	e1 = _0;
	while ( Q2 != _0 ) {
		j  = lfirst(Q2);
		Q2 = lred(Q2);
                M2 = lfirst(Q2);
		Q2 = lred(Q2);
		M2 = pmsrem(1,p,M2,Qp);
		if (M2) e1 = lcomp2(M2,j,e1);
	}
	e1 = linv(e1);

	L = list2(e1,e2);
	L = list3(pz,L,r2);
	return(L);
}
