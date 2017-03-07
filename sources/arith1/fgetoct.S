/*M
.SH NAME
fgetoct - file get octal notation

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgetoct(pf)
FILE *pf;

.SH DESCRIPTION
fgetoct() returns the integer read in octal notation from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      16.02.1996      S.Schmitt
   DATE fgetoct	      : 960501
H*/

# include <_arith1.h>

int fgetoct ( pf )
FILE *pf;
{
	single  c=fgetcs(pf);

	if ( !isdigit(c) || (c-'0') > 7 ) 
	{	errmsgio( "fgetoct", "EA016" );
		return( ERROR );
	}

        /***    Null    ***/

	while ( c=='0' )  c = getc( pf );
	if ( !isdigit(c) )  
	{	ungetc( c,pf );
		return( 0 );
	}

	else

        /***    nicht Null    ***/

	{
		single  m, n=0, i=0;
		int N;
		list  L;
		init(N,L);
		L = _0; N = 0;

	/*** Immer einen 'Packen' zusammenzaehlen (so dass es single
		Zahl bleibt) und spaeter insgesamt berechnen. 	  ***/

		do 
		{	if( (c-'0') > 7 )
			{	errmsgio( "fgetoct", "EA016" );
				return( ERROR );
			}
			n = 8*n + c-'0';
			if( ++i == 10 ) L = lcomp( n,L ),  n=i=0;
		} while ( isdigit( c=getc(pf) ) );

		ungetc( c,pf );
		L = linv(L);
		while ( L!=_0 )  
                {       N = ip2prod( N,BLOG2 );
                        m = lfirst( L ),  L = lred( L );
                        N = isum( N,m );
                }
                if ( N!=0 )  N = ip2prod( N, (3*i) );
                N = isum( N,n );

		return( N );
	}
}
