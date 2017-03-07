/*M
.SH NAME
fputlpi - file put list of polynomials over integers

.SH SYNOPSIS
.nf
#include<_pol1.h>

single fputlpi(r, L, V, pf) 
single r; 
list L; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                       
.B L
is a list of polynomials in r variables over the integer numbers.
.TP 4                                                                           
.B V                                                                            
is a list of variables names.                     
.TP 4                                                                           
.B pf                                                                           
is a pointer to an output file.                                                 
.PP                          
fputlpi writes the list L to the file *pf, according to the rules descripted in fputpi.
.PP
fputlpi returns                                                                  
 0      by success,                                                             
 ERROR  else.    
 
.SH SEE ALSO

fputpi

M*/

/*H
	Version 1       14.06.1988      Klaus Petry     ( gemaess fputli )
   DATE fputlpi       : 890501
H*/


# include <_pol1.h>

single fputlpi( r, L ,V , pf )
single r;
list L;
list V;
FILE *pf;

{
   /***    Oeffnende Klammer kontrolliert ausgeben    ***/
	if ( fputc('(',pf) == EOF )  {
		errmsgio( "fputlpi", "EA104" );
		return( ERROR );
	}
   /***    Objekte der Liste ausgeben    ***/
	bind( L, V );
	while ( L!=_0 )  {
		fputc(' ', pf );
		if (fputpi( r, lfirst(L), V, pf ) == ERROR ) {
			/* Fehlermeldung schon in fputpi */
			return(ERROR);
			}
		fputc(' ', pf );
		L = lred( L );
	}
   /***    Schliessende Klammer kontrolliert ausgeben    ***/
	if ( fputc(')',pf) == EOF )  {
		errmsgio( "fputlpi", "EA104" );
		return( ERROR );
	}
	return( 0 );
}
