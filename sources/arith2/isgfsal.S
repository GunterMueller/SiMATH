/*M
.SH NAME
isgfsal - is Galois-field with single characteristic arithmetic list ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isgfsal(p, AL)  
single p; 
list AL;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.PP
isgfsal returns 
.TP 4
1,
if AL = (G AL1) can be seen as the arithmetic list for GF(p^n) (s.gfsalgen), where n = llength(AL1) + 1, and
.TP 4
0,
else.
 
.SH SEE ALSO
gfsalgen

M*/
                                  
/*H
	Version 1       04.12.1987              Pascale Serf
	Version 2       21.04.1988              p vom Typ single,
						AL vom Typ list.    PS
   DATE isgfsal       : 890501.9203__
H*/


# include <_arith2.h>

single isgfsal(p,AL)
single p;
list AL;
{
	single n,n1,i,j;
	pol G,P,P1;
	list AL1,AL2;

	bind(AL);
	init(G,P,P1,AL1,AL2);

    /***    Test, ob AL Laenge 2 hat    ***/
	if ( llength(AL) != 2 ) return(0);

	G = lfirst(AL);

    /***    Test, ob G korrekt    ***/
	if ( !isimupms(p,G) ) return(0);

	AL1 = lsecond(AL);

    /***    Test, ob AL1 korrekt   ***/
	n = lfirst(G);
	/*    Spezialfall : n=1 && AL1=_0    */
	if ( n == 1 && AL1 == _0 ) return(1);
	/*    allgemeiner Fall    */
	if ( llength(AL1) != n-1 ) return(0);
	AL2 = AL1;
	while ( AL2 != _0 ) {
		G = lfirst(AL2); AL2 = lred(AL2);
		if ( !isdpol(1,G) || lfirst(G)>=n || !ispms(1,p,dptop(1,G)) )
			return(0);
	}

	/*    Arithmetikliste AL2, die zum letzten Element von AL1 gehoert    */
	G = lfirst(llast(AL1));
	AL2 = list1(G);
	P = G;

	n1 = 2*n - 2;
	for ( i=n+1 ; i<=n1 ; i++ ) {
		P = udpmsprod(p,list3(1,1,0),P);
		if ( lfirst(P) == n ) {
			P = lred(P);
			P1 = udpmsprod(p,list2(0,lfirst(P)),G);
			P = lred(P);
			j = 0;
			while ( lfirst(P) == 0 ) {
				P = lred(P);
				if ( P == _0 ) { P = 0; break; }
				j++;
			}
			if ( P ) P = lcomp(n-1-j,P);
			P = udpmssum(p,P1,P);
		}
		AL2 = lcomp(P,AL2);
	}

	/*    Test, ob AL2 = AL1    */
	if ( !oequal(AL2,AL1) ) return(0);

	return(1);
}
