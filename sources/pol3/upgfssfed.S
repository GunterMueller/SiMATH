/*M
.SH NAME
upgfssfed - univariate polynomial over Galois-field with single characteristic, separate factors of equal degree

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upgfssfed(p, AL, P, d)  
single p, d; 
list AL; 
pol P;
      
.SH DESCRIPTION
.TP 4
.B p
is a prime number, 2 < p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B d
is a positive integer number.
.TP 4
.B P
is a monic, squarefree and univariate polynomial over GF(p^n), which has only irreducible factors of degree d.
.PP
upgfssfed returns a list, containing all irreducible factors of P.

.SH SEE ALSO
.nf
gfsalgen
Literatur: M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci., 
                      p.394-398, 1981.      

M*/
                               
/*H
	Version 1       22.10.1992      Joachim Stein
   DATE upgfssfed     : 921130
H*/


#include <_pol3.h>
static list upgfssep(single,list,pol,single,pol);
list upgfssfed( p, AL, G, d )
single p,d; 
list AL;
pol G;
{
	single n, m;
	int q;
	pol S; 
        list L;

        bind( AL, G );
	init( q, S, L );

        m = pdegree( 1, G );
        if ( m == d ) return( list1( G ) );
/** falls Grad( G ) >=  2 **/
	if ( m >= 2 ) 
        {          
/** Berechnung von n und q  **/
          n = lfirst( lfirst( AL ) );
    	  q = iexp( p, n );
          do 
          {
            S = upgfsrand( p, AL, m-1 );
            S = upgfstf( p, AL, S, d-1, G ); 
          }
          while ( pdegree( 1, S ) == 0 );
          L = upgfssep( p, AL, G, d, S );
          return( L );
	}
}


                             

/*c
        upgfssep ist static-Modul zu upgfssfed.
c*/

static list upgfssep( p, AL, G, d, S )
single p,d; 
list AL;
pol G, S;
{
	single n, m;
	int q;
	pol P, Q, g; 
        list L1, L2, L;
        gfel a;

        bind( AL, G, S );
	init( q, P, Q, g, L1, L2, L, a );

/** falls Grad( G ) == 1 oder Grad( G ) == d **/
        m = pdegree( 1, G );
        if ( m == d ) return( list1( G ) );
	S = pgfsrem( 1, p, AL, S, G );
        if ( pdegree( 1, S ) == 0 )    
        {
          do 
          {
            S = upgfsrand( p, AL, m-1 );
            S = upgfstf( p, AL, S, d-1, G ); 
          }
          while ( pdegree( 1, S ) == 0 );
        }
/** Berechnung von n und q  **/
        n = lfirst( lfirst( AL ) );
        q = iexp( p, n );
        q = idif( q, 1 );
        q = isquot( q, 2 );
        do 
        {
          do 
            a = gfselrand( p, AL );   
          while ( a == 0 );
          P = list2( 0, a );
          Q = pgfssum( 1, p, AL, S, P );
          Q = pgfsexpprem( 1, p, AL, Q, q, G );
          P = list2( 0, list2( 0, 1 ) );
          Q = pgfsdif( 1, p, AL, Q, P );
          g = upgfsgcd( p, AL, Q, G );
        }
        while ( (pdegree( 1, g ) == 0) || (pdegree( 1, g ) == pdegree( 1, G )) );
        L = _0;
        L1 = upgfssep( p, AL, g, d, S ); 
        g = pgfsquot( 1, p, AL, G, g );
        L2 = upgfssep( p, AL, g, d, S );
        L = lconc( L1, L2 );
        return( L );
}              

