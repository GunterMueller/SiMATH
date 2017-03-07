/*M
.SH NAME
flsqrt - floating point square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsqrt(f)
floating f;

.SH DESCRIPTION
flsqrt() returns the (positive) square root of f
for f >= 0.
M*/
/*H
	Version 1	15.04.91	Marc Conrad
   DATE flsqrt        : 910715
H*/

#include<_arith1.h>
floating flsqrt( f )
floating f;         
{
if (!f) return(0);
else {     
	single l,u, ex;
              
	bind( f );       

	ex = flexpo( f );
	f  = lred( f ); 
	l  = llength( f );     
                                             
	/* Aufblasen von f */
	u = 2 * ( FL_EPS + 1 ) ;
	while (l < u)  f = lcomp( 0, f ), ex--, l++;     

	if ( ex%2 ) ex--, f = lcomp( 0, f ); 
	else if ( lred(f) == _0 ) f = lfirst( f ); 

 	f = isqrt( f );      
	if ( issingle( f ) ) l = 1;
	else l = llength( f );        

	f = flcons( f, ex / 2, l);   
	return( f );   
	}
}
