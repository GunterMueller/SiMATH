/*M
.SH NAME
mam2ssle - matrix over Z/2Z,  special bit representation, solution of a system of linear equations 

.SH SYNOPSIS
.nf
#include <_matr1.h>

matrix mam2ssle(A, bT, pX, pN)
matrix A;
matrix bT, *pX;
list *pN;

.SH DESCRIPTION
mam2ssle() computes a solution of a system of linear equations
and returns a code z. Let b the transpose of bT. 

.PP
If the solution of A*x=b is unique, then *pX is 1xn matrix containing this solution,
z equals 0 and *pN is the empty list.
.PP
If A*x=b has no solution, then *pX is the empty list, z equals -1 and 
*pN is a basis of the null space (see below).
.PP
If there exists more than one solution of A*x=b, then z equals dimension of the null space,
*pX is 1xn matrix containing  one solution and *pN is a basis of the null space of A (see below). 

.PP
.TP 4 
.B A 
is a mxn-matrix over Z/2Z in special bit representation.
.TP 4
.B bT 
is a 1xm - matrix over Z/2Z in special bit representation. 

.SH NOTE
Unlike the other functions named ma*ssle there are some differences
in this function.
 
.PP
If A is not regular, the return value *pN is a matrix in 
special bit representation, whose rows are a basis of the null
space, and NOT simply a list of vectors. 
.PP
The vectors b and *pX are represented as 1xm and 1xn matrices, 
NOT as vectors and NOT as mx1 or nx1 matrices as one might 
perhaps expect. 

.SH SEE ALSO
mam2gnsb, mam2nsb, mam2inv
M*/
/*H
	Version 1       25.09.1996	Marc Conrad
H*/
#include <_matr1.h>

#define explode(s, T) (lfirst(mam2tomams(list2(s,T)))) 
#define implode(T) (lfirst(lred(mamstomam2(list1(T))))) 

single mam2ssle( A, b, pX, pN )  
	obj A, b; 
	obj *pX, *pN; 
	{ 
	
	obj M, Z, P; 
	single s, t, u, a; 
	list E; 

	bind( A, b ); 
	init( M, Z, E, P); 
	s = lfirst( A ); 
	A = lred( A ); 

	b = lfirst(mam2tomams(b)); 

	M = _0; 

	while( A != _0 ) { 
		Z = explode(s,lfirst( A ) ); 
		Z = lcomp(lfirst(b), Z); 
		A = lred(A); 
		b = lred(b); 

		Z = implode(Z); 
		M = lcomp( Z, M); 
		} 
	Z = b = A = 0; 
	M = linv(M); 
	M = lcomp(s+1, M); 


	M = mam2gnsb(M, _0, 2); 

	if( M == _0 ) { 
		*pX = _0; 
		*pN = _0; 
		return(-1); 
		} 

	s = lfirst(M); 
	M = lred(M); 
	t = s - 1; 

	E = _0; 	
	P = 0; 
	u = 0; 	
	while( M != _0 ) { 
		Z = explode(s, lfirst(M)); 
		M = lred( M ); 
		a = lfirst(Z); 
		Z = implode(lred(Z)); 

		if( a == 0 ) { E = lcomp(Z, E); u++; } 
		else if( P == 0) { P = list2(t, Z); } 
		else { 
			Z = list2(t, Z); 
			Z = mam2sum(Z, P); 
			E = lcomp(lsecond(Z), E); 
			u++; 
			} 
		} 
	if( E != _0 ) { 
		E = lcomp(t, E); 
		} 

	if ( P == 0 ) { *pX = _0; u = -1; } 
	else *pX = P; 
	*pN = E; 

	return( u );  
	} 
	
