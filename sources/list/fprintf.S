/*M
.SH NAME
fprintf - file print formated (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>
 
single fprintf( pf, format [,arg]... )  
FILE *pf; 
char *format;
 
.SH DESCRIPTION
At most, 26 arguments (without the format-string) are allowed.
fprintf writes the arguments to the file *pf (according to the directions given in format). fprintf returns 0 by success and a negative number else.
For the format string, please see printf.

.SH SEE ALSO
printf

M*/

/*H
	Version 1       04.03.1987      R. Boeffgen
	Version 2       28.03.1991      Doku wegen floats geaendert.  MC
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE fprintf       : 890501.910715.941201
H*/
/*
	For the definition of fprintf please refer to the header file _list.h.
*/
