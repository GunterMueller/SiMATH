/*M
.SH NAME
impds - integer medium prime divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int impds(N,A,B,pP,pQ)
int N,A,B,*pP,*pQ;

.SH DESCRIPTION
impds() calculates a factor *pP of N, the value *pQ = N / *pP and returns *pP.
Let 2 <= A <= B <= N.
If N has a prime factor >= 13 in [A,B] and no factor in [13,A[
then *pP equals the smallest prime factor of N in [A,B].
If N has no prime factor in [13,B] then *pP equals 1.
In any other case *pP is assigned some factor of N.

M*/
/*H
	Version 1       25.02.1987              Pascale Serf
	Version 2       05.03.1987              UZ230 jetzt Array statt
						  Liste
						  P. Serf
	Version 3       06.08.1987              DIFF statt UZ2310
						  P. Serf           
	Version 4	08.11.1990		Dokumentation geaendert
						wegen Testversion.	
						Marc Conrad 
   DATE impds         : 890501.901120
H*/


# include <_arith1.h>

int impds(N,A,B,pP,pQ)
int N,A,B,*pP,*pQ;
{
	int P,Q;
	single r,r1,*L1;

	bind(N,A,B);
	init(P,Q);

	/*    Bestimmung des ersten moeglichen Teilers    */
	r = isrem(A,2310);
	L1 = DIFF + 271;
	r1 = 1;
	while ( r1 < r ) {
		r1 = r1 + *L1;
		L1++;
		if ( *L1 == 0 ) L1 = DIFF;
	}
	P = isum(A,r1-r);

	/*    wiederholte probeweise Division    */
	while ( icomp(P,B) <= 0 ) {
		if ( P < BASIS ) isqrem(N,P,&Q,&r);
		else iqrem(N,P,&Q,&r);
		if ( r == 0 ) {
			*pP = P;
			*pQ = Q;
			return(P);
		}
		if ( P < BASIS ) {
			P  = P + *L1;
			if ( P >= BASIS ) P = list2(P-BASIS,1);
		}
		else P = isum(P,*L1);
		L1++;
		if ( *L1 == 0 ) L1 = DIFF;
	}

	/*    kein Teiler gefunden    */
	*pP = 1;
	*pQ = N;
	return(1);
}
