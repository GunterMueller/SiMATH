/*M
.SH NAME
ecrbtconc - elliptic curve over rational numbers, birational transformation, concatenation of transformations

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrbtconc(BT1, BT2)  
list BT1, BT2;

.SH DESCRIPTION
.TP 4
.B BTi 
 = ( ri si ti ui )          i = 1,2
 rat ri, si, ti, ui;
 define the bi-rational transformations BT1 and BT2.
.PP
ecrbtconc computes the concatenation BT of the bi-rational transformations BT1 and BT2.
.PP
     BT = BT2 o BT1,
.PP
ecrbtconc returns BT as a list ( r s t u ) rat r, s, t, u;
.PP
where r = u1^2 * r2                  + r1,
      s = u1   * s2                  + s1,
      t = u1^3 * t2 + u1^2 * r2 * s1 + t1,
      u = u1   * u2.

M*/

/*H
	Version 1	06.04.1992	Josef Gebel (neues Konzept)
   DATE ecrbtconc     : 930531
H*/

#include<_ec1.h>

list ecrbtconc( BT1, BT2 ) 
list BT1, BT2;
{
    rat r1, s1, t1, u1;
    rat r2, s2, t2, u2;
    rat r, s, t, u, hr;

    bind( BT1, BT2 );

    init( r1, s1, t1, u1 );
    init( r2, s2, t2, u2 );
    init( r, s, t, u, hr );

    r1 = lfirst ( BT1 );
    s1 = lsecond( BT1 );
    t1 = lthird ( BT1 );
    u1 = lfourth( BT1 );

    r2 = lfirst ( BT2 );
    s2 = lsecond( BT2 );
    t2 = lthird ( BT2 );
    u2 = lfourth( BT2 );

    u  = rprod( u1, u2 );

    r  = rprod( u1, u1 );
    r  = rprod(  r, r2 );
    r  = rsum (  r, r1 );

    s  = rprod( u1, s2 );
    s  = rsum (  s, s1 );

    t  = rprod( u1, t2 );
    hr = rprod( s1, r2 );
    t  = rsum (  t, hr );
    t  = rprod(  t, u1 );
    t  = rprod(  t, u1 );
    t  = rsum (  t, t1 );
   
    return( list4( r, s, t, u ) );
}
