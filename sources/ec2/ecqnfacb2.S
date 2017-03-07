/*M
.SH NAME
ecqnfacb2 - elliptic curve over quadratic number field, actual model,
Tate value b2

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacb2(E)
list E;

.SH DESCRIPTION
ecqnfacb2() returns the Tate value b2 of the elliptic curve E. If b2 is
not yet computed, it will be computed together with b4, b6, and b8 and
stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacb2     : 931130
H*/

#include<_ec2.h>

static list ecqnftavab(int,list);

nfel ecqnfacb2( E ) 
list E;
{
    if( lsecond( lfirst( E ) ) == _0 ) 
    {
	int D;
	list L1, L2;

        bind( E );

	init( D );
	init( L1, L2 );

	D  = ecqnfflddisc( E );
	L1 = lfirst( lfirst( E ) );
	L2 = ecqnftavab( D, L1 );

	L1 = lfirst( E );
	leset( L1, 2, L2 );
	leset(  E, 1, L1 );
    }
    
    return( lfirst( lsecond( lfirst( E ) ) ) );
}

/*c
		    ecqnftavab( E )

	"elliptic curve over quadratic number field, Tate values 
	 b2, b4, b6, b8"
	Quellbibliothek: srclib.ec2
	Include-Datei:   _ec2.h
	static list ecqnftavab( D, L )  int D; list L;
	Lb = ecqnftavab( D, L );
	Dabei muss gelten:
          - D ist aus Z\{0,1} und quadratfrei.
	  - L = ( a1  a2  a3  a4  a6 )  nfel a1, a2, a3, a4, a6;
	    enthaelt die Koeffizienten einer elliptischen Kurve 
	    ueber K = Q(D^(1/2)).
        ecqnftavab liefert eine 4-elementige Liste 
	   ( b2  b4  b6  b8 )  nfel b2, b4, b6, b8;
        mit den Tate'schen Groessen b2, b4, b6, b8 der durch 
        a1, a2, a3, a4, a6 gegebenen ellitischen Kurve E/K.
        ecqnftavab ist static zu ecqnfacb2.
c*/

static list ecqnftavab( D, L )
int D;
list L;
{
    nfel a1, a2, a3, a4, a6, b2, b4, b6, b8, hi;
    init( a1, a2, a3, a4, a6, b2, b4, b6, b8, hi );

    bind( D, L );

    a1 = lfirst ( L );
    a2 = lsecond( L );
    a3 = lthird ( L );
    a4 = lfourth( L );
    a6 = lfifth ( L );

    b4 = qnfprod ( D, a1, a3 );
    b4 = qnfsum  ( D, b4, a4 );
    b4 = qnfsum  ( D, b4, a4 );

    b6 = qnfsquare( D, a3 );
    hi = qnfsum   ( D, a6, a6 );
    hi = qnfsum   ( D, hi, hi );
    b6 = qnfsum   ( D, b6, hi );

    b8 = qnfprod  ( D, a1, a6 );
    hi = qnfprod  ( D, a3, a4 );
    b8 = qnfdif   ( D, b8, hi );
    b8 = qnfprod  ( D, b8, a1 );	/** a1^2a6 - a1a3a4 **/
    hi = qnfsum   ( D, a6, a6 );
    hi = qnfsum   ( D, hi, hi );
    b2 = qnfsquare( D, a3 );
    hi = qnfsum   ( D, hi, b2 );
    hi = qnfprod  ( D, hi, a2 );	/** 4a2a6 + a2a3^2 **/
    b8 = qnfsum   ( D, b8, hi );
    hi = qnfsquare( D, a4 );
    b8 = qnfdif   ( D, b8, hi );

    b2 = qnfsquare( D, a1 );
    hi = qnfsum   ( D, a2, a2 );
    hi = qnfsum   ( D, hi, hi );
    b2 = qnfsum   ( D, b2, hi );

    return( list4( b2, b4, b6, b8 ) );
}
