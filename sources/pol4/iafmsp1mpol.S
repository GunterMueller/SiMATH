/*M
.SH NAME
iafmsp1mpol - integral algebraic function over modular single primes, transcendence degree 1, minimal polynomial

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol iafmsp1mpol(p, F, a, Q)  
single p; 
pol F, a, Q;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x].
.TP 4
.B a
is an integral element in A, represented by a CD-poly-nomial (s. cdprfmsp1fcl). 
.TP 4
.B Q   
is a monic polynomial in (Z/pZ)[x] and the power of an irreducible polynomial, say P, in (Z/pZ)[x]. The prod-uct of a and a power of power of P must lie into the polynomial order of F.
The product of Q with an arbi-trary element in the P-maximal over-order of the poly-nomial order of F lies in the polynomial order.
.PP
iafmsp1mpol returns the minimal polynomial of a over (Z/pZ)[x], a monic and univariate polynomial over (Z/pZ)[x].
 
.SH SEE ALSO
cdprfmsp1fcl

M*/
                  
/*H
	Version 1       16.01.90	J.Schmitt
   DATE iafmsp1mpol   : 901120.9203__
H*/

#include<_pol4.h>

pol iafmsp1mpol(p,F,a,Q)
single p;
pol F,a,Q;
{
	single ent,n,i,k,s,z;
	list nzks,E,Cneu,L,N,Apot,U,Up,Vp;
	init(nzks,E,Cneu,L,N,Apot,U,Up,Vp);
	bind(F,a,Q);
                   
	E = list2(0,1);
	if (a==0) {
		N = list2(1,E);		
		return(N);
	}                  
	L = _0;          
	n = lfirst(F);        
	Apot = list2(0,Q);
	Cneu = sclfuprfmsp1(Apot,n);	

	k = 0;         
	N = _0;
	for ( ; ; ) {
		L = _0;
		for (i=n;i>=0;i--) {
			if (i==k) L = lcomp(E,L);
			else      L = lcomp(0,L);
		}                           
		Cneu = lconc(Cneu,L);
		k = k+1;
		s = k;
		N = lcomp(Cneu,N);
      		for (z=1;z<=n;z++) {
			ent = 1;
			nzks = lelt(Cneu,z);
			if ( ( s==1 ) && ( nzks != 0 ) ) {
				Vp = pmsprod(2,p,Apot,lred(a));
				Vp = pmsrem(2,p,Vp,F);
				if (!Vp) Apot = 0;
				else {
				    Up = _0;
				    while (Vp!=_0) {
					i  = lfirst(Vp);
					Vp = lred(Vp);
					Apot = lfirst(Vp);
					Apot = pmsquot(1,p,Apot,lfirst(a));
					Up = lcomp2(Apot,i,Up);
					Vp = lred(Vp);
                     		    }
				    if ( Up != _0 ) Apot = linv(Up);
				    else Apot = 0;
                                }
				Cneu = sclfuprfmsp1(Apot,n);
				ent = 0;
				break;
			}
			if (nzks != 0) {                        
				U = lelt(N,s);
				vecupmsunimt(p,U,Cneu,z,&Up,&Vp);
				U = Up;
				Cneu = Vp;
				leset(N,s,U);
				lsfirst(N,Cneu);
			}
			Up = lelt(N,s);
			nzks = lelt(Up,z);
			if ( nzks != 0 ) s = s-1;
		}
		if (ent == 1) break;
	}                                   
	N = lreduct(Cneu,n);
	N = uprfmsp1fscl(N);
	Up = lsecond(N);
	i = lsecond(Up);
	if ( i != 1 ) {
		i = msinv(p,i);
                Up = list2(0,i);
		N = pmsupmsprod(2,p,N,Up);
	}
        return(N);
}
