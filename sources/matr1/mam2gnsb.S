/*M
.SH NAME
mam2gnsb - matrix over Z/2Z, special bit representation, generalized null space basis 

.SH SYNOPSIS
.nf
#include <_matr1.h>

matrix mam2gnsb(A, n, mode)
matrix A;
single n, mode;

.SH DESCRIPTION
mam2gnsb() returns a matrix in special bit representation whose rows
represent a set of linear independent vectors in the null space of A,
or the empty list in case A is regular.

.PP
.TP 4 
.B A 
is a matrix over Z/2Z in special bit representation. 
.TP 4
.B n 
is an upper bound of the number of linear independent vectors 
in the null space of A, which are computed.
If n is the empty list, the vectors form a basis of the null space.
.TP 4
.B mode 
determines, how the matrix A will be changed, after the execution of mam2gnsb(). 
.RS
.PD 0
.TP 
.B mode = 0:
A will be not defined,
.TP 
.B mode = 1: 
A will be not changed,
.TP  
.B mode = 2: 
A will be changed to its triangular form, but without
zero rows.

.SH CAUTION
A may be changed depending on mode.

.SH NOTE
This function is a generalization of mam2nsb(). 

.SH SEE ALSO
mam2nsb, mam2prod, mam2sum, mam2inv 
M*/

/*H
	Version 1	18.03.1996	Marc Conrad
   DATE mam2gnsb      : 960501
H*/

#include <_matr1.h>

int lm2sum_sp(Y, X ) 
	int Y, X; 
	{ 
	int a; 
	while( Y != _0 ) { 
		if( X == _0 ) { 
			printf("F1: FEHLER X = _0\b"); 
			exit(1); 
			} 
		a = lfirst( Y ) ^ lfirst(X); 
		lsfirst(Y, a); 
		Y = lred( Y ); X = lred( X ); 
		} 
	if( X != _0 ) { 
		printf("F2: FEHLER X != _0\b"); 
		exit(1); 
		} 
	} 

				

matrix mam2gnsb(MM, n, mode)
	matrix MM; 
	single n, mode; 
	{ 
	list Z, X, N, M; 

	single i, j, u, s,z, x, y,t, gefunden; 
	single dim, a, b, v, w; 
	
	list VV; 

	list E, F, V, W; 
	init( W,V, VV ); 
	init( X, Z, N,  E, M); 
	bind(MM);

	x = 0; 
	dim = 0; 
		
	s = lfirst( MM ); 
	if( mode == 1 ) M = lcopy(lred(MM)); 
	else { 
		M = lred( MM ); 
		lsred(MM, _0);
		} 

	t = llength(lfirst(M)); 
	VV = _0; 
	for( i = 0; i < t; i++ ) VV = lcomp(0, VV); 
	V = VV; 

	u =  (1 << ((s-1)%30));
	E = _0; 
	W = _0; 
	for( i = 1 ; i <= s && M != _0 ; i++ ) { 
		X = Z = 0;
		gefunden = 0; 
		N = M; 
		while( N != _0 && !gefunden) { 
		    Z = lfirst( N ); 
		    if( u & lfirst( Z ) ) { 
			gefunden = 1;
			if( X ) lsred( X, lred(N) );  
			else M = lred( M ); 
			}  
		    X = N; 
		    N = lred( N ); 
		    } 
		X = 0;
		if( gefunden ) { 
		    while( N != _0 ) { 
			X = lfirst(N); 
			if( u & lfirst(X) ) { 
				lm2sum_sp(X, Z); 
				lsfirst(N,X); 
				} 
			N = lred( N ); 
			} 
		    N = W; 
		    while( N != _0 ) { 
			X = lfirst(N); 
			if( u & lfirst(X) ) { 
				lm2sum_sp(X, Z); 
				lsfirst(N,X); 
				} 
			N = lred( N ); 
			} 
		    W = lcomp(Z, W); 	
	            lsfirst( V, (lfirst( V ) | u)); 
		    } 
		
		u = (u >> 1); 
		y = x;
		if( u == 0 ) { 
			u = (1<<29);
			N = M; 
			x++; 
			V = lred( V ); 
			while( N != _0 ) { 
			    X = lfirst(N); 
			    X = lred( X ); 
	               	    lsfirst(N, X ); 
			    N = lred( N ); 
			    } 
			N = W; 
			while( N != _0 ) { 
			    X = lfirst(N); 
			    X = lred( X ); 
	               	    lsfirst(N, X ); 
			    N = lred( N ); 
			    } 
			} 
		if( gefunden ) { 
		        for( j = 0; j < y ; j++ ) { 
			Z = lcomp(0, Z); 
		    } 
	            E = lcomp(Z, E); 	
		}
	} 
	E = linv(E);
	if( mode == 2 ) { 
		lsred(MM, E); 
		} 	
	dim = s - llength(E);
	if( dim > n ) dim = n; 

	if( dim == 0 ) {
		return( _0 ); 
		} 
/* Das folgende Nullsetzen spart Speicher! */
	Z = X = V = M = N = W = 0; 
	M = maconszero( dim, 1 ); 

   	v =  (1 << ((s-1)%30));
	V = VV; 
	b = 0; 
	for( i=0; i < s; i++ ) { 
		if( !v ) { 	
			v = (1<<29); V = lred( V );
			N = M; while( N != _0 ) { 
				X = lcomp( 0, lfirst(N) );
				lsfirst(N, X);
				N = lred(N);
				}
			} 
		if( !(v & lfirst(V)) ) { 
			b++;
			Z = 0;
			 }
		else {  
			Z = lfirst(E); 
			E = lred( E ); 
			} 
   		w =  (1 << ((s-1)%30));
		W = VV; 
		N = M; 
		a=0; 
		for(j=0; j<s && N != _0; j++) { 
			if( !w ) { 
				w = (1<<29); W = lred( W );
				if( Z ) Z = lred(Z); 
				} 	
			if( !(w & lfirst(W)) ) { 
			    X = lfirst(N); 
			    N = lred(N); 
			    a++;
			    if( Z ) { 
				u = lfirst(Z) & w; 
				if( u ) lsfirst(X, v | lfirst(X)); 	
				} 
			    else if( a == b ) { 
			        lsfirst(X, v | lfirst(X));
				} 	
			    } 
			w = w >> 1; 
			} 
		v = v >> 1; 
		}
	N = M;
	while( N != _0 ) { 
		X = linv(lfirst(N));
		lsfirst(N,X);
		N = lred(N);
		}	
		
	return(lcomp(s, M)); 
	} 
	
