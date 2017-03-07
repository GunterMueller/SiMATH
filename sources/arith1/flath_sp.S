/*M
.SH NAME
flath_sp - floating point area tangens hyperbolicus special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flath_sp(f)
floating f;

.SH DESCRIPTION
flath_sp() returns the area tan hyp of f,
provided that |f| < 1.

.SH CAUTION
flath_sp() uses expansion into a series and therefore the algorithm is very slow if | f | is close to 1.
M*/

/*H
	Version 1	19.04.91	Marc Conrad
   DATE flath_sp      : 910715
H*/

#include<_arith1.h>
flath_sp( f )
floating f;   
{
	floating sum0, sum, fpot;
	single n;
	
	bind(f);
	init( sum0, sum, fpot );
	                     
	sum0 = 0;
	fpot = f;
	sum  = f;
	n    = 0;
	f = flprod(f,f);
	while ( !oequal( sum0, sum ) ) {
		sum0 = sum;
		fpot = flprod(f,fpot);      
		n += 2;
		sum = flsum( sum, flsquot( fpot, n + 1 ) );     
		}
	return ( sum );
        }
	
