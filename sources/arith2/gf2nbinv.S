/*M
.SH NAME
gf2nbinv - Galois-field of characteristic 2 element in normal basis representation inversion

.SH SYNOPSIS
.nf
#include <_arith2.h>

gf2nbinv(G, MT, a)
obj G;
list  *MT; 
gf2el a;

b = gf2nbinv(G, MT, a);

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable over
F2 := Z/2Z of degree n in special bit representation 
(see 'udpm2tosb') as generating polynomial of the field 
F := GF(2^n).
.TP 4
.B MT 
is the address of the multiplication table corresponding
to the current normal basis (see gf2nbprod).
.TP 4
.B a != 0 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
.TP 4
.B b 
is an element of F given in special bit notation
and represented with respect to the current normal basis.
b = a^(-1) in F, if a != 0
  = ERROR, otherwise.

.SH NOTE
Usually, gf2nbinvs() is faster and should be prefered.

.SH SEE ALSO
.BR gf2nbinvs(),
.BR gf2nbprod(),
.BR udpm2tosb()
M*/

/*H
	Version 1	09.09.1994	Josef Gebel
	Version 2       29.08.1996      New arithmetic for matrices
                                         over GF(2); A. Stein
   DATE gf2nbinv	: 941201.961201
H*/

#include <_arith2.h>

gf2el gf2nbinv( G, MT, a )
pol   G;   
list  *MT; 
gf2el a;   
{
    if( a )  {
	single i, n, n1, a1, sa, ta, xa, sb, xb;
	matrix K;
	vec    v;
	gf2el  b, c;

	bind( G, a );
	init( K, b, c, v );

	n = lfirst( G );
	n1 = n/30;

	/***   Solve the system of linear equations   ***/
	/***	   K * b = 1			      ***/
	/***   where the rows k_j of K are given by   ***/
	/***	   k_j = beta^(2^j) * a		      ***/

	/***   STEP 1: Build up the matrix K	      ***/

	K=list1(n);
	sb = n;
	i  = 0;
	xb = ( ( n - 1 ) * n ) / 2;

	while( sb ) {
	    xb += sb;
	    sb--;
	    xb -= n;
	    i++;
	    c = a;
	    ta = 1 + lfirst( c );
            ta = ( !( a1 = ta % 30 ) )? (ta-30):(ta = ta-a1);
	    c = lred( c );

	    /***   Compute  beta^(2^sb) * a, beta = normal element   ***/
	  for( b=0;c != _0; c = lred( c ), ta -= 30) {
		a1 = lfirst( c );
		sa = ta; 
		xa = ( ( ( n << 1 ) - sa - 1 ) * sa ) >> 1;

		while( a1 ) {
		    if( a1 & 1 ) {
			/***   Let su = min{ sa, sb } and      ***/
			/***	   sv = max{ sa, sb }. Then    ***/
			/***		    ( su + 1 ) * su    ***/
			/***   xu = su * n - ---------------   ***/
			/***			   2	       ***/
			/***   (u = a, v = b or u = b, v = a)  ***/
			/***   and MT[xu + sv] = beta^(2^i)    ***/

			b=(sa>sb)?(gf2sum(G,b,*(MT+sa+xb))):(gf2sum(G,b,*(MT+sb+xa)));
		    } 
		    a1 >>= 1;
		    xa += n;
		    sa++;
		    xa -= sa;
	       }	  
	 }
	  
	    /*  Here b = beta^(2^sb) * a    */

	  /* 	Prepare c as a row for mam2transp. Remove the degree.  
		Eventually, add zeros to obtain the right dimension.  */

	    a1 = n1 - lfirst(b)/30;
	    b = lred( b );
	    while( a1--) b =lcomp(0,b);   
	    K = lcomp(b,K);
	}

	K = linv(K);
	K = mam2transp(K);

	/***   STEP 2: 	   Compute K^(-1)                        ***/
	/*** Then a^(-1) = K^{-1} * 1                            ***/
	/*** where 1 = ( n-1, 1, 1, 1, ..., 1 ) in special bit   ***/

	K = mam2inv(K); 
	v = gf2c1cons( G, n-1 );
	return( gf2elsbbt(G, K, v) );
    }
    return( ERROR );
}
