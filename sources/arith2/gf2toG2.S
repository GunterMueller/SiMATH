/*M
.SH NAME
gf2toG2 - (SIMATH) Galois field with characteristic 2 element to G2 element

.SH SYNOPSIS
.nf
#include<_G2arith.h>
#include<_arith2.h>

single gf2toG2( P, e )
gf2el P;
unsigned long e[];

.SH DESCRIPTION
gf2toG2() converts a SIMATH gf2-polynomial to a G2-polynomial. 
The return value is 1 if the conversion can be 
performed, 0 otherwise. 
.PP
.TP 4
.B P
is a polynomial in one variable over Z/2Z in special bit representation. 
.PP
.TP 4
.B e
is a polynomial over Z/2Z according to the conventions of the G2-package.
.SH NOTE
The conversion can be safely performed if deg(P) <= G2maxdeg(),
 
.SH SEE ALSO
G2togf2, G2arith, P2arith
M*/

/*H
	Version  1      24.08.1999	Marc Conrad
H*/


#include<_arith2.h>
#include<_G2arith.h>

single gf2toG2(gf2el A, unsigned long *e)
{
	unsigned long *pe;
	unsigned a, b, c, d, k = 0, l = 30, z = 0;
        list B, C;  

        init(B, C); 
        bind(A); 

	if (!A) { *e = 0; return(1); } 
         
/*      A = lcinv(lred(A)); ist gemeint. Die Konstruktion mit B und C
        ist aber wesentlich schneller! */

        B = A;
        C = A = linv(lred(A)); 
	pe = e + 1;
	a = (unsigned) (lfirst(A));
	A = lred(A);
	while (A != _0) {
		b = (unsigned) (lfirst(A));
		A = lred( A );
		c = (a >> k);
		d = (b << l);  
		if (  ++z  >= G2LAENGE ) { 
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
        lsred(B,linv(C));
	if ( z >= G2LAENGE ) { 
		return( 0 );      
		}
	return ( 1 );
}

