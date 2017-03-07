/*M
.SH NAME
gets - get string (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

char *gets( s )  
char *s;
 
.SH DESCRIPTION
gets reads characters from stdin until end of line, and writes them to s. The end of line will be replaced by `\\0`.
The `\\` character and the following one will be ignored. The input of '\\\\` enforces gets to read one '\\'.
gets returns a pointer to the first character read. In case of an error occurs, gets returns NILL.
 
M*/
       
/*H
	Version 1       07.09.87        R. Boeffgen
	Version 2       08.10.1987      Programm korrigiert. MAR.
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE gets          : 890501.941201
H*/
/*
	For the definition of gets please refer to the header file _list.h.
*/
