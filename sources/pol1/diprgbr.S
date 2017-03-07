/*M
.SH NAME
diprgbr - distributive polynomial over rationals Groebner basis recursion
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
list diprgbr(r, PL)  
single r; 
list PL;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.       
.TP 4
.B PL
is a list of distributive polynomials in r variables over the rational numbers. 

.PP
diprgbr returns the minimal, normalized and sorted Groebner basis of PL.        
.PP                                                                             
The Groebner basis of PL will be computed recursively, i.e.                     
.PP                                                                             
For PL = ( P1 ... Pn ),                                                         
 - diprgbr first computes the minimal, normalized and                           
   sorted Groebner basis of P1.                                                 
 - After that, the polynomial P2 will be added to the                           
   computed Groebner basis, and again diprgbr computes                          
   the minimal, normalized and sorted Groebner basis.                           
 - This procedure will be repeated for all n polynomials                        
   in PL.                                                                       
                                                                                                                                      
M*/        

/*H
	Version 1	23.07.1992	Th. Weis
   DATE diprgbr       : 930115
H*/

#include <_pol1.h>

list diprgbr(r,PL)
single r;
list   PL;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  list PP,PPR;
  pol  P;

  bind(PL);
  init(PP,PPR);
  init(P);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  PP  = _0;
  PPR = PL;
/*
 * Vorbesetzen - Ende
 * Groebner Basen Berechnung - Anfang
 */
  while ( PPR != _0 ) {
        P = lfirst(PPR);  PPR = lred(PPR);
        PP = diprgba(r,PP,P);
  }
/*
 * Groebner Basen Berechnung - Ende
 * Rueckgabe
 */
  return(PP);
}
