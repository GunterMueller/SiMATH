/*M
.SH NAME
flatn_sp - floating point arcus tangens special version

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flatn_sp(f)
floating f;

.SH DESCRIPTION
flatn_sp() returns the area tan of f,
provided that |f| < 1.

.SH CAUTION
flatn_sp() uses expansion into a series and therefore the algorithm is very slow if | f | is close to 1.
M*/
/*H
	Version 1	19.02.1992	Marc Conrad
   DATE flatn_sp      : 920331
H*/


#include<_arith1.h>

flatn_sp( f )
floating f;   
{
	floating sum0, sum, fpot;
	single n, vz, m;
	
	bind(f);
	init( sum0, sum, fpot );     
	
	                     
	sum0 = 0;
	fpot = f;
	sum  = f; 
	f = flprod( f, f );
	n    = 0;   
	vz = 0;
	while ( !oequal( sum0, sum ) ) {   

		sum0 = sum;
		fpot = flprod(f,fpot);      
		n += 2;      
		if ( vz ) m = n + 1;
		else m = - ( n + 1 );  
		vz = !vz;
		sum = flsum( sum, flsquot( fpot, m ) );     
		}
	return ( sum );
        }


	
