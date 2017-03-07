/*M
.SH NAME
iafmsp1mpmpp - integral algebraic function over modular single primes, transcendence degree 1, minimal polynomial modulo power of an univariate prime polynomial over modu-lar single primes

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol iafmsp1mpmpp(p, F, a, P, e, Q)  
single p, e; 
pol F, a, P, Q;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, se
parable and univariate polynomial over the polynomial ring (Z/pZ) [x].  
.TP 4
.B a
is an integral element in A, represented by a CD-poly-nomial (s. cdprfmsp1fcl).
.TP 4
.B P
is an univariate polynomial over (Z/pZ)[x]. The prod-uct of a and a power of power of P must lie into the polynomial order of F.
.TP 4
.B e
is a positive single.
.TP 4
.B Q
is a power of P. The product of Q with an arbitrary element in the P-maximal over-order of the polynomial order of F lies in the polynomial order.
.PP
Let A be the minimal polynomial of a over (Z/pZ)[x].
iafmsp1mpmpp returns a monic and univariate polynomial over (Z/pZ [x])/((P^e)*(Z/pZ [x])), say M, 
such that 
.IP
M = A mod (P^e).

.SH SEE ALSO
cdprfmsp1fcl

M*/
           
/*H
	Version 1       16.12.89        J.Schmitt
   DATE iafmsp1mpmpp  : 901120.9203__
H*/

#include<_pol4.h>

pol iafmsp1mpmpp(p,F,a,P,e,Q)
single p;
pol F,a,P;
single e;
pol Q;
{
	single ent,n,i,k,s,z;
	pol pp,nzks;
	list E,Cneu,L,N,Apot,U,Up,Upp,Vp,Vpp;
	init(pp,nzks,E,Cneu,L,N,Apot,U,Up,Upp,Vp,Vpp);
	bind(F,a,P,Q);
                      
	E = list2(0,1);
	if (a==0) {
		N = list2(1,E);		
		return(N);
	}                  

	L = _0;          
	n = lfirst(F);
	pp = pmsexp(1,p,P,e);
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
					i = lfirst(Vp);
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
				Up = lreduct(U,(n-1));
				Vp = lreduct(Cneu,(n-1));
				Upp = vecpmstovpmp(1,p,pp,lred(Up));
				Vpp = vecpmstovpmp(1,p,pp,lred(Vp));
				lsred(Up,Upp);
				lsred(Vp,Vpp);
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
