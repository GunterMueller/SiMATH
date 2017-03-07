/*M
.SH NAME
afmsp1minpol - algebraic function over modular single primes, transcendence
degree 1, minimal polynomial

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol afmsp1minpol(p, F, a)  
single p; 
pol F, a; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra over Z/(pZ)(x), i.e. F is a monic, separable and univariate polynomial over Z/(pZ)[x].
.TP 4
.B a 
is an element in this algebra, represented by a CD-polynomial (s. cdprfmsp1fcl).
.PP
afmsp1minpol returns the minimal polynomial of a over Z/(pZ)[x].

.SH SEE ALSO
cdprfmsp1fcl

M*/
                
/*H
	Version 1    	16.03.90	J.Schmitt
   DATE afmsp1minpol  : 901120.9203__
H*/

#include<_pol4.h>

pol afmsp1minpol(p,F,a)
single p;
pol F,a;
{
	single ent,n,i,k,s,z;   
	rfunc v,v1;
	list nzks,E,Cneu,L,N,Apot,U,Up,Vp;
	init(v,v1,nzks,E,Cneu,L,N,Apot,U,Up,Vp);
	bind(F,a);

	N = list2(0,1);
	E = list2(N,N);

	if (a==0) {
		E = list2(1,N);
		return(E);
	}                  

	n = lfirst(F);
	F = lcomp(N,F);
	F = uprfmsp1fcdp(p,F);        
	a = uprfmsp1fcdp(p,a);

	Apot = list2(0,E);
	Cneu = sclfuprfmsp1(Apot,n);	
	k = 0;         
	L = _0;
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
				Vp = prfmsp1prod(1,p,Apot,a);
				Vp = prfmsp1qrem(1,p,Vp,F,&Apot);
				Cneu = sclfuprfmsp1(Apot,n);
				ent = 0;
				break;
			}
			if (nzks != 0) {
				U = lelt(N,s);                
				v = lelt(U,z);
				if (!v) {
					v1 = list2(0,1);
					v1 = list2(v1,v1);
					Up = Cneu;
					v1 = rfmsp1neg(p,v1);
					Vp = vecrfmsp1lc(p,v1,0,U,Cneu);
				}
				else {
					v1 = rfmsp1neg(p,nzks);
					Vp = vecrfmsp1lc(p,v1,v,U,Cneu);
					v1 = rfmsp1inv(p,v);
					Up = vecrfmsp1lc(p,v1,0,U,Cneu);
				}
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
	N = cdprfmsp1fup(p,N);
	N = lred(N);
	U = list2(0,1);
	Vp = lred(N);
	Up = lfirst(Vp);
	Vp = lred(Vp);
	while ( ( !oequal(Up,U) ) && ( Vp != _0 ) ) {
		Vp = lred(Vp);
		Up = upmsgcd(p,Up,lfirst(Vp));
		Vp = lred(Vp);
	}
 	Vp = lsecond(N);
 	Vp = pmsquot(1,p,Vp,Up);
 	z  = lsecond(Vp);
 	if ( z != 1 ) Up = pmsprod(1,p,Up,list2(0,z));
	N = pmsupmsquot(2,p,N,Up);
        return(N);
}
