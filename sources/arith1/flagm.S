/*M
.SH NAME
flagm - floating point aritho-geometric mean

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flagm(a,b)
floating a,b;


.SH DESCRIPTION
flagm() calculates the aritho-geometric mean of the two 
positive floating point numbers a and b (exact to 15 decimal places).
Let a(n) and b(n) two sequences, n element of N, according to
.PP
.nf
     a(0) = a
     b(0) = b

     a(n+1) = [ a(n) + b(n) ] / 2
     b(n+1) = sqrt( a(n) * b(n))

then

     flagm(a,b) = lim a(n) = lim b(n)
                  n->oo      n->oo
.PP
.TP 4
.B a,b
are floating point numbers.

.SH SEE ALSO
cagm
M*/

/*H
	Version 1	12.11.1992	Josef Gebel   
	Version 2  	16.04.1993	Fehler in Doku beseitig und 
					Funktion etw. beschleunigt. 
					Marc Conrad.
	Version 3	21.10.1994	Fehler beseitigt (in einigen Faellen
                                        war FLEPS zu klein, flinit eingefuegt).
                                        Josel Gebel.   
   DATE flagm         : 921130.930531.941201
H*/

#include <_arith1.h>

floating flagm( a , b )
    floating a, b;
{
    floating aa , bb , help, agm_tol;
    single   epsilon;

    init( aa , bb , help , agm_tol );

    epsilon = flinit( 20 );
    
    aa = a;
    bb = b;
    agm_tol = Cfltofl( 0.000000000000001 );

    do
    {
       help = flprod( aa , bb );
       aa = flsum( aa , bb );
       aa = flsquot( aa , 2 );
       bb = flsqrt( help );        
       help = fldif( aa , bb );
       help = flabs( help ); 
    }
    while( flcomp( help , agm_tol ) > 0 );

    flinit( epsilon );

    return( aa );
}
