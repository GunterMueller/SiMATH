/*M
.SH NAME
mamiclanssle - matrix of modular integers, combining Lanczos algorithm for determining a solution of a system of linear equations

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mamiclanssle(m, A, b, L, sym)
int m;
matrix A;
vec b;
list L;
single sym;

.SH DESCRIPTION
mamiclanssle() tries to compute and return a solution of A*x=b.
First, this function computes the solutions x_p with
A*x_p = b modulo p^k with p^k || m for all p in L with p|m.
Then these local solutions are combined using the CRA.

.PP
.TP 4
.B m
>1 is an integer.
.TP 4
.B A
is a mxn matrix over Z/mZ.
.TP 4
.B b
is a vector of length m over Z/mZ.
.TP 4
.B L
is a possibly empty list of prime numbers.
L should contain all known prime factors of m.
.TP 4
.B sym
is either 0 or 1, where 1 indicates that A is a symmetric matrix.

.SH NOTE
.PP
If A does not have full rank, the result may be incorrect.
.PP
mamiclanssle() is very efficient for matrices with many zeroes.
M*/
/*H
	Version 1	08.02.94	Joachim Schmitt
   DATE mamiclanssle  : 941201
H*/

#include <_matr1.h>

vec mamiclanssle(M,A,w,L,sym)
int M;
matrix A;
vec w;
list L;
single sym;
{
	int m,p,pk;
	matrix Ap;
	vec wp,Sp,G;
	single k;
	bind(M,A,w,L);
	init(m,p,pk,Ap,wp,Sp,G);

	m = 1;
	while(L!=_0) {
		p = lfirst(L);
		L = lred(L);
		k = iavalint(p,M);
		if(k) {
			pk = iexp(p,k);
			M  = iquot(M,pk);
			Ap = maitomami(p,A);
			wp = vecitovecmi(p,w);
			Sp = mamilanssle(p,Ap,wp,sym);
			Ap = maitomami(pk,A);
			Sp = mamiliftssle(p,Ap,Sp,wp,k);
			if(m==1) G = Sp;
			else {
				Ap = _0;
				p  = mihom(pk,m);
				p  = miinv(pk,p);
				while(Sp!=_0) {
					wp = micra(m,pk,p,lfirst(G),lfirst(Sp));
					G  = lred(G);
					Sp = lred(Sp);
					Ap = lcomp(wp,Ap);
				}
				G = linv(Ap);
			}
			if(M==1) return(G);
			m  = iprod(m,pk);
		}
	}

/*	ein Vorab-Test : A*G = w modulo m	*/

	if(m>1) {
		Ap = maitomami(m,A);
		Ap = mamivecmul(m,Ap,G);
		wp = vecitovecmi(m,w);
		Ap = vecmidif(m,Ap,wp);
		while(Ap!=_0) { 
			if(lfirst(Ap)) return(w);
			Ap = lred(Ap);
		}
	}


	Ap = maitomami(M,A);
	wp = vecitovecmi(M,w);
	Sp = mamilanssle(M,Ap,wp,sym);
	
	if(lfirst(Sp)!=_0) {
	    if(m==1) G = Sp;
	    else {
		Ap = _0;
		p  = mihom(M,m);
		p  = miinv(M,p);
		while(Sp!=_0) {
			wp = micra(m,M,p,lfirst(G),lfirst(Sp));
			G  = lred(G);
			Sp = lred(Sp);
			Ap = lcomp(wp,Ap);
		}
		G = linv(Ap);
	    }
	    return(G);
	}

	pk = lsecond(Sp);
	M  = iquot(M,pk);
	p  = igcd(pk,M);
	if(p==1) {
	    for(k==1;k<3;k++) {
		Ap = maitomami(M,A);
		wp = vecitovecmi(M,w);
		Sp = _0;
		Sp = mamiclanssle(M,Ap,wp,Sp,sym);
		if(m==1) G = Sp;
		else {
			Ap = _0;
			p  = mihom(M,m);
			p  = miinv(M,p);
			while(Sp!=_0) {
				wp = micra(m,M,p,lfirst(G),lfirst(Sp));
				G  = lred(G);
				Sp = lred(Sp);
				Ap = lcomp(wp,Ap);
			}
			G = linv(Ap);
		}
		m = iprod(m,M);
		M = pk;
	    }
	    return(G);
	}
/*   
		Ap = maitomami(pk,A);
		wp = vecitovecmi(pk,w);
		Sp = mamiclanssle(pk,Ap,wp,_0,sym);
	
		Ap = _0;
		p  = mihom(pk,m);
		p  = miinv(pk,p);
		while(Sp!=_0) {
			wp = micra(m,pk,p,lfirst(G),lfirst(Sp));
			G  = lred(G);
			Sp = lred(Sp);
			Ap = lcomp(wp,Ap);
		}
		G = linv(Ap);
		return(G);
	}
*/
}
