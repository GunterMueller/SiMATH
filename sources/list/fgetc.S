/*M
.SH NAME
fgetc - file get character (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single fgetc(pf)  
FILE *pf;         

.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf. 
.PP
fgetc read the next character from *pf and returns it. The `\\` character and the following one will be ignored. The input of '\\\\` enforces fgetc to read one '\\'. In case of an error or end of file getc returns EOF. fgetc is identi-cal to getc. 

M*/
      
/*H
	Version 1       17.03.87        R. Boeffgen
	Version 2       25.03.87        Sonderfaelle.   RB
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fgetc         : 890501.941201
H*/
/*
	For the definition of fgetc please refer to the header file _list.h.
*/
