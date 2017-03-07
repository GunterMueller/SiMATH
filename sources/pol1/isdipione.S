/*M
.SH NAME
isdipione - is distributive polynomial over integers one

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdipione(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over the integer numbers.
.PP
isdipione returns 
.PP
   1,  for P = 1;
   0,  else.

M*/

/*H
	Version 1	21.07.1992	Th. Weis
   DATE isdipione     : 930115
H*/

#include <_pol1.h>

single isdipione(r,P)
single r;
pol    P;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  return(0);
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single t;
    pol    PS;
    int    BC;
    list    EL;

    bind(P);
    init(PS,BC,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Test, ob P = 1  - Anfang
 */
    PS = dipmoad(r,P,&BC,&EL);
    if ( BC != 1 || PS != _0 )  return(0);
    t = dipevsign(r,EL);
    if ( t == 0 ) return(1);
    return(0);
/*
 * Test, ob P = 1 & Rueckgabe - Ende
 */
  }
}
