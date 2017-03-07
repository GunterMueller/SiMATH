/*M
.SH NAME
ecimindivs - elliptic curve with integer coefficients, minimal model, division of a point by an integer, special version

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimindivs(E, RL, h, ug, PL, n)
list E, RL, *PL;  
floating h, *ug; 
single n;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B RL
= (x y z), is a list of three integers, defining a point, say R, on the minimal model of E/Q.
.TP 4
.B h
is the Neron Tate height of R.  
.TP 4
.B ug 
points on a floating, *ug >= 0.
.TP 4
.B PL
points on a list containing all points of E with Weil-height <= *ug, already found (s. ecisnfpbwh).
.TP 4
.B n
is an integer number, n != 0.
.PP
ecimindivs returns a list of three elements, defining a point, say Q, on the curve E with
.IP
R = n * Q,
.PP
or the list (0), if no such point Q exists.

.SH SEE ALSO
 ecrinit
 ecisnffpbwh 

M*/

/*H
	Version 1 	01.04.1993	Josef Gebel
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
	Version 3	17.10.1995	ECIMINPCOMPMT --> ECIMINPCMT JG
   DATE ecimindivs    : 930531.931130.951201
H*/

#include <_ec2.h>

list ecimindivs( E, P, h, ug, PL, n )
list E, P, *PL;
floating h, *ug;
single n;
{
    if( n == 0 )
    {
	return( ERROR );
    }

    if( ( ispecrpai( P ) == 0 ) || ( n == 1 ) )
    {
	return( P );
    }

    if( n == -1 )
    {
	return( eciminneg( P ) );
    }
    else
    {
        /*   Ab hier gilt: |n| > 1 und P != 0  */

        list      Q, R, S, TL, LP;
        floating  hf1, hf2, hf3;
        single l;

        bind( E, P, *PL );
        bind( h, *ug );
       
        init( Q, R, S, TL, LP );
        init( hf1, hf2, hf3 );
    
        hf1 = flquot( h, itofl( n * n ) );
        hf2 = ecimindwhnth( E );
        hf2 = flsum( hf1, hf2 );
    
        ecisnfpbwh( E, PL, ug, hf2, 0 );
        LP = *PL;
    
        while( LP != _0 )
        {
	    hf2 = lsecond( LP );
	    hf3 = fldif( hf2, hf1 );
    	
	    if( flcomp( flabs( hf3 ), NTH_TOL ) < 0 )
	    {
	        R  = lfirst( LP );
	        S  = eciminmul( E, R, n );
	        
	        if( ( l = eciminpcmt( E, P, S ) ) )
	        {
	            /*   R ist Kandidat fuer n * R = +/-P + T    */
		    /*    S = T + P oder S = T - P               */
		    /*              ==> T +/- P = n * (+/-) R    */
	    	
		    if( ( l == 1 ) || ( l == -1 ) )
		    {
		        return( R );
		    }
    
		    while( 1 )
		    {
		        if( TL == _0 )
		        {
			    break;
		        }
		        
		        R = eciminsum( lfirst( LP ), lfirst( TL ) );
		        
		        if( ( l == 1 ) || ( l == -1 ) )
		        {
		            if( l * n > 0 )
		            {
		                return( R );
		            }
		            else
		            {
		                return( eciminneg( R ) );
		            }
		        }
		        
		        TL = lred( TL );
                    }
		    return( list1( 0 ) );
	        }
	    }
	    if( flcomp( hf3, NTH_TOL ) > 0 )
	    {
	        /*   h / n^2 > h( R ), wenn R der aktuelle Punkt      */
	        /*   in der Liste LP ist. Da LP nach aufsteigenden    */
	        /*   Werten h( R ) geordnet ist, kann kein Punkt R    */
	        /*   mit 2 R = P mehr in der reslichen Liste sein.    */
	        return( list1( 0 ) );
	    }
	
	    LP = lred2( LP );
        }
    }
    
    return( list1( 0 ) );
}
