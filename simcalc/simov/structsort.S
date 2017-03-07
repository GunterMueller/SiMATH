/*C

			structsort()

	"structure sort".
	structsort();
	structsort( );
	Der Variablenspeicher wird neu sortiert. Dabei werden die
	Variablennamen mit zugehoerigen Werten so angeordnet, dass
	sie in der in _calc.h deklarierten Struktur hintereinander stehen,
	d.h. dass zwischen zwei verwalteten Variablen keine leeren Elemente
	stehen.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H

	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  1.1    17.12.1990      U.Schneiders ( ecsch )
	Version  1.2    25.05.1992      U.Schneiders ( modsch, nfsch )
	Version  1.3    12.07.1993      U.Schneiders ( gfsch )

H*/
/*cS

	structsort ruft auf:  strcmp, strcpy

Sc*/

 
#include <_calc.h>

structsort()

{

	/*** Deklarationen und Vorbesetzungen ***/

	single n=1, m;

	/*** Umsortieren der Feldelemente ***/

	while ( n < MX ) {
		if ( !strcmp( varlist[n].varname, "\0" ) ) {
		  m = n+1;
		  while ( m < MX && !strcmp( varlist[m].varname, "\0" ) ) ++m;
		  if ( m < MX ) {
		      strcpy( varlist[n].varname, varlist[m].varname );
		      varlist[n].varwert = varlist[m].varwert;
		      varlist[n].typ = varlist[m].typ;	
		      strcpy( varlist[m].varname, "\0" );     
		      varlist[m].typ=0;
		      if( m == ecsch )  ecsch = n;	
		      else if( m == modsch )  modsch = n;	
		      else if( m == nfsch )  nfsch = n;	
		      else if( m == gfsch )  gfsch = n;
		      ++n;
		  }
		  else ++n;
		}
		else ++n;
	}
}
