/*M
.SH NAME
fgetr - file get rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat fgetr(pf)
FILE *pf;

.SH DESCRIPTION
fgetr() returns the reduced rational number read from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      16.03.1987      R.Boeffgen
	Version  2      11.12.1989      Nenner = 0 abgefangen. PS
   DATE fgetr         : 890501.9107__
H*/


# include <_arith1.h>

rat fgetr ( pf )
FILE *pf;
{
	single c;
	rat R;
	int r1, r2;
   /***    Zaehler einlesen    ***/
	r1 = fgeti( pf );
	if ( r1 == ERROR )  {
		errmsgio( "fgetr", "EA006" );
		R = r1;
	}
	else if ( r1==0 )  R = 0;
	else {
   /***    Nenner erstellen    ***/
		bind( r1 );
		if ( (c=fgetcb(pf)) == '/' )
   /***    Nenner einlesen    ***/
			if ( (r2=fgeti(pf)) == ERROR )  {
				errmsgio( "fgetr", "EA006" );
				R = r2;
			}
			else {
			    /***    Nenner = 0    ***/
				if ( !r2 ) {
					errmsgio( "fgetr", "EA010" );
					R = ERROR;
				}
				else  R = rcons( r1,r2 );
			}
		else {
   /***    Nenner eins    ***/
			ungetc( c,pf );
			R = list2( r1,1 );
		}
	}
   /***    Ergebnis    ***/
	return( R );
}
