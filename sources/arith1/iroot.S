/*M
.SH NAME
iroot - integer root

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iroot(A,n,ps)
int A;
single n,*ps;

.SH DESCRIPTION
iroot() returns the integer part of the n-th root of A
for n>0 and A>=0 and sets *ps = sign(A - B^n).
M*/
/*H
	Version  1      28.07.1986      M.A.Reichert
	Version  2      12.01.1987      R. Boeffgen
					n=1 und A=0 jetzt zugelassen.
   DATE iroot         : 890501
H*/


# include <_arith1.h>

int iroot ( A , n , ps )            /* safe C,E */
int A;
single n;
single *ps;
{
	single  k,m,q,r,s,t,u;
	int  B,B1,C,D,E,R;
    /***    A Null oder n Eins    ***/
	if ( n==1 || A==0 )  s = 0,  B = A;
	else  {
    /***    Berechne erste Naeherung    ***/
	    bind( A );  init( B );
	    k = ilog2( A );
	    m = n - 1;
	    q = k / n;
	    r = k % n;
	    u = ( 4*r ) / n;
	    if ( q >= 2 )  B = ip2prod( u+5, q-2 );
	    else B = 4;
    /***    Schleife : modifiziertes Newton Verfahren    ***/
	    init( D );  init( R );
	    do {
		    C = iexp( B,m );
		    iqrem( A,C, &D,&R );
		    if ( (t = icomp(B,D)) > 0 ) {
			    E = isprod( B,m );
			    B = isquot( isum(E,D), n );
		    }
	    } while ( t > 0 );
    /***    Test ob das Ergebnis zu klein ist    ***/
	    if ( t==0 )  s = isign( R );
	    else {
		    B1 = isum( B,1 );
		    bind( B1 );
		    s = icomp( A, iexp(B1,n) );
		    if ( s >= 1 )  B = B1;
		    else  s = 1;
	    }
	}
    /***    Ergebnis    ***/
	*ps = s;
	return( B );
}
