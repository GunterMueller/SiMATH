/*M
.SH NAME
getchar - get character (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single getchar()
     
.SH DESCRIPTION
getchar read a character from stdin and returns it. If the character `\\` occurs, it and the next character will be ignored. In case of an error or end of file, getchar returns EOF.

M*/
         
/*H
	Version 1       18.03.87        R. Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getchar       : 890501.941201
H*/
/*
	For the definition of getchar please refer to the header file _list.h.
*/
