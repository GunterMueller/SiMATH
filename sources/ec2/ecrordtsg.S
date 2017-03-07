/*M
.SH NAME
ecrordtsg - elliptic curve over the rational numbers, order of Tate-Shafarevic group

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrordtsg(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.    
.PP
ecrordtsg returns the order of the Tate-Shafarevic group or -1 in case of an error occurs.
.PP
ecrordtsg uses the global double variable _H_BOUND (default _H_BOUND = 0.0).
For _H_BOUND = 0, ecrordtsg searches for points with unbounded Weil height, for
_H_BOUND = h > 0, ecrordtsg searches for points with Weil height smaller than h.
 
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	06.04.1992	Josef Gebel
	Version 2	18.10.1993	Warnung des Apollo-Compilers 
					beseitigt.  PS
	Version 3	21.11.1994	In der Dokumentation auf die globale
					Variable _H_BOUND verwiesen. MP
   DATE ecrordtsg     : 930531.931130.941201
H*/

#include <_ec2.h>

ecrordtsg( E )
list E;
{
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lfifth( lfourth( lfourth( E ) ) ) == 0 ) )
    {
	/*   Ordnung der Tate-Shafarevic-Gruppe   */
	/*   noch nicht berechnet.                */
        bind( E );
        ecrmaninalg( E );
    }
    return( lfifth( lfourth( lfourth( E ) ) ) );
}
