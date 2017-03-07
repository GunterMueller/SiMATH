/*M
.SH NAME
isisqr - is integer square ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isisqr(A)
int A;

.SH DESCRIPTION
isisqr() returns 1 if A is a square,
0 if A is not a square and -1 in case A is negative.
M*/
/*H
	Version  1      16.12.1991      Joachim Stein
	Version  2	03.03.1994	bind(A) ergaenzt.  PS
   DATE isisqr        : 920331.940315
H*/


# include <_arith1.h>

single isisqr( A ) 
int A;

{
/**    Sonderfall: A negativ, kein Quadrat    **/
  if ( isign( A ) < 0 )  return( -1 );        

/**    A >= 0    **/
  {
    int B;

    init( B ); 
    bind( A );

    B = isqrt( A );
    B = iprod( B, B );
    if ( icomp( A, B ) ) return( 0 );
    else return( 1 ); 
  }
}

