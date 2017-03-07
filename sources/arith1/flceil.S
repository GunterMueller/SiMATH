/*M
.SH NAME
flceil - floating point ceil

.SH SYNOPSIS
.nf
#include<_arith1.h>

int flceil(f)
floating f;

.SH DESCRIPTION
flceil() returns the smallest integer greater or equal to f.

.SH SEE ALSO
flfloor, flround, itofl 
M*/
/*H
	Version  1      10.02.1999      Marc Conrad
H*/


#include<_arith1.h>
floating flceil(f)
floating f;
{
    if (!f) return (0); 
    else {     
	single exp;
	
	bind(f);            

	exp  = flexpo(f);
	f = lred(f); 
                                    
	if (exp > 0) { do { 
		f = lcomp(0,f), exp--; }
		while( exp ); }  
	else if (exp < 0 ) {       
		single sgn;
		sgn = ssign(lfirst(f));         

		do { f = lred(f), exp++; } 
		while( exp && f != _0 );  

		if (f == _0) { f = 0; } 
		else if (lred(f) == _0) { f = lfirst(f);  } 
		if (sgn > 0 ) { f = isum(f, 1);  }     
		}
	else if (lred(f) == _0 ) { f = lfirst(f); }  
	/* else f = f; */
	return(f);   
	}
}    	
	
		
