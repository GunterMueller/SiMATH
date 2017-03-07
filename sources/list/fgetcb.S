/*M
.SH NAME
fgetcb - file get character, skipping blanks

.SH SYNOPSIS
.nf
#include<_list.h>

single fgetcb( pf )  
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf. 
.PP
fgetcb reads a character from the file *pf and returns it. The `\\` character and the following one will be ignored. The input of '\\\\` enforces fgetcb to read one '\\'. In case of an error or end of file fgetcb returns EOF. 

M*/
             
/*H
	Version  1      24.02.1987      R.Boeffgen
	Version  2      19.03.1987      '\' beruecksichtigt.  RB
	Version  3      24.03.1987      Name geaendert   RB
	Version  4      09.07.1987      mit SIMATH-getc; ohne
					Fehlermeldung.   RB
   DATE fgetcb        : 890501
H*/


# include <_list.h>

single fgetcb( pf )
FILE *pf;
{
	single c;
	while  ( (c=getc(pf)) == ' ' );
	return( c );
}
