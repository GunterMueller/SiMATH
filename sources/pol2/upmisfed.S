/*M
.SH NAME
upmisfed - univariate polynomial over modular integers separate factor of equal degree

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmisfed(p, P, d)  
int p; 
single d; 
pol P;
    
.SH DESCRIPTION
.TP 4
.B p
is an odd prime number.
.TP 4
.B P
is an univariate and monic polynomial over Z/pZ.
.PP
upmisfed returns a list L = (h1, ..., hk),             where for 1 <= i <= k,
.IP
 the hi are irreducible of the same degree d,
 deg(P) = k * d,
 P = h1 * ... * hk.

.SH SEE ALSO
M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci.,
           p.394-398, 1981.

M*/

/*H
	Version 1       17.02.1993 	Joachim Stein
   DATE upmisfed      : 930531
H*/

#include <_pol2.h>

static list upmisep(int,pol,single,pol);

list upmisfed( ip, G, d )
int ip; 
pol G;
single d; 
{
	single m;
	int q;
	pol S; 
        list L;

        bind( ip, G );
	init( q, S, L );

/** m = Grad( G ) **/
        m = pdegree( 1, G );
/** falls m = d, G irreduzibel vom Grad d **/
        if ( m == d ) return( list1( G ) );
/** falls Grad( G ) >= 2, Algorithmus C **/
	if ( m >= 2 ) 
        {          
/** Berechnung eines Zufallspolynoms vom Grad echt kleiner als G **/
          do 
          {
            do
            {
              S = upmirand( ip, m-1 );
            }
            while ( pdegree( 1, S ) == 0 );
            S = upmitfsp( ip, S, d-1, G ); 
          }
          while ( pdegree( 1, S ) == 0 );
          L = upmisep( ip, G, d, S );
          return( L );
	}
}


                             

/*c
			upmisep( ip, G, d, S )

	"univariate polynomial over modular integers, separate factors"
        upmisep ist static-Modul zu upmisfed.
        Literatur: M. Ben-Or: Proc.22, IEEE Symp. Foundations Comp. Sci.,
                              p.394-398, 1981.
c*/
/*H
	Version 1       17.02.1993 	Joachim Stein
H*/

static list upmisep( ip, G, d, S )
int ip; 
single d; 
pol G, S;
{
	single m;
	int a, E;
	pol P, Q, g; 
        list L1, L2, L;

        bind( ip, G, S );
	init( a, E, P, Q, g, L1, L2, L );

/** falls Grad( G ) == 1 oder Grad( G ) == d **/
        m = pdegree( 1, G );
        if ( m == d ) return( list1( G ) );
	S = pmirem( 1, ip, S, G );
        if ( pdegree( 1, S ) == 0 )    
        {
          do 
          {
            do 
            {
              S = upmirand( ip, m-1 );
            }
            while ( pdegree( 1, S ) == 0 ); 
            S = upmitfsp( ip, S, d-1, G ); 
          }
          while ( pdegree( 1, S ) == 0 );
        }
/** Berechnung von  **/
        E = idif( ip, 1 );
        E = isquot( E, 2 );
        do 
        {
          do 
            a = irand( ip );   
          while ( a == 0 );
          P = list2( 0, a );
          Q = pmisum( 1, ip, S, P );
          Q = upmimpexp( ip, Q, E, G );
          P = list2( 0, 1 );
          Q = pmidif( 1, ip, Q, P );
          g = upmigcd( ip, Q, G );
        }
        while ( (pdegree( 1, g ) == 0) || (pdegree( 1, g ) == pdegree( 1, G )) );
        L = _0;
        L1 = upmisep( ip, g, d, S ); 
        g = pmiquot( 1, ip, G, g );
        L2 = upmisep( ip, g, d, S );
        L = lconc( L1, L2 );
        return( L );
}              
