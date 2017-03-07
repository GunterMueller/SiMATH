/*M
.SH NAME
eciminplu - elliptic curve with integer coefficients, minimal model, point list union

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eciminplu(E, L1, L2, modus)  
list E, L1, L2; 
single modus;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.  
.TP 4
.B L1, L2
are two lists of points (s. eciminplinsp).
.PP
eciminplu returns the union, say L, of the lists L1 and L2. L is sorted with increasing Neron-Tate heights.
.PP
 If modus = 0, then L = L1 U L2.
 If modus != 0, then L contains only these points of L1 or 
 L2, which have Neron-Tate height unequal to 0 or to Neron
 -Tate height of all other points of L1 and L2.   

.SH SEE ALSO
 ecrinit
 eciminplinsp

M*/
                   
/*H
	Version 1       11.01.1993      Josef Gebel
	Version 2       05.07.1993      Parameter 'modus' eingefuehrt.  JG
	Version 3       23.10.1995      ECIMINPLUNION --> ECIMONPLU  JG
   DATE eciminplu : 930531.931130.951201
H*/

#include <_ec2.h>

list eciminplu( E, L1, L2, m )
list E, L1, L2;
single m;
{
    list P, HL, PL;
    floating h;

    bind( E, L1, L2 );

    init( P, HL, PL );
    init( h );
    
    PL = lcopy( L1 );
    HL = L2;

    while( HL != _0 )
    {
	P  = lfirst ( HL );
	h  = lsecond( HL );
	if( (  m &&  ( isineciminpl( E, P, h, PL ) == 0 ) )
	||  ( !m &&  ( isineciminpl( E, P, h, PL ) != 1 ) ) )
	{
            eciminplinsp( P, h, &PL );
        }
	HL = lred2( HL );
    }
    return( PL );
}
