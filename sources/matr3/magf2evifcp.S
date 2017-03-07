/*M
.SH NAME
magf2evifcp - matrix over Galois-field with characteristic 2 eigenvalues and irreducible factors of the characteristic polynomial 

.SH SYNOPSIS
.nf
#include<_matr3.h>

list magf2evifcp(G, M, pL) 
pol G;
matrix M;
list *pL;

.SH DESCRIPTION
magf2evifcp() returns the list (EW1,...,EWk) of the eigenvalues
of M. The elements EWi in GF(2^n) appear according to their
algebraic multiplicity.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a square matrix in GF(2^n)^(i,i).
.TP 4
.B *pL
is a list (P1,...,Pn) that will be assigned polynomials
that represent the irreducible factors of the characteristic polynomial 
of M. The elements Pi are polynomials over GF(2^n) and appear
according to their algebraic multiplicity.
M*/
/*H
	Version 1	11.03.1996	S. Schmitt
   DATE magf2evifcp   : 960501
H*/

#include <_matr3.h>

list magf2evifcp( G, M, pL )
matrix M;
pol G;
list *pL;

{
	list   FCHP, IF, L, LH, LH1, LH2;
	pol    CHP;
	single m, n;

	bind( M, G );
	init( CHP, FCHP, IF, L, LH, LH1, LH2 );
                                                 
/* Berechnung und Faktorisierung des charakteristischen Polynoms */

	CHP = magf2chpol( G, M );
	FCHP = upgf2bofact( G, CHP );

/* Initialisierung */

	L = _0;
	IF = _0;
	LH = lcopy( FCHP );
	n = llength( LH );

/* Bestimmung der Eigenwerte und der irreduziblen Faktoren des ch. P. */

	if ( n >= 1 )
	do
	{
	   LH1 = lfirst( LH );
	   m = llength( LH1 );
	   if ( m == 2 )
	   {
	      LH2 = list1( 0 );
	      L = lconc( L, LH2 );
	   }
	   else if ( m == 4 )
	   {
	      if ( lfirst( LH1 ) == 1 )
	      {
	         LH2 = lfourth( LH1 );
	         LH2 = gf2neg( G, LH2 );
	         LH2 = list1( LH2 );
	         L = lconc( L, LH2 );
	      }
	      else
	      {
	         LH1 = list1( LH1 );
	         IF = lconc( IF, LH1 );
	      }    
	   }
	   else
	   {
	      LH1 = list1( LH1 );
	      IF = lconc( IF, LH1 );
	   }   
	   LH = lred( LH );
	}
	while ( LH != _0 );
	else L = ERROR;
	*pL = IF;

/* Ausgabe */

	return( L );
}


