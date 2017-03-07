/*M
.SH NAME
flround  - floating point round

.SH SYNOPSIS
.nf
#include <_arith1.h>

int flround (f)
floating f;

.SH DESCRIPTION
flround() returns the integer with -1/2 <= f - A < 1/2.

.SH SEE ALSO
flfloor, itofl, rtofl, fltor
M*/

/*H
	Version  1      19.03.91      Marc Conrad
	Version  2	21.03.96      Fehler beseitigt 
					Marc Conrad.
   DATE flround       : 910715.960501
H*/

#include<_arith1.h>
floating flround(f)
floating f;
{
    if (!f) return (0); 
    else {     
	single exp;
	list g;  

	bind( f );
	init( g );            

	exp  = flexpo(f);
	f = lred(f); 
                                    
	if (exp > 0) do 
		f = lcomp(0,f), exp--;
		while( exp );
	else if (exp < 0 ) {       
		single sgn;
		sgn = ssign(lfirst(f));         

		do { 
			g = f; 
			if(f != _0 ) f = lred(f);
			exp++;
		} 
		while( exp && g != _0 );  
		
		if( g == _0 ) return 0; 

		if (f == _0) f = 0;
		else if (lred(f) == _0) f = lfirst(f); 

		exp = lfirst(g);    
		if ( sgn >= 0  && exp >= (1<<29) ) f = isum(f,1);
		else if (sgn < 0 && exp < -(1<<29)) f = idif(f, 1);     
		}
	else if (lred(f) == _0 ) f = lfirst(f);      
	/* else f = f; */
	return(f);   
	}
}    	
	
