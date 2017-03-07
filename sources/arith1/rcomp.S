/*M
.SH NAME
rcomp - rational number comparison

.SH SYNOPSIS
.nf
#include<_arith1.h>

single rcomp(R,S)
rat R,S;

.SH DESCRIPTION
rcomp() returns the sign of R-S
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen    
        Version  2      08.05.1989      C.H/U.S divs
   DATE rcomp         : 890501.890601
H*/


# include <_arith1.h>

single rcomp ( R, S )            /* unsafe r2,s1,T */
rat  R,S;
{
    /***    Sonderfaelle    ***/
	if ( R==0 )  return(-rsign(S));
	if ( S==0 )  return(rsign(R));
	{
		single t;
		int  T;
		int  r1 = lfirst( R ),  r2 = lsecond( R );
		int  s1 = lfirst( S ),  s2 = lsecond( S );
	    /***    verschiedene oder gleiche Vorzeichen    ***/
		if ( t = isign(r1) - isign(s1) )  return( divs( t,2 ) );
		bind( r2 ); bind( s1 );
		T = iprod( r1,s2 );
		bind( T );
		t = icomp( T, iprod(r2,s1) );
		return( t );
	}
}
