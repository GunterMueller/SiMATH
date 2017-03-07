/*M
.SH NAME
ussdiff - unordered set symmetrical difference

.SH SYNOPSIS
.nf
#include<_list.h>

list ussdiff(L1,L2)  
list L1, L2;

.SH DESCRIPTION
.TP 4
.B L1, L2
are lists.
.PP   
ussdiff returns a list, containing the unordered symmetri-cal difference of L1 and L2.

M*/
          
/*H
	Version 1       23.07.1993      Marc Conrad
   DATE ussdiff       : 931130
H*/

#include<_list.h>

list ussdiff(L, M )
	
	list L, M; 
{
	
	list K; 
	
	init( K ); 
	bind( L, M );  
        
	K = usdiff( M, L );   
   
	return( lcconc(usdiff(L,M), K) ); 

}	
