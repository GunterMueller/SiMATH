/*M
.SH NAME
mam2inv - matrix over Z/2Z in special bit representation, inverse

.SH SYNOPSIS
.nf
#include <_matr1.h>

matrix mam2inv (M)
matrix M;

.SH DESCRIPTION
mam2inv() returns the matrix M^(-1).

.PP
.TP 4
.B M 
is a matrix over Z/2Z in special bit representation. 
M must be a square matrix with an invertible determinant.
M*/

/*H
	Version 1       20.10.1995      Josef Gebel
	Version 2	31.03.1996	Komplett neu. Marc Conrad
   DATE mam2inv       : 951201.960501
H*/

#include <_matr1.h>

matrix mam2inv( M ) 
matrix M;
{
	list N;
	matrix Z, E; 		
	single s, t, i; 
	
	bind( M ); 
	init( N, E, Z); 
	
	s = lfirst(M); 
	M = lred(M); 

	t = llength(lfirst(M)); 
	E = mam2um(s); 
	
	N = lred(E); 
	while( N != _0 ) { 
		if( M == _0 ) { 
			printf("FEHLER! Matrix nicht quadratisch!\n");
			} 
/* Falls M veraendert werden darf: lcconc durch lconc ersetzen. */
		Z = lcconc( lfirst(M), lfirst(N) ); 
		lsfirst(N, Z); 
		N = lred( N ); 
		M = lred(M); 
		} 
	lsfirst( E, s + 30 * t); 
	mam2gnsb(E, 0, 2); 

	N = lred(E); 
	for( i = 0; i < s-1; i++ ) { 
		Z = lreduct(lfirst(N), t); 
		lsfirst(N, Z); 
		N = lred( N ); 
		} 
	Z = lreduct(lfirst(N), t-1); 
	if( lfirst(Z) == 0 ) { 
		return(0); 
		} 
	Z = lred( Z ); 
	lsfirst(N, Z); 

/* So sieht der Code ohne Regularitaetstest aus: 
	while( N != _0 ) { 
		Z = lreduct(lfirst(N), t); 
		lsfirst(N, Z); 
		N = lred(N); 
		} 
*/
	lsfirst(E, s); 

	return( E ); 
	} 
		
	
	
	
	
	
	
	
