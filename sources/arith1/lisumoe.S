/*M
.SH NAME
lisumoe - list of integers sum over all entries

.SH SYNOPSIS
.nf
#include<_arith1.h>

int lisumoe(L)
list L;

.SH DESCRIPTION
lisumoe() returns the sum of all entries in
the non-empty list of integers L.
M*/
/*H
	Version 1       11.11.1994      Joachim Stein
   DATE lisumoe	      : 941201
H*/

#include <_arith1.h>

int lisumoe( L )

list L;                     
                                                                         
{
        int S, hi;

	bind( L );
	init( S, hi );

        S = 0;
        while( L != _0 )
        { 
          S = isum( S, lfirst( L ) );
          L = lred( L );
        }
        return( S );
}
