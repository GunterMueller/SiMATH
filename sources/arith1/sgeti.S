/*M
.SH NAME
sgeti - string get integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

int sgeti(ps)
char **ps;

.SH DESCRIPTION
sgeti()
returns the integer value read from the string *ps,
or ERROR in case an error occurs.
On return, *ps points to the last character read.
M*/

/*H
	Version  1      14.06.1993	Marc Conrad
   DATE sgeti         : 931130
H*/


# include <_arith1.h>

int sgeti ( pf )
char **pf;
{
	single  s=1;
	char c;
	c = sgetcs( pf );
    /***    Signum    ***/
	if ( c=='+' || c=='-' )  {
		s = c=='+' ? 1 : -1;
		c = sgetcs( pf );
	}
    /***    Fehlermeldung    ***/
	if ( !isdigit(c) )  {
		errmsgio( "sgeti", "EA005" );
		return( ERROR );
	}
    /***    Null    ***/
	while ( c=='0' )  c = sgetc( pf );
	if ( !isdigit(c) )  {
		unsgetc( c,pf );
		return( 0 );
	}
	else
    /***    nicht Null    ***/
	{
		single  a=0, b, i=0;
		int   A=0;
		list  L=_0;
		bind(A,L);
    /***    Liste zur Basis DECBAS    ***/
		do {
			a = 10*a + c-'0';
			if ( ++i == BLOG10 )
				L = lcomp( a,L ),  a=i=0;
		}
		while ( isdigit( c=sgetc(pf) ) );
		unsgetc( c,pf );
    /***    Basisumwandlung zu BASIS    ***/
		L = linv( L );
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
                   
	




