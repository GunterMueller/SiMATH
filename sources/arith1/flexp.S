/*M
.SH NAME
flexp - floating point exponential function

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flexp(f)
floating f;

.SH DESCRIPTION
flexp() returns e^f, where e is the Euler number.
M*/
/*H
	Version 1	30.04.91	Marc Conrad
   DATE flexp         : 910715.9305__
H*/

#include<_arith1.h>

floating flexp( f )
floating f; 
{       
    if( !f ) return( itofl(1) );    
    else {  
	FILE *fp;
	floating sum, sum0, smd, g; 
	single e, c, d, z, i, epsbak;    
	/* z ist flag */

	bind( f );
	init( sum, smd, sum0, g );         
	                               
	if( flsign( f ) < 0 ) {
		z = 1;
		g = flneg( f );
		}
	else g=f, z = 0;            
	epsbak = FL_EPS;                   
		/* Die "22" ist heuristisch */
	if (flcomp( g, list2( -1, 1<<22 ) ) < 0 ) e=0;
	else {           
		e = flexpo(g);                  
		/* Faustregel: "8" + "22" immer = 30 (!!!) */
		d = ilog2(flmant(g) ) + 8;
		c = d/30 + e;       
		d = d%30;     
		e = 30 * c + d;   
		if ( c > 1 ) {   
		  /* fataler Over od. Underflow */
		  if ( z ) return( 0 );     
		  else floverflow( 6 );
		  }
		if ( e > 20 ) FL_EPS++;  
		if ( c >= 0 ) g = flquot( g ,list2( c, (1<<d)) ); 
		else e=0;
		}         

/* Reihenentwicklung: */
	sum0 = 0;
	sum = g;
	smd = sum;
	i = 2;         
	while( !oequal(sum, sum0 ) ) {	
		smd = flsquot( flprod( g, smd ), i);
		i++;
		sum0 = sum;
		sum = flsum( sum, smd );	 
		}  
	       
	if ( e ) FL_EPS++;       
	smd = flsum( sum, list2( 0, 1 ));      

	if ( z )  smd = flquot(list2( 0, 1),smd);  

/* Es wird berechnet: smd^( 2^( 30 c + d) )   */   
	if( e ) {                                  
		
		for( d=1; d < e; d++ ) { 
			if( d == 30 ) FL_EPS--;
			smd = flprod(smd, smd);    
			}                               
		FL_EPS = epsbak;
		smd = flprod(smd, smd );
		}              
	return( smd );  
	}      
}           
