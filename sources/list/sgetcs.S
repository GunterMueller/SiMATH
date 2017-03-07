/*M
.SH NAME
sgetcs - string get character, skipping space
 
.SH SYNOPSIS
.nf
#include<_list.h>

single sgetcs( ps )  
char **ps;
   
.SH DESCRIPTION
sgetcs reads a character (no space s. getcs) from the string *ps and returns it. After that, *p points to the character behind the last character read. In case of an error, sgetcs returns ERROR.
 
M*/
         
/*H
	Version  1      15.06.1993	Marc Conrad
   DATE sgetcs        : 931130
H*/

# include <_list.h>

single sgetcs ( pf )
char **pf;
{
	single c;
	while  ( isspace( c=sgetc(pf) ) );
	return( c );
}
