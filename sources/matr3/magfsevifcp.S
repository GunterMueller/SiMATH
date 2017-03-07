/*M
.SH NAME
magfsevifcp - matrix over Galois-field with single characteristic, eigenvalues and irreducible factors of the characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr3.h>

list magfsevifcp(p, AL, M, pL)
single p;
matrix M;
list AL,*pL;

.SH DESCRIPTION
magfsevifcp() returns the list L=(EV1, ..., EVk)
of eigenvalues of M and stores the factorization
of the characteristic polynomial in the list *pL.
The eigenvalues appear according to their algebraic multiplicity. 


.PP
.TP 4
.B p
>2, must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
must be a square matrix over GF(p^n).
.TP 4
.B *pL
is assigned the list of irreducible factors of the characteristic polynomial.
Each factor appears according to its multiplicity.
The zeros of these polynomial factors are the eigenvalues of M.
M*/



/*H
	Version 1	27.07.1993	S. Schmitt
   DATE magfsevifcp   : 931130
H*/

#include <_matr3.h>

list magfsevifcp( p, AL, M, pL )
matrix M;
single p;
list   AL,*pL;

{
	list   FCHP, IF, L, LH, LH1, LH2;
	pol    CHP;
	single m, n;

	bind( M );
	init( CHP, FCHP, IF, L, LH, LH1, LH2 );
                                                 
/* Berechnung und Faktorisierung des charakteristischen Polynoms */

	CHP = magfschpol( p, AL, M );
	FCHP = upgfscfact( p, AL, CHP );

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
	         LH2 = gfsneg( p, AL, LH2 );
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


