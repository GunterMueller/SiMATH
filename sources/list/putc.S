/*M
.SH NAME
putc  - put character (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single putc(c,pf)  
char c; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B c
is a character.
.TP 4
.B pf
points to the file *pf.
.PP
putc writes c to the file *pf and returns c by success and EOF else.
putc is identical to fputc.

M*/
             
/*H
	Version 1       24.02.1987      R. Boeffgen
	Version 2       18.03.1987      Parameter pf eingefuehrt gemaess
					C-Version von putc().   RB
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE putc          : 890501.941201
H*/
/*
	For the definition of putc please refer to the header file _list.h.
*/
