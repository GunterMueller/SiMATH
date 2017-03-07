/*M
.SH NAME
fputbits - file put bits

.SH SYNOPSIS
.nf
#include<_list.h>

single fputbits(s, pf)  
unsigned s; 
FILE *pf;
    
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.   
.PP
fputbits writes s bit by bit to the file *pf and returns 0 by success and ERROR else.   

M*/
   
/*H
	Version 1       23.02.87        R.Boeffgen
   DATE fputbits      : 890501
H*/


# include <_list.h>

single fputbits ( s, pf )
unsigned s;
FILE *pf;
{
	register short i = 32;
   /***    erstes Leerzeichen kontrolliert ausgeben    ***/
	if ( fputc(' ',pf) == EOF )  {
		errmsgio( "fputbits", "EA104" );
		return( ERROR );
	}
   /***    bits byteweise ausgeben    ***/
	while ( i-- )  {
		if ( (s>>i)&1 )  fputc( '1', pf );
		else  fputc( '0', pf );
		if ( ! (i%8)  &&  fputc(' ',pf) == EOF )  {
			errmsgio( "fputbits", "EA104" );
			return( ERROR );
		}
	}
	return( 0 );
}
