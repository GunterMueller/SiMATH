/*M
.SH NAME
infempmppip - integral number field element minimal poly-nomial modulo p-power with respect to integer primes

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol infempmppip(F, a, p, e, Q)  
pol F, a; 
int p, Q; 
single e;
 
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over the rational numbers, i.e. F is a monic, sepa-rable and univariate polynomial over the integral num-bers.
.TP 4
.B p
is a prime number.
.TP 4
.B e
is a positive number, e < BASIS.
.TP 4
.B a
is an element in A, represented by a CD-polynomial (s. cdprfcl). A power of p had to exist, such that the product of that power and a is in the polynomial order of F.
.TP 4
.B Q
is a power of p. The product of Q with an arbitrary element in the p-maximal over-order of the polynomial order of F is in the polynomial order.
.PP
Let N be the minimal polynomial of a over the integral numbers.
infeminpmpp returns a monic and univariat poly-nomial, say M, over Z/(p^e)Z, such that
.IP
N = M mod (p^e).

.SH SEE ALSO
R.Boeffgen, Diplomarbeit p. 59, p. 72. and p. 134-136. University Saarbruecken.
                                                                               
M*/
        
/*H
	Version 1       06.08.91	J.Schmitt
   DATE infempmppip   : 910915.9203__
H*/

#include<_pol2.h>

pol infempmppip(F,a,p,e,Q)
pol F,a;
int p;
single e;
int Q;
{
	single ent,n,i,k,s,z;
	int pp,nzk,nzs;
	list M,Cneu,L,N,Ip,Jp,Apot,U,Up,Upp,Vp,Vpp;
	init(pp,nzk,nzs,M,Cneu,L,N,Ip,Jp,Apot,U,Up,Upp,Vp,Vpp);
	bind(F,a,p,Q);

	if (a==0) {
		M = list2(1,1);
		return(M);
	}

	n = lfirst(F);
	pp = iexp(p,e);
	Apot = list2(0,Q);
	k = 0;
	N = _0;
	Cneu = sclfupi(Apot,n);
	for ( ; ; ) {
		L = _0;
		for (i=n;i>=0;i--) {
			if (i==k) L = lcomp(1,L);
			else      L = lcomp(0,L);
		}
		Cneu = lconc(Cneu,L);
		k = k+1;
		s = k;
		N = lcomp(Cneu,N);
		for (z=1;z<=n;z++) {
			ent = 1;
			nzk = lelt(Cneu,z);
			if ( (s==1) && (nzk!=0) ) {
				Ip = piprod(1,Apot,lred(a));
				Up = piqrem(1,Ip,F,&Jp);
				Apot = piiquot(1,Jp,lfirst(a));
				Cneu = sclfupi(Apot,n);
				ent = 0; break;
			}
			if (nzk != 0) {
				U = lelt(N,s);
				veciunimtr(U,Cneu,z,&U,&Cneu);
				Up = lreduct(U,(n-1));
				Vp = lreduct(Cneu,(n-1));
				Upp = vecitovecmi(pp,lred(Up));
				Vpp = vecitovecmi(pp,lred(Vp));
				lsred(Up,Upp);
				lsred(Vp,Vpp);
				leset(N,s,U);
				lsfirst(N,Cneu);
			}
			nzs = lelt(N,s);
			nzs = lelt(nzs,z);
			if ( nzs != 0 ) s = s-1;
		}
		if (ent == 1) break;
	}
	M = lreduct(Cneu,n);
	M = upifscl(M);
	if ( icomp(lsecond(M),0) < 0 ) M = pineg(1,M);
	return(M);
}
