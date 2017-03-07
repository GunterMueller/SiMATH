/*M
.SH NAME
qnfidprod - quadratic number field ideal product

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfidprod( D, A, B )  
int D; 
list A, B;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B A, B
are ideals in the ring of integers O_K of the field K (for representation of ideals s. below).
.PP
qnfidprod returns the ideal C (say), where
.IP
C = A * B.

.SH NOTES
Simath represents ideals as lists of four elements
.PP
( a b c s )  int a, b, c; single s; , where
.PP 
s
= 1, for D = 2 or 3 mod 4, 
  = 2, else
.PP 
a 
is a natural number, 
.PP 
b
= min{ n natural number | n is in
        (b/s * Z + (c+D^(1/2))/s * Z) }
.PP   
0 <= c < b.
.PP
The ideal represented in that way is the ideal
.IP
(a) + (b/s * Z + (c+D^(1/2))/s * Z).
 
.SH SEE ALSO
Literatur: A.J. Stephens and H.C. Williams
           "Some Computational Results on a Problem 
            Concerning Powerful Numbers", 
           Math. Comp. V. 50, #182 April 1988, pp 619-632. 

M*/
                            
/*H
        Version 1	14.10.1993      Josef Gebel
   DATE qnfidprod     : 931130
H*/

#include <_arith2.h>

list qnfidprod( D, A1, A2 )
int  D; 
list A1, A2;
{
    bind( D, A1, A2 );

    if( !lfirst( A1 ) ||  !lfirst( A2 ) )
    {
	/***   A1 oder A2 sind das Nullideal   ***/
	return( list4( 0, 0, 0, lfourth( A1 ) ) );
    }
    if( isqnfidone( D, A1 ) )
    {
	/***   A1 ist das Eins-Ideal: A1 = O_D   ***/
	return( A2 );
    }
    if( isqnfidone( D, A2 ) )
    {
	/***   A2 ist das Eins-Ideal: A2 = O_D   ***/
	return( A1 );
    }
    if( !qnfidcomp( D, A1, A2 )  )
    {
	/***   A1 == A2   ***/
	return( qnfidsquare( D, A1 ) );
    }
    else
    {
	single s;
	int    Q1, Q2, Q3, P1, P2, P3, G, U, x1, x2, y2, h1, h2, h3;

	init( Q1, Q2, Q3, P1, P2, P3, G, U, x1, x2, y2, h1, h2, h3 );


	Q1 = lsecond( A1 );
	Q2 = lsecond( A2 );
	P1 = lthird ( A1 );
	P2 = lthird ( A2 );
	s  = lfourth( A1 );

	h1 = iquot( Q1, s );
	h2 = iquot( Q2, s );
	G  = ihegcd( h2, h1, &x1 );
	                  /***   (Q1/s) * x1 + (Q2/s) * y1 = G     ***/

	h3 = isum ( P1, P2 );
	h3 = iquot( h3,  s );

	U  = iegcd( h3, G, &x2, &y2 );
	                  /***        P1 + P2                      ***/
	                  /***   U = --------- * x2 + G * y2       ***/
	                  /***           s                         ***/
	
	h3 = iprod(  U,  U );
	Q3 = iprod( Q1, h2 );     /***   Q3 = Q1 * Q2 / s          ***/
	Q3 = iquot( Q3, h3 );     /***   Q3 = Q1 * Q2 / (U^2 * s)  ***/

	h2 = idif ( P1, P2 );
    
	if( icomp( G, U ) )
	{
	    /***   G != U   ***/

	    h2 = iprod( h2, x1 );
	    h2 = iprod( h2, y2 );
    
	    h3 = iprod( P1, P1 );
	    h3 = idif (  D, h3 );
	    h3 = iprod( h3, x2 );
	    h3 = iquot( h3, Q1 );

	    h2 = isum ( h3, h2 );
        }
	    
	h3 = iquot( Q2,  U );
	if( h3 == 1 )
	{
            h2 = 0;
	}
	else
	{
	    h2 = mihom( h3, h2 );
	}
	    
	h2 = iprod( h1, h2 );        /***   h2 = h3 * (Q1/s)       ***/
	h2 = iquot( h2,  U );        /***   h2 = (h3 * Q1)/(U * s) ***/
	h2 = isum ( h2, P1 );

	if( Q3 == 1 )
	{
            P3 = 0;
	}
	else
	{
	    P3 = mihom( Q3, h2 );
	}

	U = iprod( U, lfirst( A1 ) );
	U = iprod( U, lfirst( A2 ) );

	return( list4( U, Q3, P3, s ) );
    }
}
