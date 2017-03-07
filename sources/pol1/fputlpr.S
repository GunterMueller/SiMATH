/*M
.SH NAME
fputlpr - file put list of polynomials over rationals

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputlpr(r, L, V, pf) 
single r; 
list L, V; 
FILE *pf;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B L                                                                            
is a list of polynomials in r variables over the rational numbers.              
.TP 4                                                                           
.B V                                                                            
is a list of variables names.                                                   
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                                                                             
fputlpr writes the list L to the file *pf, according to the rules descripted in 
fputpr.                                                                         
.PP                                                                             
fputlpr returns                                                                 
                                                                                
 0      by success,                                                             
 ERROR  else.                                                                   
                                            
.SH SEE ALSO
fputpr

M*/

/*H
	Version 1       28.07.1988      Klaus Petry     ( gemaess fputli )
   DATE fputlpr       : 890501
H*/


# include <_pol1.h>

single fputlpr ( r, L ,V , pf )
single r;
list L;
list V;
FILE *pf;

{
   /***    Oeffnende Klammer kontrolliert ausgeben    ***/
	if ( fputc('(',pf) == EOF )  {
		errmsgio( "fputlpr", "EA104" );
		return( ERROR );
	}
   /***    Objekte der Liste ausgeben    ***/
	bind( L, V );
	while ( L!=_0 )  {
		fputc(' ', pf );
		if (fputpr( r, lfirst(L), V, pf ) == ERROR ) {
			/* Fehlermeldung schon in fputpr */
			return(ERROR);
			}
		fputc(' ', pf );
		L = lred( L );
	}
   /***    Schliessende Klammer kontrolliert ausgeben    ***/
	if ( fputc(')',pf) == EOF )  {
		errmsgio( "fputlpr", "EA104" );
		return( ERROR );
	}
	return( 0 );
}
