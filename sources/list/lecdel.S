/*M
.SH NAME
lecdel - list element constructive delete

.SH SYNOPSIS
.nf
#include<_list.h>

list ledel (L, n)  
single n; 
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list, containing at least n elements.
.TP 4
.B n
is an integral number, 0 < n < BASIS.
.PP
recdel returns a copy of L without the n-th element.

M*/

/*H
	Version 1	25.07.1993	Marc Conrad
   DATE lecdel        : 931130
H*/
#include<_list.h>

list lecdel( L, n ) 
	list L; 
	single n; 
	{ 
	single i;     
	list K, M; 

	bind( L ); 
	init( K, M ); 
	
	if ( n == 1 ) return( lred( L ) ); 

	K = _0;   
	
	for( i = 1; i < n; i++ ) { 
			K = lcomp( lfirst( L ), K ); 
			L = lred( L ); 
			}    
	L = lred( L ); 
	M = linv( K ); 
	lsred( K, L ); 
	return( M ); 
}



		
	
	
	 
	
	
