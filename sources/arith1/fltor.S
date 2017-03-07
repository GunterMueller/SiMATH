/*M
.SH NAME
fltor - floating point to rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat fltor(f)
floating f;

.SH DESCRIPTION
fltor() returns f in ration representation. The denominator will
always be a power of 2.
M*/
/*H    
	Version 1       01.04.91        Marc Conrad
   DATE fltor         : 910715
H*/

#include<_arith1.h>   
  
rat fltor(f)
floating f;      
{         
    if (!f) return (0);
    else {
	int N;
	single exp;  

	bind ( f );    
	init ( N );
   
	exp = flexpo(f);   
	if (!exp) N = list2(flmant(f),1); 
	else if (exp > 0 ) {   
		N = lred(f);
		while (exp) N = lcomp(0,N), exp--;
		N = list2(N,1);
		}
	else {               
		N = list1(1);
		while (exp) N = lcomp(0,N), exp++;    
		N = rcons(flmant(f),N);
		}
	return(N);    
	}
}
