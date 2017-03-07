/*M
.SH NAME
fgetcs - file get character, skipping space

.SH SYNOPSIS
.nf
#include<_list.h>

single fgetcs( pf )  
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf. 
.PP
fgetcs reads a character from from *pf and returns it. The following characters will be ignored: blanks, tabs, car-riage returns, line feeds and form feeds. The `\\` charac-ter and the following one will be ignored. The input of '\\\\` enforces fgetcs to read one '\\'. In case of an error or end of file fgetcs returns EOF.   

M*/
               
/*H
	Version  1      24.02.1987      R.Boeffgen
	Version  2      19.03.1987      '\' beruecksichtigt.  RB
	Version  3      24.03.1987      Name geaendert.   RB
	Version  4      09.07.1987      mit xfgetc; ohne Fehlermeld. RB
   DATE fgetcs        : 890501
H*/


# include <_list.h>

single fgetcs ( pf )
FILE *pf;
{
	single c;
	while  ( isspace( c=getc(pf) ) );
	return( c );
}
