/*M
.SH NAME
ecracbmwg - elliptic curve over the rational numbers, basis of the Mordell-Weil-group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecracbmwg(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.                         
.PP
ecracbmwg computes a basis, say B, of the Mordell-Weil-group of the actual model of the elliptic curve E/Q (s.ecrinit).
.PP
Let r be the rank of E/Q, then B is a list in the shape
.IP
B = ( P1 h1 P2 h2 ... Pr hr ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a basispoint,
.IP
hi
is the Neron-Tate height of Pi.
.PP
ecracbmwg uses the global double variable _H_BOUND (default _H_BOUND = 0.0).
For _H_BOUND = 0, ecracbmwg searches for points with unbounded Weil height, for _H_BOUND = h > 0, ecracbmwg searches for points with Weil height smaller than h.
.PP
ecracbmwg returns the list B by success and -1 else.
  
.SH SEE ALSO
ecrinit

M*/
                                                  
/*H
	Version 1	06.04.1992	Josef Gebel
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
	Version 3	11.07.1994	Abfrage 'llength(L) == 1' eingebaut.
                                        JG
					In der Dokumentation auf die globale
					Variable _H_BOUND verwiesen. MP
	Version 4	21.11.1994	ECRACMWGBASE -> ECRACBMWG. MP
					ECIMINMWGBASE -> ECIMINBMWG MP
   DATE ecracbmwg  : 930531.931130.941201
H*/

#include <_ec2.h>

list ecracbmwg( E )
list E;
{
	bind( E );
    if( lsixth( lred( lfirst( E ) ) ) == _0 )
    {
	/*   Basis noch nicht berechnet   */
	list L, B;
   
        /**bind( E ); **/
	init( L, B );

	L = eciminbmwg( E );
        if( llength( L ) == 1 )
        {
            return( L );
        }
        else
        {
	    list T;
   
	    init( T );

	    T = eciminbtac( E );
	    B = ecrbtlistp( L, T, 1 );
        }
  
	L = lfirst( E );
	leset( L, 7, B );
	leset( E, 1, L );

	return( B );
    }

    return( lsixth( lred( lfirst( E ) ) ) );
}
