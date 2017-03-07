/*M
.SH NAME
eciminbmwg - elliptic curve with integer coefficients, minimal model, basis of the Mordell-Weil-group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eciminbmwg(E)  
list E;
   
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
eciminbmwg computes a basis, say B, of the Mordell-Weil-group of the minimal model of the elliptic curve E/Q (s.ecrinit).
.PP
Let r be the rank of E/Q, then B is a list in the shape
.IP                                        
.IP
B = ( P1 h1 P2 h2 ... Pr hr ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a basispoint,
.IP
hi
is the Neron-Tate height of Pi.
.PP                                                                  
eciminbmwg uses the global double variable _H_BOUND (default _H_BOUND = 0.0). 
For _H_BOUND = 0, eciminbmwg searches for points with unbounded Weil height, for
_H_BOUND = h > 0, eciminbmwg searches for points with Weil height smaller than h.
.PP
eciminbmwg returns the list B by success and list (0) else.

.SH SEE ALSO
ecrinit

M*/
        
/*H
	Version 1	06.04.1992	Josef Gebel
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
	Version 3	28.10.1994      Abfrage auf ERROR eingebaut. JG.
	Version 4	21.11.1994	In der Dokumentation auf die globale
					Variable _H_BOUND verwiesen. MP
	Version 5	21.11.1994	ECIMINMWGBASE -> ECIMINBMWG. MP
   DATE eciminbmwg : 930531.931130.941201
H*/

#include <_ec2.h>

list eciminbmwg( E )
list E;
{
    bind( E );
 
    if( lsixth( lred( lsecond( E ) ) ) == _0 )
    {
	/*   Basis noch nicht berechnet   */
   
        if( ecrmaninalg( E ) == ERROR )
        {
            return( list1( 0 ) );
        }
    }

    return( lsixth( lred( lsecond( E ) ) ) );
}
