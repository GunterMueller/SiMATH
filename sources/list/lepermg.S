/*M
.SH NAME
lepermg - list element permutations generator

.SH SYNOPSIS
.nf
#include<_list.h>

list lepermg ( L )  
list L;
        
.SH DESCRIPTION
.TP 4
.B L
is a list.
.PP
lepermg returns a list, containing all permutations of the elements of L.
.SH EXAMPLE
L = ( 1 2 3 )  =>  
lepermg(L) =  ( ( 3  1  2 )  ( 3  2  1 )
( 2  1  3 )  ( 2  3  1 )  ( 1  2  3 )  ( 1  3  2 ) ).

M*/
          
/*H
	Version 1	25.07.1993	Marc Conrad
   DATE lepermg       : 931130
H*/
#include<_list.h>

list lepermg(L)

list L;

{
	list K, D, M, N;
	obj a;
	single n, i;

	bind(L);
	init(a, K, D, N);

	K = _0;
	n = llength(L);    
	
	if( n == 1 ) return( list1( L ) ); 

	M = L;

	for (i = 1; i <= n; i++) {
		a = lfirst(M);
		M = lred(M);
		if (!islelt(M, a)) {
			D = lecdel(L, i);
			N = lepermg(D);
			while( N != _0 ) { 
				D = lfirst( N ); 
				N = lred( N );  
				D = lcomp( a, D ); 
				K = lcomp( D, K ); 
				}
		}
	}
	return (K);
}




