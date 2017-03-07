/*M
.SH NAME
gfselrand - Galois-field with single characteristic, element randomize

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfselrand( p, AL )  
single p; 
list AL;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen). 
.PP
gfselrand returns a randomly generated element of GF(p^n).

.SH SEE ALSO
gfsalgen

M*/
          
/*H
	Version 1	21.10.1992	Joachim Stein
   DATE gfselrand     : 921130
H*/


# include <_arith2.h>

pol gfselrand( p, AL )
single p; 
list AL;
{
	single i, n;
	int hi;
	gfel a;

        bind( AL );
	init( hi, a );

/** n ist Erweiterungsgrad von GF(p^n ) ueber GF(p)     **/
        n = lfirst( lfirst( AL ) );
        a = _0;
        for ( i = 0; i < n; i++ )
        { 
          hi = irand( p );
          if ( hi ) a = lcomp2( i, hi, a ); 
        }
        if ( a == _0 )  a = 0;
        return( a );
}
