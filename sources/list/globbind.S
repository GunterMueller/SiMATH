/*M
.SH NAME
globbind - bind for global and static variables (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>
 
single globbind( pL )  
obj *pL;
   
.SH DESCRIPTION
globbind enters the address pL into the STACK. globbind(&A) for a static or global variable A is equal to bind(A) for a local variable A (s. handbook). Several calls of globbind for the same address &A will cause only one entry of this address in STACK. globbind(&A) returns 1, if &A is yet in STACK, and 0 else.

M*/

/*H
	Version 1	07.02.1992	Marc Conrad
	Version 2	02.11.1993	"MACRO" in 1. Zeile geschrieben, damit
					srctrans die Datei nicht uebersetzt.  PS
   DATE globbind      : 920331.931130.9606__
H*/



/*** globbind steht auf der Datei globinit.S. ***/
/***         Bitte dort nachsehen !!!         ***/
