/*M
.SH NAME
diptdg - distributive polynomial total degree

.SH SYNOPSIS
.nf
#include<_pol1.h>

single diptdg(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over an arbitrary ring.
.PP
diptdg returns the maximal total degree of the polynomial P.

M*/

/*H
        Version 1	08.05.1993	Th. Weis
   DATE diptdg        : 931130
H*/

#include <_pol1.h>

single diptdg(r,P)
single r;
pol    P;
{
/*
 * Fall: r == 0 || P == 0  oder  r == 1  - Anfang
 */
  if ( r == 0 || P == 0 )  return(0);
  if ( r == 1 )  return(lfirst(lsecond(P)));
/*
 * Fall: r == 0 || P == 0  oder  r == 1  - Ende
 * Fall: r > 1 && P != 0
 */
  {
    single deg,max;
    pol    PS;
    list   EV;
    obj    BC;

    bind(P);
    init(PS,EV,BC);
/*
 * Vorbesetzen - Anfang
 */
    PS  = P;
    max = 0;
/*
 * Vorbesetzen - Ende
 * Finde den maximalen Totalgrad der Exponentenvektoren - Anfang
 */
    do {
       PS  = dipmoad(r,PS,&BC,&EV);
       deg = 0;
       do {
          deg = deg + lfirst(EV);
          EV  = lred(EV);
       } while ( EV != _0 );
       max = smax(deg,max);
    } while ( PS != _0 );
/*
 * Finde den maximalen Totalgrad der Exponentenvektoren - Ende
 * Rueckgabe
 */
    return(max);
  }
}
