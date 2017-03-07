/*M
.SH NAME 

fgetbits - file get bits

.SH SYNOPSIS
.nf
#include<_arith1.h>

int fgetbits(pf)
FILE *pf;

.SH DESCRIPTION
fgetbits() returns the integer value read in bitwise notation from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      24.10.1995      S.Schmitt/U.Schneiders
   DATE fgetbits      : 951201
H*/

# include <_arith1.h>

int fgetbits ( pf )
FILE *pf;
{
	single  c=fgetcs(pf);

	if ( !isdigit(c) || (c-'0') > 1 ) 
	{	errmsgio( "fgetbits", "EA015" );
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
		do 
		{	if( (c-'0') > 1 )
			{	errmsgio( "fgetbits", "EA015" );
				return( ERROR );
			}
			n = 2*n + c-'0';
			if( ++i == BLOG2 ) L = lcomp( n,L ),  n=i=0;
		} while ( isdigit( c=getc(pf) ) );

		ungetc( c,pf );
		L = linv(L);
		while ( L!=_0 )  
                {       N = ip2prod( N,BLOG2 );
                        m = lfirst( L ),  L = lred( L );
                        N = isum( N,m );
                }
                if ( N!=0 )  N = ip2prod( N, i );
                N = isum( N,n );

		return( N );
	}
}
