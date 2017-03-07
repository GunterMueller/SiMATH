/*M
.SH NAME
fgetlr - file get list of rational numbers

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgetlr(pf)
FILE *pf;

.SH DESCRIPTION
fgetlr() returns a list of reduced rational numbers read in from the file *pf,
or ERROR in case an error occurs.
M*/
/*H
	Version 1       24.11.1987      H. Stroeher
	Version 2	02.04.1992	"while (1)" -> "while (!llength(_0))".
					EA003 -> EA014.  PS
   DATE fgetlr        : 890501.9107__.920331
H*/


#include <_arith1.h>

list fgetlr( pf )
FILE *pf;
{
	list L;
	rat R;
	single c;
	init(L,R);
	
	L = _0;
	c = fgetcs(pf);
	if ( c != '(' ) goto ERR;
	c = fgetcs(pf);
	do {
		if ( c == ')' ) return( linv(L) );
		else {
			ungetc(c,pf);
			R = fgetr(pf);
			if ( R == ERROR ) goto ERR;
		}
		L = lcomp( R, L );
		if ( ( c = fgetcs(pf) ) == ',' )  c = fgetcs(pf);
	}
	while ( !llength(_0) );		/* Bei "while (1)" meldet der Com- */
					/* piler des MX300 eine Warnung.   */

	ERR: errmsgio( "fgetlr", "EA014" );
	return( ERROR );
}
