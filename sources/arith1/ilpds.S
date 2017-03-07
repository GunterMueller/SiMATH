/*M
.SH NAME
ilpds - integer large prime divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ilpds(N,A,B,pP,pN1)
int N,A,B,*pP,*pN1;

.SH DESCRIPTION
If N has at least one factor in [A,B],
then ilpds() sets *pP to the smallest one of these factors
and *pN1 to N / *pP. Otherwise *pP = 1 and *pN1 = N.
The returned value is always equal to *pP.
.TP 4
.B N
must not have prime factors < 17.
.TP 4
.B A,B
must satisfy 2 <= A <= B <= isqrt(N) and A*B < N.
M*/

/*H
	Version 1       17.3.1987               Pascale Serf
   DATE ilpds         : 890501
H*/


# include <_arith1.h>

int ilpds(N,A,B,pP,pN1)
int N,A,B,*pP,*pN1;
{
	int X,X1,X2,Q,R,Y,Y1;
	single s,m,r,r1,r2;
	list L,L1;

	bind3(N,A,B);
	init5(X,X1,X2,Q,R); init4(Y,Y1,L,L1);

	/***    Berechnung von Grenzen X1 und X2 fuer X   ***/
	iqrem(N,B,&Q,&R);
	X1 = isum(B,Q);
	isqrem(X1,2,&X1,&s);
	if ( R != 0 || s != 0 ) X1 = isum(X1,1);
	Q = iquot(N,A);
	X2 = isum(A,Q);
	X2 = isquot(X2,2);

	/***    Fermat'sche Restliste wird berechnet
		und absteigend sortiert    ***/
	L = ifrl(N,&m);
	L = lsbmsort(L);
	L = linv(L);

	/***    Berechnung des Startwertes fuer X    ***/
	r = isrem(X2,m);
	L1 = lcopy(L);
	while ( L1 != _0 && r < lfirst(L1) ) L1 = lred(L1);
	if ( L1 == _0 ) {
		L1 = lcopy(L);
		s = m;
	}
	else s = 0;
	r1 = lfirst(L1);
	L1 = lred(L1);
	s = s + r - r1;
	X = idif(X2,s);

	/***    Werte fuer X durchprobieren    ***/
	while ( icomp(X,X1) >= 0 ) {
		Y1 = idif(iprod(X,X),N);
		Y = isqrt(Y1);
		if ( icomp(iprod(Y,Y),Y1) == 0 ) {
			*pP = idif(X,Y);
			*pN1 = isum(X,Y);
			return(*pP);
		}
		if ( L1 != _0 ) {
			r2 = lfirst(L1);
			L1 = lred(L1);
			s = r1 - r2;
		}
		else {
			r2 = lfirst(L);
			L1 = lred(L);
			s = m + r1 - r2;
		}
		r1 = r2;
		X = idif(X,s);
	}

	/***    kein Teiler gefunden    ***/
	*pP = 1;
	*pN1 = N;
	return(1);
}
