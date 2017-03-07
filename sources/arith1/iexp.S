/*M
.SH NAME
iexp - integer exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iexp(A, n)
int A;
single n;

.SH DESCRIPTION
iexp() returns A^n.

.SH BUG
iexp(A, 0) returns 1 even if A is 0.
M*/

/*H
	Version 1       23.06.1986      R. Boeffgen
	Version 2	22.11.1994	Neuer Dokumentationsstandard. MP
   DATE iexp          : 890501.941201
H*/


# include <_arith1.h>

int iexp ( A, n )              /* unsafe A,B */
int A;
single n;
{
    /***    Sonderfaelle    ***/
	if ( n==0 )  return( 1 );
	if ( n==1 || A==0 )  return( A );
	if ( !issingle(n)){
	        errmsgio("iexp", "A102");
		return(ERROR);
	}
        if( n<0 ){
	        errmsgio("iexp", "A105");
		return(ERROR);
	}
	{
    /***    allgemeiner Fall    ***/
		int B;
		bind( A, B );
		for ( B = 1 ; n ; n >>= 1 )  {
			if (n&1)  B = iprod( B,A );
			A = isquare( A );
		}
		return( B );
	}
}
