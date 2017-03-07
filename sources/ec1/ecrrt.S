/*M
.SH NAME
ecrrt - elliptic curve over rational numbers reduction type

.SH SYNOPSIS
.nf
#include<_ec1.h>

single ecrrt(E1, p)  
list E1; int p;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B p
is a prime number.
.PP
ecrrt returns :
.TP 4
 0,
if E has good reduction with regard to p,
.TP 4
 1,
if E has additive reduction with regard to p,
.TP 4
-1, 
if E has multiplicativ reduction with regard to p.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       15.06.1991      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3 	02.04.1992	neue Programmnamen eci... 
					beruecksichtigt.  MP
	Version 4       17.05.1993      Anpassung an neues Konzept. JG
   DATE ecrrt         : 910715.910915.920331.9301__.930531
H*/

#include <_ec1.h>

single          ecrrt( E, p )
list 		E;
int             p;
{
    int h;

    init( h );

    bind( E, p );

    h = ecimindisc( E );

    if( mihom( p, h ) )
    {
        /*   p teilt die Diskriminante nicht ==> gute Red. mod p   */
	return( 0 );
    }
    /*   else: p teilt die Diskriminante ==> schlechte Red. mod p   */

    h = eciminc4( E );

    if( mihom( p, h ) )
    {
	/*   p teilt c4 nicht ==> multiplikative Red. mod p   */
	return( -1 );
    }
    
    /*   else: p teilt c4 ==> additive Reduktion mod p   */
    return( 1 );
}
