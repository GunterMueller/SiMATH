/*M
.SH NAME
mamievifcp - matrix of modular integers, eigenvalues and irreducible factors of the characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr2.h>

list mamievifcp(p, M, pL)
int p;
matrix M;
list *pL;

.SH DESCRIPTION
mamievifcp() returns the list L=(EV1, ..., EVk)
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
	Version 1	31.01.1992      Bernd Mayr
   DATE mamievifcp    : 920331
H*/

#include <_matr1.h>

list mamievifcp( p, M, pL )
matrix M;
int p;
list   *pL;

{
	list   FCHP, IF, L, LH, LH1, LH2;
	pol    CHP;
	single m, n;

	bind( M,p );
	init( CHP, FCHP, IF, L, LH, LH1, LH2 );
                                                 
/* Berechnung und Faktorisierung des charakteristischen Polynoms */

	CHP = mamichpol( p, M );
	FCHP = upmicfact( p, CHP );

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
