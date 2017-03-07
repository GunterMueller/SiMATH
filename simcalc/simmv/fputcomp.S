/*C
		    fputcomp( a, n, pf )

	"file put complex number"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _arith1.h 
	single fputcomp( a, n, pf )  complex a; single n; FILE *pf;
	s = fputcomp( a, n, pf );
	pf ist ein Zeiger auf eine zum Schreiben geoeffnete Datei.
        a ist eine komplexe Zahl.
	Sei Re(a)=x und Im(a)=y, also a = x+y*i (x,y reell).
        fputcomp schreibt a in der Form "x + y*i" auf die Datei *pf. 
	x und y werden dabei mit --> fputfl ausgegeben, wobei n die 
	Anzahl der Nachkommastellen angibt. 
	Falls x = 0 oder y = 0, so wird "x + " bzw. " + y*i" nicht 
	ausgegeben. Falls y = +/- 1, so wird nur "i" bzw. "-i" 
	ausgegeben. 
	Rueckgabe: 0 bei Erfolg, ERROR sonst.
C*/
/*H
	Version 1       22.12.1993      S.Schmitt/U.Schneiders 
H*/

#include<_arith1.h>

single fputcomp( a, n, pf ) 
complex a;
single n;
FILE *pf;
{
    bind( a );

    if( a )
    {
        floating re, im;
	single s, na;
    
        init( re, im );
    
        re = lfirst ( a );
        im = lsecond( a );
	s = flsign( im );
    
	if( re )
	{
	    na = lfirst( re );
	    if( na >= 0 )
	    {      re = lred( re );
	           while( na-- )  re = lcomp( 0,re );
		   if( llength( re ) == 1 ) re = lfirst( re );
		   if( fputi( re, pf ) == ERROR ) return(ERROR);
	    }
	    else if( fputfl( re, n, pf ) == ERROR ) return(ERROR);
	    if(s)
	    {	if( fputc( ' ', pf ) == ERROR )
	    	{
		   return( ERROR );
	    	}
	    }
	    if( s > 0 )
	    {
                if( fputc( '+', pf ) == ERROR 
		   || fputc( ' ', pf ) == ERROR )
		{
		    return( ERROR );
		}
            }
	}
	if( !s )
	{
            return( 0 );
	}
        if( s < 0 )
	{
            if( fputc( '-', pf ) == ERROR 
		|| ( re && fputc( ' ', pf ) == ERROR ) )
	    {
		return( ERROR );
	    }
	}
	im = flabs( im );
	if( flcomp( im, itofl( 1 ) ) )
	{
	    na = lfirst( im );
	    if( na >= 0 )
	    {      im = lred( im );
	           while( na-- )  im = lcomp( 0,im );
		   if( llength( im ) == 1 ) im = lfirst( im );
		   if( fputi( im, pf ) == ERROR ) return(ERROR);
	    }
	    else if( fputfl( im, n, pf ) == ERROR ) return(ERROR);
           /*** if( ( fputc( ' ', pf ) == ERROR ) 
	    ||  ( fputc( '*', pf ) == ERROR )
	    ||  ( fputc( ' ', pf ) == ERROR ) ) ***/
            if( fputc( '*', pf ) == ERROR ) 
	    {
		return( ERROR );
	    }
        }
        if( fputc( 'i', pf ) == ERROR )
	{
	    return( ERROR );
	}
    }
    else if( fputc( '0', pf ) == ERROR )
    {
	return( ERROR );
    }
    return( 0 );
}
