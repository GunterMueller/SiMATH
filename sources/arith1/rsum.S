/*M
.SH NAME
rsum - rational number sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rsum(R,S)
rat R,S;

.SH DESCRIPTION
rsum() returns R + S.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE rsum          : 890501
H*/


# include <_arith1.h>
 
rat rsum ( R, S )             /* unsafe d,e, r1,r2, s1,s2,s3, t1 */
rat R,S;
{
	list T;
    /***    Sonderfaelle    ***/
	if ( R==0 )  return( S );
	if ( S==0 )  return( R );
	{
		int  r1 = lfirst( R ),  r2 = lsecond( R );
		int  s1 = lfirst( S ),  s2 = lsecond( S );
		int  t1;
	    /***    R oder S ganz    ***/
		if ( r2==1 && s2==1 )
		    if ( t1 = isum(r1,s1) )  {
			bind( t1 );
			T = list2( t1,1 );
			return( T );
		    }
		    else  return( 0 );
		init( t1 );
		if ( r2==1 )  {
			bind( s1 ); bind( s2 );
			t1 = isum( iprod(r1,s2),s1 );
			T = list2( t1,s2 );
			return( T );
		}
		if ( s2==1 )  {
			bind( r1 ); bind( r2 );
			t1 = isum( iprod(s1,r2),r1 );
			T = list2( t1,r2 );
			return( T );
		}
	    /***    allgemein    ***/
		{       int d,e, r3,s3, t2;
			init( d ); init( e ); init( s3 );
			bind( r2 );
			bind( r1 );  bind( s1 );
			d = igcdcf( r2,s2, &r3,&s3 );
			s1 = iprod( s1,r3 );
			r1 = iprod( r1,s3 );
			if  ( (t1=isum(r1,s1)) == 0 )  {
				return( 0 );
			}
			if  ( d!=1  &&  (e=igcd(t1,d)) != 1 )  {
				t1 = iquot(t1,e);
				r2 = iquot(r2,e);
			}
			t2 = iprod( r2,s3 );
			T = list2( t1,t2 );
			return( T );
		}
	}
}
