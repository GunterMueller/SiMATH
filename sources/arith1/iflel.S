/*M
.SH NAME
iflel - integer factor list and exponent list

.SH SYNOPSIS
.nf
#include<_arith1.h>

list iflel(n)
int L;

.SH DESCRIPTION
iflel() returns a list of two lists 
L = ( (p1, ..., pk), (e1, ..., ek) ) 
for an positive integer n such that the pi are prime factors of n with 
exponents ei. 

.SH WARNING
iflel uses ifact in order to compute the factorization of n, but 
the last list of factors which has been computed is cached. 
Don't confuse iflel with ifel. 


.SH SEE ALSO
sfel, ifel, ifact, isiprime
M*/
/*H
	Version 1       29.12.1999      Marc Conrad
H*/
#include<_arith1.h>

static list save_L = 0;
static int  save_n = 0;

list iflel (n)
int n;
 {
 list F, E, P; 
 init(F, E, P); 
 bind(n); 

 if( n == save_n ) { return save_L; } 

 globbind(&save_L);
 globbind(&save_n);
 save_L = _0; 
 save_n = n; 

 F = ifel(ifact(n)); 
 E = _0; 
 P = _0; 

 while ( F != _0 ) { 
     P = lcomp( lfirst(F), P); 
     F = lred(F); 
     E = lcomp( lfirst(F), E); 
     F = lred(F); 
     } 
 save_L = list2(P,E);
 return (save_L); 
 }
