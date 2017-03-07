#include <_list.h>
/*M
.SH NAME
Sfree - free SIMATH-Variables 

.SH SYNOPSIS 
.nf 
#include <_list.h>

int Sfree(pA)
object *pA;

Sfree(pA); 

.SH DESCRIPTION 
Sfree(&A) let  
the SIMATH memory management forget the variable A. 

.SH SEE ALSO 
.BR Sbind(),
.BR Sinit()
M*/
/*H
        Version 1       10.10.1996      Marc Conrad
   DATE Sfree   : 961201
H*/

#undef printf

int Sfree(pa) 
	int *pa; 
	{ 
	int i; 
	int *z; 	
	
	i = ST_INDEX - 1; 
	while(STACK[i] != pa && i >= 0) i--; 
	if( pa != STACK[i] ) { 
printf(
" **** ERROR: You wanted to Sfree() a varibale, which was not ****\n");
printf(
" ****        initialized with Sinit() or Sbind()             ****\n"); 
printf(
" **** 	      ST_INDEX = %5d                                ****\n", ST_INDEX); 
/*		exit(1); */
		} 
	i++; 
	while( i < ST_INDEX ) {
		STACK[i-1] = STACK[i]; 
		i++; 
		} 
	ST_INDEX--; 
	} 
