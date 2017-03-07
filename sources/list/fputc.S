/*M
.SH NAME
fputc - file put character (MACRO) 

.SH SYNOPSIS
.nf
#include<_list.h>

single fputc(c, pf)  
char c; 
FILE *pf;
      
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.  
.PP
fputc writes the character c to the file *pf and returns 0 by success and EOF else.
fputc is identical to putc.

M*/
        
/*H
	Version 1       24.02.1987      R. Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputc         : 890501.941201
H*/
/*
	For the definition of fputc please refer to the header file _list.h.
*/
