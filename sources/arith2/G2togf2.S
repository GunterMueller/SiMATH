/*M
.SH NAME
G2togf2 - G2 element to (SIMATH) Galois field with characteristic 2 element

.SH SYNOPSIS
.nf
#include<_G2arith.h>
#include<_arith2.h>

gf2el G2togf2( e )
unsigned long e[];

.SH DESCRIPTION
G2togf2() converts a G2-polynomial to a (SIMATH) gf2-polynomial. 
G2togf2() returns the value of e as a Galois field with characteristic 2 
element in list representation.
.PP
.TP 4
.B e
is a polynomial over Z/2Z according to the conventions of the G2-package.

.SH SEE ALSO
gf2toG2, G2arith, P2arith
M*/

/*H
	Version  1      24.08.1999	Marc Conrad
H*/


#include<_arith2.h>
#include<_G2arith.h>

#define uitosi( A ) ( (single) ( (A) & (~(3<<30)) ) )     
/* loescht die beiden obersten Bit */
gf2el G2togf2(e)
	unsigned long *e;

{           
	unsigned long *pe;
	list A;           
	single o;

	init(A);

	if (*e == 0) { return (0); }  
	else {                
	    unsigned a, b, c, d, k=30, l=2, i=2;     
	    single s;    
                                                   
	    A = _0;
	    o = e[0];  
	    pe = e + 1;     
	    a = *(pe++);
	    s = uitosi(a);        
	    A = lcomp( s, A );
	    while (i <= o ) {    
		b = *(pe++);  
		i++;
		c = (a >> k);
		d = (b << l);   
		k -= 2; 
		l += 2;
		s = uitosi( c | d );    
		A = lcomp(s, A );
		if ( l == 30 ) { 
			s = (single) ( b >> 2 );
			if( i > o ) { 
				if ( s ) { A = lcomp( s, A ); }    
                                A = lcomp(P2deg(e), A);	
				return ( A );
				}
			A = lcomp( s, A );  
			i++; 
			a = *(pe++);  
			A = lcomp ( uitosi( a ), A ); 
			k = 30;
			l = 2;
			}     
				
		else a = b;
		}
	s = (single) ( a >> k );    
	if( s ) { A = lcomp( s, A ); } 
	A = lcomp(P2deg(e), A);	
	return ( A );     
	}
}
