/*M
.SH NAME
ftab - file tabulator

.SH SYNOPSIS
.nf
#include<_list.h>
 
single ftab(n, pf)  
single n; 
FILE *pf;
 
.SH DESCRIPTION
For MARGIN < n <= LN-SIZE,ftab fills the actual line of the file *pf  with blank up to the n-th column, else ftab has no effect. ftab returns 0 by success and ERROR else.
     
M*/

/*H
	Version 1       23.02.1987      R.Boeffgen
	Version 2       30.03.1987      getocnt eingebaut. MAR.
	version 3       01.04.1987      Kommentar verbessert.
					Anzahl der einzurueckenden
					Spalten korrekt bestimmt. MAR.
   DATE ftab          : 890501
H*/


# include <_list.h>

single ftab ( n , pf )
single n;
FILE *pf;
{
	single s;
	if ( MARGIN < n  &&  n <= LN_SIZE )  {
   /***    Anzahl der noch einzurueckenden Spalten    ***/
		s = getocnt(pf);
		if ( s > MARGIN ) n = n - s;
		else n = n - MARGIN;
   /***    einruecken    ***/
		while ( n-- > 0 )
			if ( fputc(' ',pf) == EOF )  {
				errmsgio( "ftab", "EA104" );
				return( ERROR );
			}
	}
	return( 0 );
}
