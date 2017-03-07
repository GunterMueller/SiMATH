/*M
.SH NAME
unsgetc - undo string get character

.SH SYNOPSIS
.nf
#include<_list.h>
 
single unsgetc( c, ps )  
char c; 
char **ps;
 
.SH DESCRIPTION
If c == *(*ps - 1), unsgetc decreases *pl by 1 and returns 1, else unsgetc returns ERROR.

M*/

/*H
	Version 1	15.06.1993	Marc Conrad
   DATE unsgetc       : 931130
H*/

#include<_list.h>

int unsgetc( c, ps )

char c; 
char **ps; 
{ 
	
	(*ps)--; 
	if (**ps != c ) {          
		errmsgio( "unsgetc", "EA320" );
		return( ERROR );
		}
	
	return( 1 ); 
}
