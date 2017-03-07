/*M
.SH NAME
fltoCfl - floating point to C-floating point

.SH SYNOPSIS
.nf
#include<_arith1.h>

double fltoCfl(f)
floating f;

.SH DESCRIPTION
For -2^1000 < f < +2^1000 fltoCfl() returns f as a C-floating point number.

.SH CAUTION
A program using this function must declare it as "double fltoCfl();"
M*/
/*H    
	Version 1       19.08.91        Marc Conrad
	Version 2       03.06.96        Das 'Achtung:' der Doku rein.
					 Marc Conrad
   DATE fltoCfl       : 910915.9612__
H*/

#include<_arith1.h>
double fltoCfl( f ) 
floating f;
{  
          
double u, v, w;
if ( !f ) u = 0.0;    
else {
	single a, e, retteeps; 

	bind ( f );         

/* f abschneiden */
	retteeps = FL_EPS;
	FL_EPS = 3;
	f = fltofl( f );  
	FL_EPS = retteeps;

	e = lfirst( f );
	f = lred( f );   
	  
	a = lfirst( f );
	f = lred( f );        

        w = 1073741824.0;     
	if ( e >= 0 ) {      
	        v = pow( w, (double) e );  
	        u = v * ( (double) a );
		while ( f != _0 ) {
			a = lfirst( f );
			f = lred( f ); 
			v = v * w;   
			u = u + ( v * ( (double) a ) );
			}                   
	 	}
	 else {     
	        u = ( (double) a );
		while ( f != _0 ) {
			a = lfirst( f );
			f = lred( f ); 
			u = u / w; 
			u = u + ( (double) a );
			e++; 
			}           
		if ( e < 0 ) {
			u = u / w;
			e++;
			}
	        u = u * pow( w, ( double) e ); 
		}

	}
return ( u );
}
	
