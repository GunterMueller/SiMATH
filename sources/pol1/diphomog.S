/*M
.SH NAME
diphomog - distributive polynomial homogenize

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol diphomog(r, P) 
single r, 
pol P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables.
.PP
diphomog returns the polynomial P as a polynomial in r+1 variables with homogenized variable Xr+1, if r+1 < BASIS and homogeneous total degree < BASIS,
else diphomog returns ERROR.

.SH CAUTION
diphomog returns a polynomial with variables list        (Xr+1, X1, ..., Xr).

.SH SEE ALSO
diphomogsv

M*/

/*H
        Version 1       05.06.1989      V. Schwinn 
        Version 2       08.11.1989      V. Schwinn      hinzugefuegt:
                                        Variable E1 und E1 = lcopy(E) 
   DATE diphomog      : 890801.900101
H*/


# include <_pol1.h>

pol diphomog( r, P)
single r; pol P;

{ pol Q;
  list H, E, E1, Z;
  int max, e, grenze;
  obj koeff;

  bind( P );
  init( Q, H, E, E1, Z, max, e, grenze, koeff);
         
  H = P;    /* Initialisierung */
  Z = _0;   /* Liste der Monomgrade */
  Q = _0;
  max = 0;  /* max. Gesamtgrad der Monome */
  grenze = iexp( 2, 30); 
 
  if ( icomp( grenze, isum( r, 1) ) != 1 )
  { return(ERROR);
  }

  while ( H != _0 )
  {  
    e = 0;
    H = lred( H );
    E = lfirst( H );
    H = lred( H );                    /* E zeigt auf Exponentenliste */
   
    while ( E != _0 )                 /* e summiert Exponenten auf */
    {   
      e = isum( e, lfirst( E ) );
      E = lred( E );

    } 
  
    max = imax( max, e );             /* Maximum bestimmen */
    Z = lcomp( e, Z );
    if ( icomp( grenze, max) != 1 )
    { return( ERROR );                /* Gesamtgrad kein single */
    }
  }
   
  Z = linv( Z );                      /* Z enthaelt alle Monomgrade */
  H = P; 
  while ( H != _0 )
  {                       
    koeff = lfirst( H );                           
    H = lred( H );
    Q = lcomp( koeff, Q );            /* Kopieren des Koeffizienten */
    koeff = ( max - lfirst( Z ) );    /* Gesamtgrad - Monomgrad */
    Z  = lred( Z );

    E  = lfirst( H );                 /* Exponentenlist erweitern  */
    E1 = lcopy( E );                  /* Q wird ja KOPIE von P !!! */
    H  = lred( H );                   /* H zeigt auf naechsten Koeff. */
    E1 = lsuffix( E1, koeff );

    Q  = lcomp( E1, Q );              /* Exponentenliste an Ergebnis */

  }                              
  Q = linv( Q );
  return( Q );
}
                                         
