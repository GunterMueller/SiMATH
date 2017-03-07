/*M
.SH NAME
gfsalgiessp - Galois-field with single characteristic arithmetic list generator isomorphic embedding of subfield, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

list gfsalgiessp(p, Gm, m, n, ALn)  
single p, m, n; 
pol Gm; 
list ALn;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B m
is an integer number, 1 <= m <= BASIS.
.TP 4
.B n
is an integer number, 1 <= n < m, n divides m. 
.TP 4
.B Gm
is an univariate and irreducible polynomial over Z/pZ of degree m, 
(The irreducibility of Gm will not be checked) or the zero polynomial.
.TP 4
.B ALn
is the arithmetic list for GF(p^n), given for example by gfsalgen (s. gfsalgen).
.PP
gfsalgiessp returns a list L = (ALm, P), where ALm is the arithmetic list for GF(p^m) (s. gfsalgen) and P is a re-presentation of the isomo
rphic embedding of GF(p^n) into GF(p^m).

.SH SEE ALSO
.nf
gfsalgen
gfsalgenies

M*/             
                
/*H     
	Version 1       13.06.1989      V. Schwinn
	Version 2       04.07.1991      ueberfl. Variable m0 beseitigt.  PS
	Version 3       15.11.1996      S. Schmitt (Gm eingefuegt)
   DATE gfsalgiessp   : 890801.8909__.910715
H*/

#include <_arith3.h>  

list gfsalgiessp( p, Gm, m, n, ALn )
single p, m, n;
pol Gm;
list ALn;

{ single k, r;
  obj a; 
  gfel P;
  list ERG, ALm, L, Z;  

  bind( Gm, ALn );
  init( a, P, ERG, ALm, L, Z );               

/* Gm = irred. Polynom fuer gfsalgen; P = 2. Teil des Resultats; ALm =   */
/* 1. Teil des Resultats; das Resulat wird mittels ERG uebergeben        */


  k  = m % n; 

  if (( k ) || ( m < n ) || ( n == 1 ))     
  { return( _0 );                                    /* sinnlose Eingabe */ 
  }

  ALm = gfsalgen( p, m, Gm);
    
  Z = lfirst( ALn );              /* Irr(t,Fp) wird in Fp^m faktor.  */
  Z = pmstopgfs(1, p, Z );
  L = upgfsrf( p, ALm, Z );                      /* L = (g1, ... gn) */

  r = m;                          /* gi von minimalem Grad suchen    */
  while ( L != _0 )
  { Z = lfirst( L );
    L = lred( L );
    k = lfirst( Z );              /* k = Grad von gi ( in s )        */
    if ( k<r )
    { P = Z;
      r = k;
    }
  }
      
  ERG = list2( ALm, P );
            
  return( ERG );
}
