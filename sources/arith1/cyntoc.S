/*M
.SH NAME
cyntoc - cyclotomic number to complex number 

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cyntoc( A )
cyc A;

.SH DESCRIPTION
cyntoc() returns the complex value of the cyclotomic number A.
M*/
/*H    
	Version 1       29.12.1999      Marc Conrad
H*/
#include <_arith1.h>

static complex cyncelttoc(C)  
list C; 
{ 
     complex z, e; 
     bind( C ); 
     init(z, e);
     
     z = itoc(lsecond(C)); 
     z = cexpsv(z, lfirst(C)); 
     e = itoc(1);
     return cdif(e,z); 
     } 

complex cyntoc(A)
cyc A; 
{
    list C; 
    single e;  
    complex p, z, u, eins; 
    bind(A);
    init(C, p, z, u, eins);

    p = itoc(1); 
    while(A != _0 ) { 
        C = lfirst(A); A = lred(A);
        e = lfirst(A); A = lred(A);
        u = cyncelttoc(C);
        if( e > 0 ) { 
             u = csexp(u,e);
             }
        else { 
             u = cquot(itoc(1),u);
             u = csexp(u,-e);
             } 
        p = cprod(p,u);
    } 
   return p; 
}
   



 
