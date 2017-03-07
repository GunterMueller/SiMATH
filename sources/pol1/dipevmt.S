/*M
.SH NAME
dipevmt - distributive polynomial exponent vector multiple test

.SH SYNOPSIS
.nf
#include<_pol1.h>

single dipevmt(r, EV1, EV2)  
single r; 
list EV1, EV2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B EV1, EV2
are the exponent vectors of distibutive polynomials in r variables over an arbitrary ring, so EV1 and EV2 have length r.  
.PP
dipevmt returns
.TP 4
1, 
if EV1 is a multiple of EV2, i.e. every component of EV1 is greater or equal to the accordant component of EV2.
.TP 4
0,
else.

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipevmt       : 930115
H*/

#include <_pol1.h>

single dipevmt(r,EL1,EL2)
single r;
list   EL1,EL2;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single t,hel1,hel2;
  list   HEL1,HEL2;

  bind(EL1,EL2);
  init(HEL1,HEL2);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  t = 1;
  if ( EL1 == _0 ) return(t);
  HEL1 = EL1;
  HEL2 = EL2;
/*
 * Vorbesetzen - Ende
 * Bestimmung des Maximums der Komponeneten - Anfang
 */
  do {
     hel1 = lfirst(HEL1);  HEL1 = lred(HEL1);
     hel2 = lfirst(HEL2);  HEL2 = lred(HEL2);
     if ( hel1 < hel2 ) {
        t = 0;
        break;
     }
  } while ( HEL1 != _0 );
/*
 * Bestimmung des Maximums der Komponeneten - Ende
 * Rueckgabe
 */
  return(t);
}
