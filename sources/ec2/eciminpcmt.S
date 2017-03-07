/*M
.SH NAME
eciminpcmt - elliptic curve with integer coefficients, minimal model, point comparison modulo torsion

.SH SYNOPSIS
.nf
#include<_ec2.h>

single eciminpcmt(E, PL1, PL2)  
list E, PL1, PL2;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
. B PL1
= (x1 y1 z1), is a list of three integers, defining a normalized point, say P1, on the minimal model of E/Q (s.ecrpnorm).
.TP 4
. B PL2
= (x2 y2 z2), is a list of three integers, defining a normalized point, say P2, on the minimal model of E/Q. 
.PP
eciminpcmt returns 
.PP
  1, for P1 = P2 , i.e. x1 = x2, y1 = y2, z1 = z2,
 -1, for P1 = -P2, i.e. x1 = x2, y1 != y2, z1 = z2,
  2, for P1 = +/-P2 + T ( T torsion point of E, T != 0), 
     i.e. P1 != +/-P2 and h(P1) = h(P2) 
     (h(Pi) = Neron-Tate height of Pi),
  0, else.

.SH SEE ALSO
 ecrinit
 ecrpnorm

M*/
 
/*H
	Version 1	12.01.1993	Josef Gebel
	Version 2	17.10.1995	ECIMINPCOMPMT --> ECIMINPCMT JG
   DATE eciminpcmt : 930531.951201
H*/

#include<_ec2.h>
	    
single eciminpcmt( E, P1, P2 )
list E, P1, P2;
{
    single h;
    
    bind( E, P1, P2 );
   
    h = ecrpcomp( P1, P2 );

    if( !h )
    {
	/*    P1 != P2   */
        list T;

        init( T );
        
        T = eciminsum( E, P1, P2 );
    
        if( isecimintorp( E, T ) )
        {
	    /*   T Torsionspunkt: P1 = -P2 + T  */
	    return( 2 );
        }
    	
        T = ecimindif( E, P1, P2 );
        if( isecimintorp( E, T ) )
        {
	    /*   T Torsionspunkt: P1 = P2 + T  */
	    return( 2 );
        }
    }
    return( h );
}
