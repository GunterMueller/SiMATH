/*M
.SH NAME
itoE - (SIMATH) integer to Essen integer

.SH SYNOPSIS
.nf
#include<_HDarith.h>

single itoE( A, e )
int A;
LONG e[];

.SH DESCRIPTION
itoE() converts a SIMATH integer to an Essen integer, if A >= 0 and A < 2^(32 * (LAENGE-1) ). In this case the return code is 1, otherwise the range of A is invalid and itoE() returns 0.
.PP
.TP 4
.B A
is an integer in SIMATH list representation
.PP
.TP 4
.B h
is an integer according to the conventions of the Heidelberg arithmetic package
 
.SH SEE ALSO
Etoi, Etoineg, itoEb, itoEsb
M*/

/*H
	Version  1      24.12.1991	Marc Conrad
   DATE itoE          : 920331.9211__
H*/


#include<_arith1.h>
#include<_Earith.h>

single itoE(A, e)
	LONG *e;
	int A;

{


	if (!A) {
		e[0] = 0;
		e[1] = 0;
	} else if (issingle(A)) {
		e[0] = 1;
		e[1] = (unsigned) A;
	} else {
		LONG *pe;
		unsigned a, b, c, d, k = 0, l = 30, z = 0;

		pe = e + 1;
		a = (unsigned) (lfirst(A));
		A = lred(A);
		while (A != _0) {
			b = (unsigned) (lfirst(A));
			A = lred( A );
			c = (a >> k);
			d = (b << l);  
			if (  ++z  >= LAENGE ) { 
				return( 0 );      
				}
			*(pe++) = c | d;
			k += 2; 
			l -= 2; 
			if ( l == 0 ) { 
				k=0;
				l=30;  
				if ( A != _0 ) {    
				a = (unsigned) (lfirst(A));
				A = lred( A );
				}
				else goto fertig;  
				}
				
			else a = b;
		}
	c = (a >> k);
		if (c)
			*(pe++) = c, z++;
fertig:		
		e[0] = z;
		if ( z >= LAENGE ) { 
			return( 0 );      
			}
	}
	return ( 1 );
}
