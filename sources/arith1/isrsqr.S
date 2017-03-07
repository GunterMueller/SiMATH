/*M
.SH NAME
isrsqr - is rational number square ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isrsqr(R)
rat R;

.SH DESCRIPTION
isrsqr() returns returns 1 if R is a square,
0 if R is not a square and -1 in case R is negative.
M*/
/*H
	Version  1      16.12.1991      Joachim Stein
   DATE isrsqr        : 920331
H*/


# include <_arith1.h>

single isrsqr( R ) 
rat R;            

{
/**    Sonderfall: R == 0    **/
  if ( !R ) return(1);

/**    Sonderfall: R negativ, kein Quadrat    **/
  if ( rsign( R ) < 0 ) return( -1 );        

/**    R > 0    **/
  else {
    bind(R);

    if ( !isisqr( lfirst( R ) ) || !isisqr( lsecond( R ) ) ) return(0);
    else return( 1 );
  }
}
