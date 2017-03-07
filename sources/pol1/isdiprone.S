/*M
.SH NAME
isdiprone - is distributive polynomial over rationals one 

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdiprone(r, P)  
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
isdiprone returns
.PP
   1,   for P = 1,
   0,   else.
 
M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE isdiprone     : 930115
H*/

#include <_pol1.h>

single isdiprone(r,P)
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
    pol    PS;
    rat    BC;
    list   EL;

    bind(P);
    init(PS,BC,EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Test, ob P = 1  - Anfang
 */
    PS = dipmoad(r,P,&BC,&EL);
    if ( PS != _0 )  return(0);
    if ( dipevsign(r,EL) != 0 ) return(0);
    return(isrone(BC));
/*
 * Test, ob P = 1 & Rueckgabe - Ende
 */
  }
}
