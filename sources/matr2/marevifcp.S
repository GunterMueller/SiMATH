/*M
.SH NAME
marevifcp - matrix over the rational numbers, eigenvalues and irreducible factors of the characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr2.h>

list marevifcp(M, pL)
matrix M;
list *pL;

.SH DESCRIPTION
marevifcp() returns the list L=(EV1, AM1, ..., EVk, AMk)
of eigenvalues EVi of M and their algebraic multiplicities AMi
and stores the factorization of the characteristic polynomial in the list *pL.


.PP
.TP 4
.B M
must be a square matrix over the rational numbers.
.TP 4
.B *pL
is assigned the list (P1, E1, ..., Pn, En) of irreducible factors Pi
of the characteristic polynomial and their exponents Ei.
The zeros of these linear factors are the eigenvalues of M.
M*/
/*H
	Version 1   	17.08.1989   	Th. Weis
	Version 2   	04.05.1990   	Th. Weis
		    			in Zeile 91: list1(LH3) --> list1(LH4)
	Version 3   	05.12.1990   	Th. Weis
	           			EVMARIFCP --> MAREVIFCP   
	Version 4	20.10.1994	Dokumentation korrigiert. MP
   DATE marevifcp     : 890901.901120.910715.9109__.941201
H*/

#include <_matr2.h>

list marevifcp( M, pL )
matrix M;
list   *pL;

{
	list   FCHP, IF, L, LH, LH1, LH2, LH3, LH4;
	pol    CHP;
	single m, n;

	bind( M );
	init( CHP, FCHP, IF, L, LH, LH1, LH2, LH3, LH4 );

/* Berechnung und Faktorisierung des charakteristischen Polynoms */

	CHP = marchpol( M );
	FCHP = uprfact( CHP );

/* Initialisierung */

	L = _0;
	IF = _0;
	LH = lcopy( FCHP );
	LH = lred( LH );
	n = llength( LH );

/* Bestimmung der Eigenwerte und der irreduziblen Faktoren des ch. P. */

	if ( n >= 2 )
	do
	{
	   LH1 = lfirst( LH );
	   LH2 = lsecond( LH );
	   LH2 = list1( LH2 );
	   m = llength( LH1 );
	   if ( m == 2 )
	   {
	      LH3 = list1( 0 );
	      L = lconc( L, LH3 );
	      L = lconc( L, LH2 );
	   }
	   else if ( m == 4 )
	   {
	      if ( lfirst( LH1 ) == 1 )
	      {
	         LH3 = lfourth( LH1 );
	         LH3 = ineg( LH3 );
	         LH3 = list1( LH3 );
	         LH4 = lsecond( LH1 );
	         LH4 = list1( LH4 );
	         LH4 = lconc( LH3, LH4 );
	         LH3 = list1( LH4 );
	         L = lconc( L, LH3 );
	         L = lconc( L, LH2 );
	      }
	      else
	      {
	         LH1 = list1( LH1 );
	         IF = lconc( IF, LH1 );
	         IF = lconc( IF, LH2 );
	      }
	   }
	   else
	   {
	      LH1 = list1( LH1 );
	      IF = lconc( IF, LH1 );
	      IF = lconc( IF, LH2 );
	   }   
	   LH = lred2( LH );
	}
	while ( LH != _0 );
	else L = ERROR;
	*pL = IF;

/* Ausgabe */

	return( L );
}
