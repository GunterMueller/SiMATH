/*M
.SH NAME
diprmonic - distributive polynomial over rationals monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol diprmonic(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.    
.TP 4                                                                           
.B P                                                                            
is a distributive polynomial in r variables over the rational numbers.
.PP
Let A be the leading coefficient of P, diprmonic returns the monic polynomial 
P1, where                                                                       
.PP                                                                             
P1 = A^(-1) * P.                                                                
                                                        
M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE diprmonic     : 930115
H*/

#include <_pol1.h>

pol diprmonic(r,P)
single r;
pol    P;
{
/*
 * Fall: P = 0 - Anfang
 */
  if ( P == 0 ) return(0);
/*
 * Fall: P = 0 - Ende
 * Fall: P != 0 - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    rat    LBC,LBCinv;
    pol    P1;

    bind(P);
    init(LBC,LBCinv,P1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    P1  = P;
/*
 * Vorbesetzen - Ende
 * Test: Ist der fuehrende Koeffizient = 1 - Anfang
 * wenn ja, Rueckgabe
 */
    LBC = diplbc(r,P);
    if ( isrone(LBC) == 1 ) return(P1);
/*
 * Test - Ende
 * Polynom normieren - Anfang
 */
    LBCinv = rinv(LBC);
    P1     = diprrprod(r,P1,LBCinv);
/*
 * Polynom normieren - Ende
 * Fall: P != 0 - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
