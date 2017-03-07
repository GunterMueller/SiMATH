/*M
.SH NAME
mam2nzc - matrix over Z/2Z, special bit representation, number of zero columns

.SH SYNOPSIS
.nf
#include<_matr1.h>

single mam2nzc(M, bound)
matrix M;
single bound;

.SH DESCRIPTION
Let d be the number of rows of M which
only contain zeros after applying Gauss elimination.
If M is square, d equals the dimension of the null space of M.
mam2nzc() returns the minimum of bound and d.

.PP
.TP 4
.B M
is a matrix over Z/2Z in special bit representation.
M*/
/*H
        Version 1      20.10.95		Marc Conrad 
   DATE mam2nzc      : 951201
H*/

#include <_matr1.h>


/*  minimum von (Anzahl der Spalten, die == 0 sind, bound) */
int mam2nzc(l,bound ) 
	matrix l; 
	single bound; 
	{ 
	list A, B, C, D; 
	single z, a, b, zz; 
	list m, k, anzsp;  
	single dimk; 
	
 	bind(l); 
	init(A,B);
	anzsp = lfirst(l); 	
	A = l = lred(l); 
/* 'Spiegeln' der Zeilen, aus hysterischen Gruenden :) */
	while( A != _0 ) { 
		lsfirst(A, linv(lfirst(A))); 
		A = lred( A ); 
		} 
	
	z = 1; 
	zz = 0; 
	dimk = 0; 
	while( zz < anzsp  && l != _0 ) { 
		zz++; 
		m = l; 
		A = lfirst(m); 
		a = lfirst(A); 
		k = 0; 
		while( m != _0 && ! (a & z) ) { 
			k = m; 
			m = lred( m ); 
			if( m != _0 ) {  
			    if( z == (1<<29) ) {
				lsfirst(k, lred(A)); 
			        }	
			    A = lfirst(m); 
			    a = lfirst(A); 
			    } 
		} 
		if( a & z ) { 
		    m = lred(m); 
		    if( !k ) l = lred(l); 
		    else lsred(k,m);
		    }  

		else { 
		    dimk++;
		    if( dimk >= bound ) return dimk; 
		    if ( z == (1<<29) )  { 
			if( k ) lsfirst( k, lred(A) ); 
			else l = lcomp(lred(A), m); 
			} 
		    } 
		
	        while( m != _0 ) { 
			B = lfirst(m); 
			b = lfirst(B); 
			if( b & z ){
		            C = A; D = B; 	
			    while(C != _0 ) { 
				lsfirst(D, lfirst(C) ^ lfirst(D) ); 
				C = lred(C); 
				D = lred(D); 
				}
			    } 
			if( z == (1<<29) ) { 
				B = lred(B); 
				lsfirst(m, B);
				}
			m = lred(m); 
			} 
		if( z == (1<<29) ) 
			z = 1; 
		else z = z << 1; 
		} 
	return( dimk ); 
	} 
			
			




