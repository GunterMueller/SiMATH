/*M
.SH NAME
distributive polynomial over rationals in lexicographical order to distributive polynomial over rationals with total degree ordering
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol diprlototdo(r, P)  
single r; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.     
.TP 4                                                                           
.B P                                                                            
is a distributive polynomial in r variables over the rational numbers.     
P is a polynomial in lexicographical order. 
.PP
diprlototdo returns the transformed polynomial P to a polynomial with total degree ordering.

.SH SEE ALSO
 diprlotoglo
 diprlotolio
                                                                    
M*/                                                                             
   
/*H
	Version 1	12.08.1992	Th. Weis
   DATE diprlototdo   : 930115
H*/

#include <_pol1.h>

pol diprlototdo(r,P)
single r;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(P);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    pol    P1,P2,P3;
    rat    BC1;
    list    EL1;

    bind(P);
    init(P1,P2,P3);
    init(BC1);
    init(EL1);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    EVORD = 3;
    P1    = P;
    P2    = _0;
    P3    = 0;
/*
 * Vorbesetzen - Ende
 * Sortieren - Anfang
 */
    do {
       P1 = dipmoad(r,P1,&BC1,&EL1);
       P2 = dipfmo(r,BC1,EL1);
       P3 = diprsum(r,P3,P2);
    } while ( P1 != _0 );
/*
 * Sortieren - Ende
 * Rueckgabe
 */
    return(P3);
  }
}
