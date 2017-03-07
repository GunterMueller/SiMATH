/*M
.SH NAME
flcos_sp - floating point cosine special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flcos_sp(f)
floating f;

.SH DESCRIPTION
flcos_sp() returns cos (f).

.SH CAUTION
flcos_sp() uses expansion into a series and therefore the algorithm is very slow for large values of f.
M*/
/*H
	Version 1	25.02.1992	Marc Conrad
   DATE flcos_sp      : 920331
H*/


#include<_arith1.h>

floating flcos_sp( f )
floating f; 
{       
    if( !f ) return( itofl(1) );    
    else {  
	floating sum, sum0, smd, g; 
	single i, n, m, vz;    
	/* z ist flag */

	bind( f );
	init( sum, smd, sum0, g );         
	                               
 
/* Reihenentwicklung: */     
	f = flprod( f, f );
	sum0 = 0;
	sum = flsquot( f, -2 );
	smd = sum;
	i = 3;             
	while( !oequal(sum, sum0 ) ) {	      
		n = - ( i * ( i + 1 ) );    
		i += 2;
		smd = flsquot( flprod( f, smd ), n);
		sum0 = sum;
		sum = flsum( sum, smd );	 
		}  
	       
	smd = flsum( itofl( 1 ), sum );
	return( smd );  
	}      
}                     

