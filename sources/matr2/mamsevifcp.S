/*M
.SH NAME
mamsevifcp - matrix of modular singles, eigenvalues and irreducible factors of the characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr2.h>

list mamsevifcp(p, M, pL)
single p;
matrix M;
list *pL;

.SH DESCRIPTION
mamsevifcp() returns the list L=(EV1, ..., EVk)
of eigenvalues of M and stores the factorization
of the characteristic polynomial in the list *pL.
The eigenvalues appear according to their algebraic multiplicity. 

.PP
.TP 4
.B p
must be prime.
.TP 4
.B M
must be a square matrix over Z/pZ.
.TP 4
.B *pL
is assigned the list of irreducible factors of the characteristic polynomial.
Each factor appears according to its multiplicity.
The zeros of these linear factors are the eigenvalues of M.
M*/
/*H
	Version 1	17.08.1989	Th. Weis
	Version 2	05.12.1990	Th. Weis
					EVMAMSPIFCP --> MAMSEVIFCP
   DATE mamsevifcp    : 890901.910715.9203__
H*/

#include <_matr2.h>

list mamsevifcp( p, M, pL )
matrix M;
single p;
list   *pL;

{
	list   FCHP, IF, L, LH, LH1, LH2;
	pol    CHP;
	single m, n;

	bind( M );
	init( CHP, FCHP, IF, L, LH, LH1, LH2 );
                                                 
/* Berechnung und Faktorisierung des charakteristischen Polynoms */

	CHP = mamschpol( p, M );
	FCHP = upmscfact( p, CHP );

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
	         LH2 = msneg( p, LH2 );
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
