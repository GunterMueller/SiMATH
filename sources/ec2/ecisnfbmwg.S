/*M
.SH NAME
ecisnfbmwg - elliptic curve with integer coefficients, short normal form, basis of the Mordell-Weil group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecisnfbmwg(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.  
.PP
ecisnfbmwg computes a basis, say B, of the Mordell-Weil-group of the model in short normal form of the elliptic curve E/Q (s.ecrinit).
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
ecisnfbmwg uses the global double variable _H_BOUND (default _H_BOUND = 0.0).
For _H_BOUND = 0, ecisnfbmwg searches for points with unbounded Weil height, for
_H_BOUND = h > 0, ecisnfbmwg searches for points with Weil height smaller than h.
.PP                                                                    
ecrisnfbmwg returns the list B by success and -1 else.

.SH SEE ALSO
ecrinit                 
  
M*/
 
/*H
			
	Version 1	06.04.1992	Josef Gebel
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
        Version 3       11.07.1994      Abfrage 'llength(L) == 1' eingebaut.
                                        JG
	Version 4	21.11.1994	In der Dokumentation auf die globale
					Variable _H_BOUND verwiesen. MP
	Version 5	21.11.1994	ECISNFMWGBASE -> ECISNFBMWG. MP
					ECIMINMWGBASE -> ECIMINBMWG. MP
   DATE ecisnfbmwg : 930531.931130.941201
H*/

#include <_ec2.h>

list ecisnfbmwg( E )
list E;
{
    if( ( lthird( E ) == _0 )
    ||  ( lsixth( lred( lthird( E ) ) ) == _0 ) )
    {
	/*   Basis noch nicht berechnet   */
	list L, B;
   
        bind( E );
	init( L, B );

	L = eciminbmwg( E );
        if( llength( L ) == 1 )
        {
            B = _0;
        }
        else
        {
	    list T;
   
	    init( T );

	    T = eciminbtsnf( E );
	    B = ecrbtlistp( L, T, 1 );
        }
  
	L = lthird( E );
	leset( L, 7, B );
	leset( E, 3, L );

	return( B );
    }

    return( lsixth( lred( lthird( E ) ) ) );
}
