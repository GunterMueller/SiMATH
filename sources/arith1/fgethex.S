/*M
.SH NAME
fgethex - file get hexadecimal notation

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgethex(pf)
FILE *pf;

.SH DESCRIPTION
fgethex() returns the integer read in hexadecimal notation from the file *pf,
or ERROR in case an error occurs.
M*/

/*H
	Version  1      16.02.1996      S.Schmitt
   DATE fgethex       : 960501
H*/

# include <_arith1.h>

int fgethex ( pf )
FILE *pf;
{
	single  c=fgetcs(pf);

	if ( !isalnum(c) || ((c-'0')>9 && ((c-'A')<0 || (c-'A')>6))) 
	{	errmsgio( "fgethex", "EA017" );
		return( ERROR );
	}

        /***    Null    ***/

	while ( c=='0' )  c = getc( pf );
	if ( !isalnum(c) )  
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
		{	if ((c-'0')>9 && ((c-'A')<0 || (c-'A')>6)) 
			{	errmsgio( "fgethex", "EA017" );
				return( ERROR );
			}
			if((c-'0')<=9) n = 16*n + c-'0';
			else	n=16*n + 10 + c-'A';
			i=i+4;
			if(i==28) L = lcomp( n,L ),  n=i=0;
		} while ( isalnum( c=getc(pf) ) );

		ungetc( c,pf );
		L = linv(L);
		while ( L!=_0 )  
                {       N = ip2prod( N,28 );
                        m = lfirst( L ),  L = lred( L );
                        N = isum( N,m );
                }
                if ( N!=0 )  N = ip2prod( N, i );
                N = isum( N,n );

		return( N );
	}
}
