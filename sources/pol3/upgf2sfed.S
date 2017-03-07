/*M
.SH NAME
upgf2sfed - univariate polynomial over Galois-field with characteristic 2, separate factor of equal degree

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgf2sfed(G, P, d)  
obj G; 
pol P; 
single d;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be interpreted as a generator of GF(2^n)
(Galois-field with characteristic 2).
.TP 4
.B P
is a monic, squarefree and univariate polynomial over GF(2^n) with coefficients in special bit-representation.
.TP 4
.B d 
is an integer number, d < BASIS.
.PP
upgf2sfed retuns a list (h_1, ..., h_k) of irreducible polynomials of degree d in special bit-representation, such that
.PP
P = h_1 * ... * h_k and deg(P) = k*d            
hold.

.SH SEE ALSO
.nf
udpm2tosb
Literatur: M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci.,
                      p.394-398, 1981.    

M*/
                                    
/*H
	Version 1       26.05.1993      Joachim Stein
   DATE upgf2sfed     : 931130
H*/


#include <_pol3.h>
static list upgf2sep(obj,pol,single,pol);
list upgf2sfed( G, H, d )
single d; 
obj G;
pol H;
{
	single n, m;
	int q;
	pol S; 
        list L;

        bind( G, H );
	init( q, S, L  );

        m = pdegree( 1, H );
        if ( m == d ) return( list1( H ) );
/** falls Grad( H ) >=  2 **/
	if ( m >= 2 ) 
        {          
/** Berechnung von n und q  **/
          n = lfirst( G );
    	  q = iexp( 2, n );
          do 
          {
            S = upgf2gen( G, m-1 );
            S = upgf2tf( G, S, d-1, H ); 
          }
          while ( pdegree( 1, S ) == 0 );
          L = upgf2sep( G, H, d, S );
          return( L );
	}
}


                             

/*c
			upgf2sep( G, H, d, S )

	"univariate polynomial over Galois-field with characteristic 2,
        separate factors "
        upgf2sep ist static-Modul zu upgf2sfed.
        Literatur: M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci.,
                              p.394-398, 1981.
c*/
/*H
	Version 1       26.05.1993              Joachim Stein
H*/

static list upgf2sep( G, H, d, S )
single d; 
obj G;
pol H, S;
{
	single i, j, n, m;
	int q;
	pol P, Q, R, g; 
        list L1, L2, L;
        gf2el a;

        bind( G, H, S );
	init( q, P, Q, R, g, L1, L2, L, a );

/** falls Grad( H ) == 1 oder Grad( H ) == d **/
        m = pdegree( 1, H );
        if ( m == d ) return( list1( H ) );
	S = pgf2rem( 1, G, S, H );
        if ( pdegree( 1, S ) == 0 )    
        {
          do 
          {
            S = upgf2gen( G, m-1 );
            S = upgf2tf( G, S, d-1, H ); 
          }
          while ( pdegree( 1, S ) == 0 );
        }
/** Berechnung von n und q  **/
        n = lfirst( G );
        q = iexp( 2, n );
/** Bestimmung von T(d*s(x)) **/
        do 
        {
          do 
          {
            a = gf2elrand( G );   
          }
          while ( a == 0 );
          Q = pgf2gf2prod( 1, G, S, a );
          R = 0;       

          for ( i = 0; i < n; i++ )
          {
            j = iexp( 2, i );
            P = pgf2expprem( 1, G, Q, j, H );
            R = pgf2sum( 1, G, R, P );
            R = pgf2rem( 1, G, R, H );
          }
          g = upgf2gcd( G, R, H );
        }
        while ( (pdegree( 1, g ) == 0) || (pdegree( 1, g ) == pdegree( 1, H )) );
        L = _0;
        L1 = upgf2sep( G, g, d, S ); 
        g = pgf2quot( 1, G, H, g );
        L2 = upgf2sep( G, g, d, S );
        L = lconc( L1, L2 );
        return( L );
}              

