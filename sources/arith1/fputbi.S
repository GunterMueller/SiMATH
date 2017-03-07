/*M
.SH NAME
fputbi - put bits

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputbi(N,pf)
int  N;
FILE *pf;


.SH DESCRIPTION
fputbi() writes the bitwise notation of the integer N
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version  1      16.02.1996      S.Schmitt
   DATE fputbi        : 960501
H*/

# include <_arith1.h>

single fputbi ( N, pf )
int N;
FILE *pf;
{
	single i,k;
	bind(N);


   /***    erstes Leerzeichen kontrolliert ausgeben    ***/

	if ( fputc(' ',pf) == EOF )  {
		errmsgio( "fputbi", "EA114" );
		return( ERROR );
	}

  /***   Ausgabe   ***/

	if(!N)
	{	fputc( '0', pf);
		return(0);
	}
	k=0;
	if(isatom(N))
	{	i=30;
		while(i--)
		{	if ( (N>>i)&1 )  
			{	k=1;
				fputc( '1', pf );
			}
			else if(k) fputc( '0', pf );
		}
	}
	else
	{	list L;
		int n;
		init(L,n);
		L=lcopy(N);
		L=linv(L);
		while(L!=_0)
		{	n=lfirst(L);
			L=lred(L);
			i=30;
			while(i--)
			{	if ( (n>>i)&1 )  
				{	k=1;
					fputc( '1', pf );
				}
				else  if(k) fputc( '0', pf );
			}
		}
	}
	return( 0 );
}
