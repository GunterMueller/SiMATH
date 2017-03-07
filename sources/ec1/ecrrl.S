/*M
.SH NAME
ecrrl - elliptic curve over rational numbers reduction list

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrrl(E1)  
list E1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
Let p1, ..., pk ( p1 <= p2 <= ...<= pk ) the set of prime numbers E/Q has a bad reduction at. 
.PP
ecrrl returns a list 
.IP
L = ( p1 n1 p2 n2 ...pk nk ) of integers,
.PP
where  ( for i = 1, ..., k )
.TP 4
ni 
=  1, if E has additive reduction at pi, or
.TP 4
ni 
= -1, if E has multiplicativ reduction at pi.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       16.06.1991      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3 	02.04.1992	neue Programmnamen eci... 
					beruecksichtigt.  MP
	Version 4       17.05.1993      Anpassung an neues Konzept. JG
   DATE ecrrl         : 910715.910915.920331.930531
H*/

#include <_ec1.h>

list  ecrrl( E )
list E;
{
    list L, F;
    int c4, p;
    single e;
	
    bind( E );

    init( L, F );

    F  = eciminfdisc( E );
    c4 = eciminc4( E );
    L  = _0;

    while( F != _0 )
    {
	p = lfirst( F );

	if( mihom( p, c4 ) )
	{
	    /*   p teilt c4 nicht: Multiplikative Reduktion mod p   */
	    e = -1;
	}
	else
	{
	    /*   p teilt c4: Additive Reduktion mod p   */
	    e = 1;
	}
	L = lcomp2( e, p, L );
	F = lred2( F );
    }

    return( linv( L ) );
}
