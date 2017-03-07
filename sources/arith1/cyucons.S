/*M
.SH NAME
cyucons - cyclotomic unit construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyucons(n,a)
single a,n;

.SH DESCRIPTION
cyucons() returns the cyclotomic unit (1 - z_n^a)/(1 - z_k) where 
z is a primitive n-th root of unity and k = n/gcd(n,a) if n
is the power of a prime and 1 - z_n^a otherwise. 

.PP
.TP 4   
.B n is a positive single greater 1. 
.TP 4
.B a is a single such that n divides not a.  

.SH SEE ALSO 
cyncons  
M*/
/*H    
	Version 1       02.01.00        Marc Conrad
H*/

#include <_arith1.h>       

cyc cyucons(n,a)  
single n, a; 
{ 
    return( cyncons(n,a) ); 
    } 
     
     

		
