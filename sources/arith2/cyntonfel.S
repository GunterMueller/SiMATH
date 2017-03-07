/*M
.SH NAME
cyntonfel - cyclotomic number to number field element 

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel cyntonfel( n, F, A )
single n; 
pol F; 
cyc A;

.SH DESCRIPTION
.TP 4
.B n
is an integer > 2
.TP 4
.B A 
is a cyclotomic number 
.TP 4
F 
is the n-th cyclotomic polynomial. If F==0 F will be computed by n.
.PP
cyntonfel() returns the value of the cyclotomic number A in the n-th 
cyclotomic number field.
.SH SEE ALSO 
cyutonfel, cyntoc
M*/
/*H    
	Version 1       19.10.2000      Marc Conrad
H*/
#include <_arith2.h>

nfel cyntonfel(n, F, A)
single n; 
cyc A; 
pol F; 
{
    list C; 
    single e, d, a;  
    nfel p, u, x, eins; 
    bind(A, F);
    init(d, a, C, p, u, x, eins);
    if( !F ) { F = udpicycgen(n); } 
    x = list3(1,1,1); 
    p = eins = itonf(1); 
    while(A != _0 ) { 
        C = lfirst(A); A = lred(A);
        e = lfirst(A); A = lred(A);
	d = lfirst(C); 
	a = lsecond(C); 
        if( d == 4 && a == 1 && n % 4 == 2 && e % 2 == 0 ) { 
                           /* Workaround for the case n = 2 mod 4, 
                           because application of cynbaserep can result to 
                           a cyclotomic number ((4,1),2k) */
            u = nfsum(F,eins,eins); e /= 2;  }
        else { 
	    u = nfexp(F, x, (n/d)*a); /* generiere epsilon_d^a */
	    u = nfdif(F, eins, u); 
            } 
	u = nfexp(F, u, e); 
        
        p = nfprod(F, p,u);
    } 
   return p; 
}




 
