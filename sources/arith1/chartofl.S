/*M
.SH NAME
chartofl - character to floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating chartofl( a )
char a;

.SH DESCRIPTION
chartofl() returns a converted to a SIMATH floating point number,
where a either is a figure or 'e'. The relative rounding error is at most
| (  a - f ) / a | <  1/2 * (2^30)^( 1 - FL_EPS ).                                                          

M*/

/*H    
	Version 1       15.05.91        Marc Conrad
   DATE chartofl      : 910715
H*/

#include <_arith1.h>

floating chartofl( a ) 
char a;
{
	floating f;
	
	init( f );
	
	if ( a == 'e' ) f = flexp( list2( 0, 1 ) );
	else f = itofl( a - '0' );   
	
	return( f );
}
