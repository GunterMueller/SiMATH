/*M
.SH NAME
fgeti - file get integer

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgeti(pf)
FILE *pf;

.SH DESCRIPTION
fgeti() returns the integer read in from the file *pf,
or ERROR in case an error occurs.
M*/
/*H
	Version  1      04.03.1987      R.Boeffgen
	Version  2      02.06.1993	calling sequence.  MC
   DATE fgeti         : 890501.931130
H*/


# include <_arith1.h>

int fgeti ( pf )
FILE *pf;
{
	single  s=1, c=fgetcs( pf );
    /***    Signum    ***/
	if ( c=='+' || c=='-' )  {
		s = c=='+' ? 1 : -1;
		c = fgetcs( pf );
	}
    /***    Fehlermeldung    ***/
	if ( !isdigit(c) )  {
		errmsgio( "fgeti", "EA005" );
		return( ERROR );
	}
    /***    Null    ***/
	while ( c=='0' )  c = getc( pf );
	if ( !isdigit(c) )  {
		ungetc( c,pf );
		return( 0 );
	}
	else
    /***    nicht Null    ***/
	{
		single  a=0, b, i=0;
		int   A=0;
		list  L=_0;
    /***    Liste zur Basis DECBAS    ***/
		do {
			a = 10*a + c-'0';
			if ( ++i == BLOG10 )
				L = lcomp( a,L ),  a=i=0;
		}
		while ( isdigit( c=getc(pf) ) );
		ungetc( c,pf );
    /***    Basisumwandlung zu BASIS    ***/
		L = linv( L );
		bind( L );
		while ( L!=_0 )  {
			A = isprod( A,DECBAS );
			b = lfirst( L ),  L = lred( L );
			A = isum( A,b );
		}
		if ( A!=0 )  A = isprod( A, sexp(10,i) );
		A = isum( A,a );
		if (s < 0)  A = ineg( A );
    /***    Resultat    ***/
		return( A );
	}
}
