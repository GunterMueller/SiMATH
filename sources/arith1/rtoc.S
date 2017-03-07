/*M
.SH NAME
rtoc - rational number to complex number

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex rtoc(r)
rat r;

.SH DESCRIPTION
rtoc() the value of the rational number r
as a complex number a + b*i with b = 0.
The relative error is at most:
.PP
| ( r - a ) / r | < 1/2 * (2^30)^( 1 - FL_EPS )
M*/

/*H    
	Version 1       22.12.93        S.Schmitt/U.Schneiders 
   DATE rtoc          : 941201
H*/

#include<_arith1.h>      
complex rtoc(r)
rat r;
{               
    if (!r) return (0);
    else {
	bind( r );  
	
	r = rtofl(r);
	if(!r) return(0);
	else return(list2(r,0));
    }
}
