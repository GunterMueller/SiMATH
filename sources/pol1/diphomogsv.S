/*M
.SH NAME
diphomogsv - distributive polynomial homogenize specified variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol diphomogsv(r, P, n) 
single r, n; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables.
.TP 4
.B n
is an integer number, 0 < n <= r+1.
.PP
diphomogsv returns the polynomial P as a polynomial in r+1 variables with homogenized variable Xr+1, if r+1 < BASIS and homogeneous total degree < BASIS, else diphomogsv returns ERROR.
.PP
The additional variable Xr+1 will be inserted at the n-th position of the variables list belonging to P. 
 
.SH SEE ALSO
diphomog

M*/

/*H
        Version 1       07.06.1989      V. Schwinn 
        Version 2       04.09.1989      V. Schwinn (Aufruf dipbsort)
   DATE diphomogsv    : 890801.891101
H*/


# include <_pol1.h>

pol diphomogsv( r, P, n)
single r, n; 
pol P;

{ pol Q;
  list E, E2, H, Z;
  int max, e, grenze;
  obj koeff, expo;                                                          
  single i;

  bind( P );
  init( Q, E, E2, H, Z, max, e, grenze, koeff, expo );
         
  H = P;                              /* Initialisierung               */
  Z = _0;                             /* Liste der Monomgrade          */
  Q = _0;                             /* Resultat                      */
  max = 0;                            /* max. Gesamtgrad der Monome    */
  grenze = iexp( 2, 30); 
 
  if (( icomp( grenze, isum( r, 1) ) != 1 ) || ( n < 1 ) || !( n <= r+1 ))
  { return(ERROR);
  }

  while ( H != _0 )
  {  
    e = 0;
    H = lred( H );
    E = lfirst( H );                  /* zeigt auf Exponentenliste     */
    H = lred( H );                    /* zeigt auf naechst. Koeff.     */
   
    while ( E != _0 )                 /* e summiert Exponenten auf     */
    {               
      expo = lfirst( E );
      e = isum( e, expo );
      E = lred( E );

    } 
  
    max = imax( max, e );             /* Maximum bestimmen             */
    Z = lcomp( e, Z );
    if ( icomp( grenze, max) != 1 )
    { return( ERROR );                /* Gesamtgrad kein single        */
    }                                                                     
  }
   
  Z = linv( Z );                      /* Z enthaelt alle Monomgrade    */
  H = P; 
  while ( H != _0 )
  {
    koeff = lfirst( H );                           
    H = lred( H );
    Q = lcomp( koeff, Q );           /* Kopieren des Koeffizienten     */
    koeff = ( max - lfirst( Z ) );   /* Gesamtgrad - Monomgrad         */
    Z = lred( Z );

    E = lfirst( H );                 /* E zeigt auf Exponentenliste    */
    H = lred( H );                   /* H zeigt auf naechsten Koeff.   */  

    E2 = _0;                         /* neue Exponentenliste bauen     */
    for ( i=r+1; i; i--)
    { if ( i == n )
      { E2 = lcomp( koeff, E2 );
      }
      else
      { expo = lfirst( E );
        E2 = lcomp( expo, E2 );
        E = lred( E );
      }                        
    } 
    
    E2 = linv( E2 );
    Q = lcomp( E2, Q );               /* Exponentenliste an Ergebnis   */

  }
  Q = linv( Q );                      
  if ( n-1 )
  { dipbsort( r, Q );                 /* auf SIMATH-Konvention bringen */
  }
  return( Q );
}
                                         






