/*M
.SH NAME
fllog - floating point natural logarithm (recursively)

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating fllog(f)
floating f;

.SH DESCRIPTION
For f >0 fllog() returns the natural logarithm of f.
M*/
/*H
	Version 1	26.04.91	Marc Conrad
	Version 2	11.10.96	FL_LN2 jetzt direkt hier erzeugt.
					Marc Conrad
   DATE fllog         : 910715.961201
H*/

#include<_arith1.h>   
fllog(f)
floating f;
{
	floating g, h;               
	single e, c, d;        

	bind( f );	
	init( g, h );	
        
	e = flexpo( f );
	
	d = ilog2(flmant(f));
	c = d/30 + e;
	d = d%30;
	
	g = list2( c, 1<<d );
	g = flquot( f ,g );                          

	/* Die Konstante unten entspricht 2^(-1/2) */
	
	if (flcomp( g, list2( -1, 759250125 ) ) < 0) {
		g = flprod(g, itofl(2) );   
		d--;
		}             
	/* Es gilt jetzt: 2^(-1/2) <= g <= 2^(1/2) */

	h = flsum( g, itofl(-1) );
	g = flsum( g, itofl( 1) );
	g = flquot(h,g);
	h = flath_sp( g );    

	h = flprod( h, itofl(2) );     
	g = isum( iprod( c, 30), d );
	
	if( !FL_LN2 ) { 
	FL_LN2 = list6(845621641,735067344,402911990,791121614,1025308570,744261117);
        FL_LN2 = lcomp( -6, FL_LN2 );
		} 
          
/* Erzeuge FL_LN2 oder schneide es ab */ 
	if ( FL_LN2 ) e = llength( FL_LN2 ) - 2;    
	else e = -1;    
             
	if ( g ) {
	  g = itofl( g );        
	  if ( e > FL_EPS ) {     
	    FL_EPS++;       
	    f = lred( FL_LN2 );	
	    f = flcons( f, flexpo(FL_LN2) , e ); 
	    FL_EPS--;  
	    g = flprod( g, f );    
	    }
 	  else if ( e <  FL_EPS ) {                  
	    FL_EPS += 2;
	    f = flsqrt(flsqrt(flsqrt(flsqrt(list2(0,2))))) ;      
	    f = fllog( f );     
	    FL_EPS--;
	    FL_LN2 = flprod( f, list2( 0, 16) );      
	    FL_EPS--;
	    g = flprod( FL_LN2, g );  
            }   
	  else g = flprod( FL_LN2, g);    
	  h = flsum( h, g );	        
	  }
	return(h);
	}                      
