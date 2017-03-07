/*M
.SH NAME
flsin_sp - floating point sinus special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flsin_sp(f)
floating f;

.SH DESCRIPTION
flsin_sp() returns sin(f).

.SH CAUTION
flsin_sp() uses expansion into a series and therefore the algorithm is very slow for large values of f.
M*/
/*H
	Version 1	29.02.1992	Marc Conrad
   DATE flsin_sp      : 920331
H*/


#include<_arith1.h>

floating flsin_sp( f )
floating f; 
{       
    if( !f ) return( 0 );    
    else {  
	floating sum, sum0, smd, g; 
	single i, n, m, vz;    
	/* z ist flag */

	bind( f );
	init( sum, smd, sum0, g );         
	                               
 
/* Reihenentwicklung: */     
	g = flprod( f, f );
	sum0 = 0;
	sum = f;
	smd = sum;
	i = 2;             
	while( !oequal(sum, sum0 ) ) {	      
		n = - ( i * ( i + 1 ) );    
		i += 2;
		smd = flsquot( flprod( g, smd ), n);
		sum0 = sum;
		sum = flsum( sum, smd );	 
		}  
	       
	return( sum );  
	}      
}  
/*                   
main()
{ 
floating f, g;     
FL_EPS = 20;
f = getfl();
	
g = flsin_sp( f );
printf(" g = %40p\n", g);
} 
*/

