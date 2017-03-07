/*M
.SH NAME
getc - get character (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single getc(pf)  
FILE *pf;
   
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
getc read the next character from *pf and returns iti. The `\\` character and the following one will be ignored. The input of '\\\\` enforces getc to read one '\\'. In case of an error or end of file getc returns EOF.
getc is identical to fgetc.

M*/
       
/*H
        Version 1       17.03.87        R. Boeffgen  
	Version 2       25.03.87        Sonderfaelle.   RB
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getc          : 890501.941201
H*/
/*
	For the definition of getc please refer to the header file _list.h.
*/
