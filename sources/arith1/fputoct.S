/*M
.SH NAME
fputoct - put octal notation

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputoct(N,pf)
int  N;
FILE *pf;


.SH DESCRIPTION
fputoct() writes the octal notation of the integer N
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version  1      16.02.1996      S.Schmitt
   DATE fputoct	      : 960501
H*/

# include <_arith1.h>

single fputoct ( N, pf )
int N;
FILE *pf;
{
	single i,k,a;
	bind(N);

   /***    erstes Leerzeichen kontrolliert ausgeben    ***/

	if ( fputc(' ',pf) == EOF )  {
		errmsgio( "fputoct", "EA115" );
		return( ERROR );
	}

  /***   Ausgabe   ***/

	if(!N) 
	{	fputc('0',pf);
		return(0);
	}
	k=0;
	if(isatom(N))
	{	i=27;
		while(i>=0)
		{	if ( a=((N>>i)&7) )  
			{	k=1;
				fputsi(a,pf);
			}
			else if(k) fputc('0',pf);
			i=i-3;
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
			i=27;
			while(i>=0)
			{	if ( a=((n>>i)&7) )  
				{	k=1;
					fputsi(a,pf);
				}
				else  if(k) fputc( '0', pf );
				i=i-3;
			}
		}
	}
	return( 0 );
}
