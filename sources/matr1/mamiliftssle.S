/*M
.SH NAME
mamiliftssle - matrix of modular integers, lifting the modular integers solution of a system of linear equations to a solution modulo a power of the integer

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mamiliftssle(M, A, x, b, k)
int M;
matrix A;
vec x, b;
single k;

.SH DESCRIPTION
mamiliftssle() tries to compute and return a solution of A*x = b modulo M^k.
The return value is a vector of length n over Z/(M^k)Z.
If a non-trivial divisor T of M occurs when inverting in Z/MZ,
no solution will be computed and the list (_0, T) will be returned.

.PP
.TP 4
.B M
>1 is an integer.
.TP 4
.B A
is a mxn matrix over Z/(M^k)Z with full rank.
.TP 4
.B x
is a vector of length n over Z/(M^k)Z with A*x = b modulo M.
.TP 4
.B b
is a vector of length m over Z/(M^k)Z.
.TP 4
.B k
is a positive single.

.SH NOTE
.PP
If A does not have full rank, the result may be incorrect.
M*/
/*H
	Version 1	11.02.94	Joachim Schmitt
   DATE mamiliftssle  : 941201
H*/

#include <_matr1.h>

vec mamiliftssle(I,M,x,w,k)
int I;
matrix M;
vec x,w;
single k;
{
	vec u,v;
	int Ie,N;
	single i,j;
	bind(I,M,x,w);
	init(u,v,Ie,N);

	if(k==1) return(x);
	Ie = I;
	for(i=1;i<k;i++) {
		u = maivecmul(M,x);
		u = vecidif(w,u);
		v = _0;
		while(u!=_0) {
			N = lfirst(u);
			u = lred(u);
			N = iquot(N,Ie);
			v = lcomp(N,v);
		}
		u = linv(v);
		u = vecitovecmi(I,u);
		j = mamsssle(I,M,u,&v,&u);
		if(lfirst(v)==_0) return(v);
		x = vecilc(1,Ie,x,v); /* x + (I^i)*v */
		Ie = iprod(Ie,I);
	}
	return(x);
}
