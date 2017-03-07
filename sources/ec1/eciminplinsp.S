/*M
.SH NAME
eciminplinsp - elliptic curve with integer coefficients, minimal model, point list, insert point

.SH SYNOPSIS
.nf
#include<_ec1.h>

eciminplinsp(P, h, PL)  
list P, *PL; 
floating h;

.SH DESCRIPTION
.B P
= ( x y z )   int x, y, z;
.PP
.B PL
points at a list
.IP
 ( P1 h1 P2 h2 ... Pn hn ) 
 list Pi = ( xi yi zi )   int xi, yi, zi;
 floating hi;                           ,where
.IP
 h1 <= h2 <= ...  <= hn.
.PP
eciminplinsp inserts the pair ( P h ) to the list *PL, such that
.IP
h1 <= h2 <= ... <= hi <= h <= h(i+1) <= ... <= hn. 
.PP
By success, eciminplinsp returns 0.

M*/

/*H
	Version 1 	01.04.1993	Josef Gebel 
	Version 2 	10.07.1993	Abfrage "*PL==_0" eingebaut.  JG
   DATE eciminplinsp  : 930531.931130
H*/

#include <_ec1.h>

eciminplinsp( P, h, PL )
list P, *PL;
floating h;
{
    bind( h, P, *PL );

    if( *PL == _0 )
    {
	*PL = lcomp2( P, h, *PL );
    }
    else
    {
        single n;
        list L, L1;
        floating hf;

        init( L, L1 );
        init( hf );
    
        L1 = *PL;
	n  = 0;

        while( L1 != _0 )
        {
	    hf = lsecond( L1 );
	    if( flcomp( hf, h ) > 0 )
	    { 
	        /*   mit i = n / 2:          ... hi  Pi ...     */
	        break;
	    }
	    n += 2;
	
	    L1 = lred2( L1 );
        }
   
        L1 = lcopy( *PL );

        L   = leins( L1, n, h );  /*   ... hi  h  Pi ...     */
        *PL = leins( L , n, P );  /*   ... hi  P  h  Pi ...  */
        
    }
    return( 0 );
}
                                    
