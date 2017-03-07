/*M
.SH NAME
ecimindiv - elliptic curve with integer coefficients, minimal model, division of a point by an integer
 
.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimindiv(E, PL, h, n) 
list E, PL;  
floating h; 
single n;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.TP 4
.B PL
is a list of three integers, defining a point, say P, on the minimal model of the elliptiv curve E/Q.
.TP 4
.B h
is the Neron-Tate height of P.
.TP 4
.B n
is a natural number, 0 < n < BASIS.
.PP
ecimindiv returns a list, say RL, where
.PP
 RL = (x y z) defines a point R on the curve E/Q with 
      P = n * R, or
 RL = (0) if no such point R exists.

.SH SEE ALSO
 ecrinit

M*/
          
/*H
	Version 1	21.01.1993 	Josef Gebel
   DATE ecimindiv     : 930531
H*/

#include <_ec2.h>

list ecimindiv( E, P, n )
list E, P;
single n;
{
    floating f, h;
    list PL;

    bind( E, P );
    init( f, h );
    init( PL );

    PL = _0;
    f  = 0;
    h  = eciminnetahe( E, P );

    return( ecimindivs( E, P, h, &f, 0, &PL, n ) );
}
