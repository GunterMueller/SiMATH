/*M
.SH NAME
nf3chpol - number field of degree 3 characteristic polynomial

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol nf3chpol(F,el)  
pol F; 
nfel el;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, monic and univariate polynomial in dense representation over Z of degree 3. F generates a number field, say K. 
.TP 4
.B el 
is an element of K, el != 0 (for representation of number field elements s. nfneg). 
.PP
nf3chpol returns the characteristic polynomial of el, it is a polynomial of degree 3 over Q in sparse representation.

M*/
                   
/*H
	Version 1	20.08.1991	Th. Weis
   DATE nf3chpol      : 921130
H*/

#include <_arith2.h>

pol nf3chpol(F,el)
pol  F;
nfel el;
{
/*
 * Deklaration, Binden & Initialisieren
 */
  list alpha,alphaq;
  list elxalpha,elxalphaq;
  list TfM;
  list chpol;

  bind(F,el);
  init(alpha,alphaq);
  init(elxalpha,elxalphaq);
  init(TfM);
  init(chpol);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  alpha = list4(1,1,1,0);
  alphaq = nfexp(F,alpha,2);
/*
 * Vorbesetzen - Ende
 * Element mit 1, alpha, alpha^2 multiplizieren - Anfang
 */
  elxalpha = nfprod(F,el,alpha);
  elxalphaq = nfprod(F,el,alphaq);

  el = nfeltoudpr(el);
  if ( el != 0 )
  {
    if ( lfirst( el ) == 2 )  el = lred(el);
    else if ( lfirst( el ) == 1 )
    {
      el = lred(el);
      el = lcomp(0,el);
    }
    else  el = lcomp(0,el);
  }
  else el = list3(0,0,0);

  elxalpha = nfeltoudpr(elxalpha);
  if ( elxalpha != 0 )
  {
    if ( lfirst( elxalpha ) == 2 )  elxalpha = lred(elxalpha);
    else if ( lfirst( elxalpha ) == 1 )
    {
      elxalpha = lred(elxalpha);
      elxalpha = lcomp(0,elxalpha);
    }
    else  elxalpha = lcomp(0,elxalpha);
  }
  else elxalpha = list3(0,0,0);

  elxalphaq = nfeltoudpr(elxalphaq);
  if ( elxalphaq != 0 )
  {
    if ( lfirst( elxalphaq ) == 2 )  elxalphaq = lred(elxalphaq);
    else if ( lfirst( elxalphaq ) == 1 )
    {
      elxalphaq = lred(elxalphaq);
      elxalphaq = lcomp(0,elxalphaq);
    }
    else  elxalphaq = lcomp(0,elxalphaq);
  }
  else elxalphaq = list3(0,0,0);
 
  el = linv(el);
  elxalpha = linv(elxalpha);
  elxalphaq = linv(elxalphaq);
/*
 * Element mit 1, alpha, alpha^2 multiplizieren - Ende
 * Koeffizientenmatrix zusammenstellen - Anfang
 */
  TfM = _0;
  TfM = lcomp(elxalphaq,TfM);
  TfM = lcomp(elxalpha,TfM);
  TfM = lcomp(el,TfM); 
/*
 * Koeffizientenmatrix zusammenstellen - Ende
 * Berechnung und Normierung des charakteristischen
 * Polynoms der Koeffizientenmatrix ueber Q  - Anfang
 */
  chpol = marchpol(TfM);
  chpol = prneg(1,chpol);
/*
 * Berechnung und Normierung - Ende
 * Rueckgabe
 */
  return(chpol);
}
