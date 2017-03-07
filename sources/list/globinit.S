/*M
.SH NAME
globinit - init for global and static variables

.SH SYNOPSIS
.nf
#include<_list.h>
 
single globinit( pL )  
obj *pL;
   
.SH DESCRIPTION
globinit enters the address pL into the STACK. globinit(&A) for a static or global variable A is equal to init(A) for a local variable  A (s. handbook). Several calls of globinit for the same address &A will cause only one entry of this address in STACK. globinit(&A) returns 1, if &A is yet in STACK, and 0 else.    

M*/

/*H
	Version 1	07.02.1992	Marc Conrad
	Version 2	25.03.1993	(Fehler beseitigt) Marc Conrad
   DATE globinit      : 920331.930115
H*/


/* ACHTUNG ! Dieses File enthaelt ZWEI Funktionen: globinit und globbind. */


#include<_list.h>    

static single ST_GLOB_IN=0;

single globinit( pL )   
obj *pL;  
{                     
single i; 
for (i=0; i<ST_GLOB_IN; i++ ) 
	if ( pL == *(STACK+i) ) return(1);
if(ST_SIZE<=ST_INDEX+1) setstack(ST_SIZE+125);

ST_GLOB_IN++;  
ST_INDEX++;
for( i = ST_INDEX; i >= 1 ; i-- ) 
	*(STACK+i)= *(STACK + (i - 1));
*(STACK) = pL; 
*pL=0;
return(0);
}     


single globbind( pL )   
obj *pL;  
{                     
single i; 
for (i=0; i<ST_GLOB_IN; i++ ) 
	if ( pL == *(STACK+i) ) return(1);
if(ST_SIZE<=ST_INDEX+1) setstack(ST_SIZE+125);

ST_GLOB_IN++;  
ST_INDEX++;
for( i = ST_INDEX; i >= 1 ; i-- ) 
	*(STACK+i)= *(STACK + (i - 1));
*(STACK) = pL; 
return(0);
}     

