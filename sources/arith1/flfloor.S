/*M
.SH NAME
flfloor - floating point floor

.SH SYNOPSIS
.nf
#include<_arith1.h>

int flfloor(f)
floating f;

.SH DESCRIPTION
flfloor() returns the biggest integer less or equal to f.
M*/
/*H
	Version  1      19.03.91      Marc Conrad
   DATE flfloor       : 910715
H*/


#include<_arith1.h>
floating flfloor(f)
floating f;
{
    if (!f) return (0); 
    else {     
	single exp;
	
	bind(f);            

	exp  = flexpo(f);
	f = lred(f); 
                                    
	if (exp > 0) do 
		f = lcomp(0,f), exp--;
		while( exp );
	else if (exp < 0 ) {       
		single sgn;
		sgn = ssign(lfirst(f));         

		do f = lred(f), exp++;
		while( exp && f != _0 );  

		if (f == _0) f = 0;
		else if (lred(f) == _0) f = lfirst(f);      
		if (sgn < 0 ) f = idif(f, 1);     
		}
	else if (lred(f) == _0 ) f = lfirst(f);      
	/* else f = f; */
	return(f);   
	}
}    	
	
		
