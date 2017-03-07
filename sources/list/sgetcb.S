/*M
.SH NAME
sgetcb - string get character, skipping blanks

.SH SYNOPSIS
.nf
#include<_list.h>

single sgetcb( ps )  
char **ps;
 
.SH DESCRIPTION
sgetcb reads a character (no blanks), from the string *ps and returns it. After that, *p points to the character behind the last character read. In case of an error, sgetcb returns ERROR.

M*/
     
/*H
	Version 1	15.06.1993	Marc Conrad
   DATE sgetcb        : 931130
H*/


# include <_list.h>

single sgetcb( ps )
char **ps;
{
	single c;
	while  ( (c = sgetc( ps )) == ' ' );
	return( c );
}
