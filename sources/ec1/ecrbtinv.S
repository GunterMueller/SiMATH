/*M
.SH NAME
ecrbtinv - elliptic curve over rational numbers, birational transformation, inverse transformation                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list ecrbtinv( BT1 )  
list BT1;
                                                                     
.SH DESCRIPTION
.TP 4
.B BT1
 = ( r s t u )  rat r, s, t, u;
 defines the bi-rational transformation BT, 
 ( u != 0 ).
.PP
ecrbtinv computes the bi-rational transformation BT', which is inverse to BT, and returns it as a list 
.PP
    BT1' = ( r' s' t' u' )
    rat r', s', t', u';
.PP
where r' = - r / u^2          , 
      s' = - s / u            ,
      t' = ( r * s - t ) / u^3,
      u' =   1 / u            .
 
                                                               
M*/
                                                                           
/*H
	Version 1	12.11.1992	Josef Gebel
   DATE ecrbtinv      : 921130
H*/

#include<_ec1.h>

list ecrbtinv( BT ) 
    list BT;
{
    list L;
    rat r1, s1, t1, u1, r2, s2, t2, u2, hr;

    bind( BT );
/**    init( u1 ); **/

    init( L );
    init( r1, s1, t1, u1, r2, s2, t2, u2, hr );

    r1 = lfirst( BT );
    s1 = lsecond( BT );
    t1 = lthird( BT );
    u1 = lfourth( BT );

    u2 = rinv( u1 );

    hr = rprod( u2, u2 );
    r2 = rprod( hr, rneg( r1 ) );

    s2 = rprod( u2, rneg( s1 ) );

    hr = rprod( hr, u2 );
    t2 = rprod( s1, r1 );
    t2 = rdif( t2, t1 );
    t2 = rprod( hr, t2 );

    L = list4( r2, s2, t2, u2 );
   
    return( L );
}
