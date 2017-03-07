/*M
.SH NAME
gf2nbinv Galois-field of characteristic 2, element in normal basis representation inversion

.SH SYNOPSIS
.nf
#include<_pol3.h>

gf2el gf2nbinv(G, MT, a)  
obj G; 
list *MT; 
gf2el a;  

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic polynomial in one variable
over Z/2Z of degree n in special bit representation
(see udpm2tosb) as generating polynomial of GF(2^n).
.TP 4
.B MT
is the address of the multiplication table corresponding
to the current normal basis (see gf2nbprod).
.TP 4
.B a
!= 0 is an element of GF(2^n) given in special bit notation
and represented with respect to the current normal basis.
.PP
gf2nbinv returns the (multiplicatively) inverse
element of a, say b: 
.IP
a * b = b * a = 1. 
.PP
b is given in special bit
notation and represented with respect to the current normal basis.

M*/

/*H
	Version 1	09.09.1994	Josef Gebel
   DATE gf2nbinv      : 941201
H*/

#include <_pol3.h>

gf2el gf2nbinv( G, MT, a )
pol   G;   /***	  G in GF(2)[X], defining polynomial of GF(2^n)	    ***/
list  *MT; /***	  Multiplication table in GF(2^)		    ***/
gf2el a;   /***	  a in GF(2^n), tobe inverted			    ***/
{
    if( a )
    {
       /***   a != 0   ***/
	single i, n, n1, n2, a1, b1, c1, sa, ta, xa, mb, nb, sb, xb;
	matrix K;
	vec    v, x;
	gf2el  b, c;

	bind( G, a );

	init( K );
	init( b, c );
	init( v, x );

	n = lfirst( G );
	n1 = n / 30;
	n2 = n % 30;

	/***   Solve the system of linear equations   ***/
	/***	   K * b = 1			      ***/
	/***   where the rows k_j of K are given by   ***/
	/***	   k_j = beta^(2^j) * a		      ***/

	/***   STEP 1: Build up the matrix K	      ***/
	K = maconszero( n, n );
	
	sb = n;
	i  = 0;
	xb = ( ( n - 1 ) * n ) / 2;

	while( sb )
	{
	    xb += sb;
	    sb--;
	    xb -= n;
	    i++;

	    c = a;

	    ta = 1 + lfirst( c );
	    if( !( a1 = ta % 30 ) )
	    {
		ta -= 30;
	    } 
	    else
	    {
		ta -= a1;
	    }
 
	    c = lred( c );

	    /***   Compute  beta^(2^sb) * a, beta = normal element   ***/
		
	    b = 0;

	    while( c != _0 )
	    {
		a1 = lfirst( c );
		sa = ta; 
		xa = ( ( ( n << 1 ) - sa - 1 ) * sa ) >> 1;

		while( a1 )
		{
		    if( a1 & 1 )
		    {
			/***   Let su = min{ sa, sb } and      ***/
			/***	   sv = max{ sa, sb }. Then    ***/
			/***		    ( su + 1 ) * su    ***/
			/***   xu = su * n - ---------------   ***/
			/***			   2	       ***/
			/***   (u = a, v = b or u = b, v = a)  ***/
			/***   and MT[xu + sv] = beta^(2^i)    ***/

			if( sa > sb )
			{
			    b = gf2sum( G, b, *( MT + sa + xb ) );
			}
			else
			{
			    b = gf2sum( G, b, *( MT + sb + xa  ) );
			}
		    }
 
		    a1 >>= 1;
		    xa += n;
		    sa++;
		    xa -= sa;
		}
		ta -= 30;
		c = lred( c );
	    }
	  
	    /***  Here b = beta^(2^sb) * a    ***/

	    nb = 30 * ( n1 - lfirst( b ) / 30 );
	    mb = n2 + nb;
	    b = lred( b );
 
	    while( b != _0 )
	    {
		nb = mb;
		b1 = lfirst( b );

		while( b1 )
		{
		    if( b1 & 1 )
		    {
			c1 = maselel( K, nb, i );
			c1 ^= 1;
			masetel( K, nb, i, c1 );
		    }
		    b1 >>= 1;
		    nb--;
		}
    
		b = lred( b );
		mb += 30;
	    }
	}
	while( sb );
 
	/***   v = 1: 1 has the representation		    ***/
	/***		   ( 1, 1, 1, ..., 1)		    ***/
	/***	      with respect to (any) normal basis    ***/
	v = _0;

	for( i = 0; i < n; i++ )
	{
	    v = lcomp( 1, v );
	}

	/***   STEP 2: Solve K * x = 1 ***/

	if( !mamsssle( 2, K, v, &x, &c ) )
	{
	    /***    Null space of (K - I) * x has dimension 0	***/
	    /***    K * x = 1  solved correctly			***/

	    /***   STEP 3: Transform the solution x into	***/
	    /***	   special bit representation		***/

	    x = linv( x );
	    b = _0;
	    i = 0;
	    n1 = 30;
	    a1 = 1;
	    b1 = 0;

	    do 
	    {
		if( lfirst( x ) )
		{
		    sb = i;
		    b1 |= a1;
		}
		a1 <<= 1;
		i++;
		n1--;
		if( !n1 )
		{
		    b = lcomp( b1, b );
		    n1 = 30;
		    a1 = 1;
		    b1 = 0;
		}
	    }
	    while( ( x = lred( x ) ) != _0 );

	    if( b1 )
	    {
		return( lcomp2( sb, b1, b ) );
	    }
	    
	    while( !lfirst( b ) )
	    {
		b = lred( b );
	    }
	    return( lcomp( sb, b ) );
	}
	/***	Null space of (K - I) * x has dimension > 0   ***/
	/***	===>  ERROR !  (I is the n x n unit matrix)   ***/
    }
    return( ERROR );
}
