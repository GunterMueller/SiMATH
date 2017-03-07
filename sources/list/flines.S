/*M
.SH NAME
flines - file lines

.SH SYNOPSIS
.nf
#include<_list.h>

single flines(k, pf)  
single k; 
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B k
is an integer number, k < BASIS.  
.TP 4
.B pf
points to the file *pf.   
.PP
flines writes k linefeeds to the file *pf, and returns 0 by success, and ERROR else.

M*/
        
/*H
	Version 1       23.11.1986      R. Boeffgen
	Version 2       21.04.1987      neu konzipiert.  RB      
	Version 3       11.11.1994      neu wg. Linux, include _list.h.
					rausgeworfen und durch include stdio 
					ersetzt, Marc Conrad.
   DATE flines        : 890501.941201
H*/


# include <stdio.h>     
#define  ERROR  (-(1<<30))
#define single  int

single flines ( k,pf )
single k;
FILE *pf;
{
	if ( k > 0 )  {
   /***    Zeilenvorschuebe    ***/
		while ( --k )  putc('\n',pf);
   /***    letzter Zeilenvorschub kontrolliert ausgeben    ***/
		if ( xfputc('\n',pf) == EOF )  {
			errmsgio( "flines", "EA101" );
			return( ERROR );
		}
	}
	return( 0 );
}
