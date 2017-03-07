/*M
.SH NAME
sgetr - string get rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat sgetr(ps)
char **ps;

.SH DESCRIPTION
sgetr()
returns the rational number read from the string *ps
in reduced representation,
or ERROR in case an error occurs.
On return, *ps points to the last character read.
M*/
/*H
	Version  1      16.06.1993    Marc Conrad
   DATE sgetr         : 931130
H*/


# include <_arith1.h>

rat sgetr ( pf )
char **pf;
{
	single c;
	rat R;
	int r1, r2;

	init(R,r1,r2);
   /***    Zaehler einlesen    ***/
	r1 = sgeti( pf );
	if ( r1 == ERROR )  {
		errmsgio( "sgetr", "EA006" );
		R = r1;
	}
	else if ( r1==0 )  R = 0;
	else {
   /***    Nenner erstellen    ***/
		if ( (c=sgetcb(pf)) == '/' )
   /***    Nenner einlesen    ***/
			if ( (r2=sgeti(pf)) == ERROR )  {
				errmsgio( "sgetr", "EA006" );
				R = r2;
			}
			else {
			    /***    Nenner = 0    ***/
				if ( !r2 ) {
					errmsgio( "sgetr", "EA010" );
					R = ERROR;
				}
				else  R = rcons( r1,r2 );
			}
		else {
   /***    Nenner eins    ***/
			unsgetc( c,pf );
			R = list2( r1,1 );
		}
	}
   /***    Ergebnis    ***/
	return( R );
}          





