/*M
.SH NAME
cagm - complex aritho-geometric mean

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cagm(a , b) 
complex a, b;

.SH DESCRIPTION
cagm() calculates the aritho-geometric mean of the complex numbers a and b (exact to 15 decimal places).
Let a(n) and b(n) two sequences, n element of N, according to
.nf
     a(0) = a
     b(0) = b

     a(n+1) = [ a(n) + b(n) ] / 2
     b(n+1) = sqrt( a(n) * b(n))

then

     cagm(a,b) = lim a(n) = lim b(n)
                 n->oo      n->oo
.PP
.TP 4
.B a,b
are complex numbers.

M*/

/*H
	Version 1	18.06.1993	Josef Gebel   
   DATE cagm          : 931130
H*/

#include <_arith1.h>

complex cagm( a , b )
    complex a, b;
{
    complex aa , bb , help, halb;
    floating agm_tol;
    bind(a,b); 
    init( aa , bb , help, halb, agm_tol );

    halb = ccri( rtofl( list2( 1, 2 ) ), 0 );

    aa = a;
    bb = b;
    agm_tol = Cfltofl( 0.000000000000001 );
    
    do
    {
       help = cprod( aa , bb );
       aa = csum( aa , bb );
       aa = cprod( aa , halb );
       bb = csqrt( help );        
       help = cdif( aa , bb );
    }
    while( flcomp( cabsv( help ), agm_tol ) > 0 );

    return( aa );
}
