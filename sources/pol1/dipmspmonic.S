/*M
.SH NAME
dipmspmonic - distributive polynomial over modular single primes monic

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmspmonic(r, p, P)  
single r, p; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P                                                                            
is a distributive polynomial in r variables over Z/pZ.                          
.PP                                                                             
Let A be the leading coefficient of P, dipmspmonic returns the monic polynomial 
P1, where                                                                       
.PP                                                                             
P1 = A^(-1) * P.                                                                
                                                         
M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipmspmonic   : 930115
H*/

#include <_pol1.h>

pol dipmspmonic(r,p,P)
single r,p;
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
    single LBC,LBCinv;
    pol    P1;

    bind(P);
    init(P1);
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
    if ( LBC == 1 ) return(P1);
/*
 * Test - Ende
 * Polynom normieren - Anfang
 */
    LBCinv = msinv(p,LBC);
    P1     = dipmspmsprod(r,p,P1,LBCinv);
/*
 * Polynom normieren - Ende
 * Fall: P != 0 - Ende
 * Rueckgabe
 */
    return(P1);
  }
}
