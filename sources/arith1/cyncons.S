/*M
.SH NAME
cyncons - cyclotomic number construction

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyncons(n,a)
single a,n;

.SH DESCRIPTION
cyncons() returns the cyclotomic number 1 - z_n^a where 
z is a primitive n-th root of unity. 

.PP
.TP 4   
.B n is a positive single greater 1. 
.TP 4
.B a is a single such that n divides not a.  

.SH NOTE
if gcd(a,n) > 1 cyncons(n,a) constructs the number 
1 - z_t^b where t = n/gcd(n,a) and b = a/gcd(n,a).

M*/
/*H    
	Version 1       28.12.1999        Marc Conrad
H*/

#include <_arith1.h>       

cyc cyncons(n,a)  
single n, a; 
{ 
    single d; 
    list L; 
    init(L);
    d = sgcd(n,sabs(a)); 
    n = n / d; 
    a = mshom(n,a/d);
    L = list2(n,a); 
    L = list2(L,1); 
    return( L ); 
    } 
     
     

		
