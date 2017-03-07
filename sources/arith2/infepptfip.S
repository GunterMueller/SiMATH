/*M
.SH NAME
infepptfip - integral number field element p-primality test and factorization of the defining polynomial or the minimal polynomial with respect to integer primes
.SH SYNOPSIS
.nf
#include<_arith2.h>

list infepptfip(F, p, Q, ppot, a0, z)  
pol F, a0, z; 
int p, Q, ppot;

.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers
.
.PP
A arises by adjunction of a seperable element to the rational numbers, let this element be denoted by u.        
.TP 4
.B p
is a single prime number.
.TP 4
.B Q
is a power of p, the product of Q and an arbitrary element in a p-maximal overorder of the polynomial order of F is in the polynomial order.
.TP 4
.B ppot
is also a power of p.
.TP 4
.B a0
is a p-primary element in A, represented by a CD-polynomial (s. cdprfcl).
.TP 4
.B z
is an integral element in A, represented by a CD-polynomial (s.cdprfcl).  
.PP
If z is p-primality , i.e. the minimal polynomial of z modulo p has not two different irreducible factors, then infepptfip returns a list, say M, where
M = (mp, pzet), with
.TP 4
mp
is the unique irreducible factor of z, so it is an univariate polynomial over Z/pZ.
.TP 4
zpet
is an integral element in A, represented by a CD-polynomial, the minimal polynomial of pzet has the same degree as F, and
.IP
pzet = z + ppot*a0*m mod (ppot*Z[x]) for m a non negative integer. 
.PP
Is z is not p-primality, infepptfip returns a list, say M, where
M = (0, pzet, Lfact, Lort), with
.TP 4
pzet
as above.
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
.PP
Literature: D.J. Ford, Construction of Maximal Orders over
            a Dedekind Domain,
            Journal of Symbolic Computation p.7-8 1985;
.PP
            Diplomarbeit von R. Boeffgen p.80/103,
            Universitaet des Saarlandes.
                                       

M*/
                                  
/*H
	Version 1       06.08.91        J.Schmitt
   DATE infepptfip    : 910915.9203__
H*/

#include<_arith2.h>

list infepptfip(F,p,Q,ppot,a0,z)
pol F;
int p,Q,ppot;
pol a0,z;
{
	pol mp,Hl,M1,M2,M3,r1,r2,ri,e1,e2,pzet;
	int Qp,Qpp;
	list L,L1,Lfac,Lort;
	single i,j,s,n,n2;
	bind(F,p,Q,ppot,a0,z);
	init(mp,Hl,M1,M2,M3,r1,r2,ri,e1,e2,pzet,Qp,Qpp,L,L1,Lfac,Lort);

	pzet = cdprzmodhom(z,ppot);
	mp   = nfespecmpc2(F,pzet);
	if ( mp != 0 ) mp = pitopmi(1,mp,p);
	else mp = infempmppip(F,pzet,p,1,Q);

	while ( lfirst(mp) < lfirst(F) ) {
		Hl = piiprod(1,lred(a0),ppot);
		Hl = lcomp(lfirst(a0),Hl);
		pzet = cdprsum(pzet,Hl);
		mp = nfespecmpc2(F,pzet);
		if ( mp != 0 ) mp = pitopmi(1,mp,p);
		else mp = infempmppip(F,pzet,p,1,Q);
	}
               

	L = upmicfact(p,mp);
	L1 = _0;
	M1 = lfirst(L);
	L = lred(L);
	M3 = M1;
	while ( L != _0 ) {
		M2 = lfirst(L);
		L = lred(L);
		if ( oequal(M1,M2) ) M3 = pmiprod(1,p,M3,M2);
		else {
			M1 = M2;
			L1 = lcomp(M3,L1);
			M3 = M1;
		}
	}
	L = lcomp(M3,L1);

	if ( lred(L) == _0 ) {                                                 
		L1 = list2(M1,pzet);
		return(L1);          
	}

	do {
		L1 = L;
		s  = 0;
		while ( lred(L1) != _0 ) {
			M1 = lfirst(L1);
			M3 = lred(L1);
			M2 = lfirst(M3);
			if ( lfirst(M1) < lfirst(M2) )  {
				lsfirst(L1,M2);
				lsfirst(M3,M1);
				s = 1;
			}
			L1 = M3;
		}
	} while ( s != 0 );


	M1 = lfirst(L);
	L = lred(L);
	M2 = lfirst(L);
	L = lred(L);

	while ( L != _0 ) {
		M3 = lfirst(L);
		L = lred(L);
		M2 = pmiprod(1,p,M2,M3);
		if ( lfirst(M2) > lfirst(M1) ) {
			M3 = M2;
			M2 = M1;
			M1 = M3;
		}
	}

	n2 = lfirst(M2);	        
	L = upmiegcd(p,M1,M2,&r1,&r2);
	e1 = 0;
	M3 = M2;
	ri = r2;
	Qp = iprod(Q,Q);

	for ( ; ; ) {
		L1 = pmiprod(1,p,M3,ri);
		e2 = upinfeevals(F,L1,pzet);
         	Hl = cdprzmodhom(e2,p);
		do {
			e2 = Hl;
			L1 = piiprod(1,lred(e2),2);
			L = isprod(lfirst(e2),3);
			L = list2(0,L);
			Hl = pidif(1,L,L1);
			Hl = lcomp(lfirst(e2),Hl);
			Qpp = iprod(lfirst(e2),Qp);
			Hl = nfeprodspec(F,Hl,e2,Qpp);
			Hl = nfeprodspec(F,Hl,e2,Qp);
		} while ( !oequal(e2,Hl) );

		if ( e1 == 0 ) {
			e1 = e2;
			M3 = M1;
			ri = r1;
		}
		else    break;
	}
	Lort = list2(e1,e2);

	n = lfirst(F);
	M3 = list2(1,1);
	Qpp = lfirst(e2);
	e2 = lred(e2);
	Qpp = iprod(Qpp,Qp);

	L = _0;
	for(i=n;i>0;i--) {
		L1 = _0;
		for (j=(n+n2+1);j>0;j--) {
			if ( i==j ) L1 = lcomp(Qpp,L1);
			else        L1 = lcomp(0,L1);
		}
		L = lcomp(L1,L);
	}
	for (i=0;i<=n2;i++) {
		M1 = sclfupi(e2,n);
		M2 = _0;
		for (j=n2;j>=0;j--) {
			if ( i==j ) M2 = lcomp(1,M2);
			else        M2 = lcomp(0,M2);
		}
		M1 = lconc(M1,M2);
		for (j=1;j<=n;j++) {
			if ( lelt(M1,j) != 0 ) {
				L1 = lelt(L,j);
				veciunimtr(L1,M1,j,&L1,&M2);
				M1 = vecitovecmi(Qpp,M2);
				Hl = vecitovecmi(Qpp,L1);
				leset(L,j,Hl);
			}
		}
		M2 = piprod(1,e2,M3);
		Hl = piqrem(1,M2,F,&M2);
		e2 = pitopmi(1,M2,Qpp);
	}
	M1 = lreduct(M1,n);
	r2 = upifscl(M1);
	r2 = pitopmi(1,r2,Qp);
	r1 = pmiqrem(1,Qp,F,r2,&Hl);
	Lfac = list2(r1,r2);
	L1 = list4(0,pzet,Lfac,Lort);
	return(L1);
}
