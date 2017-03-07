/*M
.SH NAME
gf2nbprod - Galois-field of characteristic 2, normal basis, product

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2nbprod(G, MT, a, b)  
obj G; 
list *MT; 
gf2el a, b;

.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic univariate polynomial over GF(2) of degree n > 1 with coefficients in special bit notation (see udpm2tosb). G is interpreted as a generating polynomial of the field GF(2^n).
.TP 4
.B MT 
is a pointer on an array that contains the multiplication table of a normal element of GF(2^n), see 'gf2nbmt'.
.TP 4
.B a, b
are elements in GF(2^n) represented in special bit notation with respect to the normal basis of GF(2^n) corresponding to MT. 
.PP
gf2nbprod returns an element of GF(2^n), say c, where 
.IP
c = a * b.

.SH SEE ALSO
 udpm2tosb
 gf2nbmt

M*/
                                        
/*H
	Version 1	14.09.1994	Josef Gebel
   DATE gf2nbprod     : 941201
H*/

#include <_arith2.h>
				
gf2el gf2nbprod( G, MT, a, b )
obj G;
list *MT;
gf2el a, b;
{
    if ( a && b )		/***   Both a and b non zero	 ***/
    {
	/***   Let a != 0 be of type gf2el. Then		 ***/
	/***   a = ( n(a)  a_k(a)  ...	a_0 )			 ***/
	/***		single n(a), ... , a_0;			 ***/
	/***   where k(a) = ( n(a) + 1 ) / 30.			 ***/

	gfel   bb,   /***   bb is used to run through b		 ***/
	       res;  /***   result a * b			 ***/

	single i,    /***   auxiliary varible			 ***/
	       n,    /***   field degree			 ***/
	       a1,   /***   current 'single' word of a		 ***/
	       b1,   /***   current 'single' word of bb		 ***/
	       sa,   /***   positon of the current bit of a	 ***/
	       sb,   /***				  bb	 ***/
	       xa,   /***   positon of the single word of a	 ***/
	       xb,   /***				  bb	 ***/
	       ta,   /***   position of the first bit of a1	 ***/
		     /***   (right to left)			 ***/
	       tb,   /***   position of the first bit of b1	 ***/
		     /***   (right to left)			 ***/
	       pb;   /***   store the original value of tp.	 ***/

	bind( G, a, b );

	init( bb, res );
	
	n = lfirst( G );

	ta = 1 + lfirst( a );
	if( !( i = ta % 30 ) )
	{
	    ta -= 30;
	} 
	else
	{
	    ta -= i;
	}

	pb = 1 + lfirst( b );
	if( !( i = pb % 30 ) )
	{
	    pb -= 30;
	} 
	else
	{
	    pb -= i;
	}
	a = lred( a );
	b = lred( b );

	while( a != _0 )
	{
	    a1 = lfirst( a );
	    sa = ta; 
	    xa = ( ( ( n << 1 ) - sa - 1 ) * sa ) >> 1;
	    while( a1 )
	    {
		if( a1 & 1 )
		{
		    bb = b; 
		    tb = pb;

		    while( bb != _0 )
		    {
			b1 = lfirst( bb );
			sb = tb; 
			xb = ( ( ( n << 1 ) - sb - 1 ) * sb ) >> 1;
			while( b1 )
			{
			    if( b1 & 1 )
			    {
				/***   res ;= res + beta^(2^i)	       ***/
				/***   where i = 2^sa + 2^sb and       ***/
				/***   beta is the normal element      ***/
  
				/***   Let su = min{ sa, sb } and      ***/
				/***	   sv = max{ sa, sb }. Then    ***/
				/***		    ( su + 1 ) * su    ***/
				/***   xu = su * n - ---------------   ***/
				/***			   2	       ***/
				/***   (u = a, v = b or u = b, v = a)  ***/
				/***   and MT[xu + sv] = beta^(2^i)    ***/

				if( sa > sb )
				{
				    res = gf2sum( G, res, *( MT + sa + xb ) );
				}
				else
				{
				    res = gf2sum( G,  res, *( MT + sb + xa ) );
				}
			    }
			    b1 >>= 1;
			    sb++;
			    xb += n;
			    xb -= sb;
			}
			bb = lred( bb );
			tb -= 30;
		    }
		}
		a1 >>= 1;
		sa++;
		xa += n;
		xa -= sa;
	    }
	    ta -= 30;
	    a = lred( a );
	}
	return( res );
    }

    /***   a = 0 or b = 0 ==>  a 8 b = 0    ***/
	
    return( 0 );
}
