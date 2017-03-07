/*M
.SH NAME
rprod - rational number product

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rprod(R,S)
rat R,S;

.SH DESCRIPTION
rprod() returns R * S.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rprod         : 890501
H*/


# include <_arith1.h>

rat rprod ( R, S )            /* unsafe R,S, t,t1, u1,u2,v2 */
rat R,S;
{
	int r1,r2, s1,s2, t;
	rat T;
    /***    Sonderfaelle    ***/
	if ( R==0 || S==0 )  return( 0 );
	r1 = lfirst( R ),  r2 = lsecond( R );
	s1 = lfirst( S ),  s2 = lsecond( S );
	if ( r2==1 && s2==1 )  {
		t = iprod( r1,s1 );
		bind( t );
		T = list2( t,1 );
		return( T );
	}
	{       int  t1,t2, u1,u2, v1,v2;
		init( u2 ); init( v2 );
		bind( R );  bind( S );
		if ( r2==1 ) {
			igcdcf( r1,s2, &u1,&v2 );
			t = iprod( u1,s1 );
			bind( t );
			T = list2( t,v2 );
			return( T );
		}
		if ( s2==1 ) {
			igcdcf( s1,r2, &v1,&u2 );
			t = iprod( v1,r1 );
			bind( t );
			T = list2( t,u2 );
			return( T );
		}
	    /***    allgemeiner Fall    ***/
		igcdcf( r1,s2, &u1,&v2 );
		bind( u1 );
		igcdcf( s1,r2, &v1,&u2 );
		t1= iprod( u1,v1 );
		bind( t1 );
		t2= iprod( u2,v2 );
		T = list2( t1,t2 );
		return( T );
	}
}
