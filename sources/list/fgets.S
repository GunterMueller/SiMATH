/*M
.SH NAME
fgets - file get string (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

char *fgets( s,n,pf )  
char *s; 
single n; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B s
points to a character.
.TP 4
.B n
is an integer number, n < BASIS.
.TP 4
.B pf
points to the file *pf.
.PP
fgets reads the first n-1 character (or until end of line, end of file respectively) and writes them to s. The end of line will be replaced by `\\0`. The `\\` character and the following one will be ignored. The input of '\\\\` enforces gets to read one '\\'. fgets returns a pointer to the first character read. In case of an error occurs, fgets returns NILL.  

M*/
           
/*H
	Version 1       07.09.87        R. Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgets         : 890501.941201
H*/
/*
	For the definition of fgets please refer to the header file _list.h.
*/
