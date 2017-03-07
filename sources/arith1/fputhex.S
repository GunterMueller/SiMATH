/*M
.SH NAME
fputhex - put hexadecimal notation

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputhex(N,pf)
int  N;
FILE *pf;


.SH DESCRIPTION
fputhex() writes the hexadecimal notation of the integer N
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/

/*H
	Version  1      16.02.1996      S.Schmitt
   DATE fputhex	      : 960501
H*/

# include <_arith1.h>

single fputhex ( N, pf )
int N;
FILE *pf;
{
	single i,k,a,z;
	bind(N);

   /***    erstes Leerzeichen kontrolliert ausgeben    ***/

	if ( fputc(' ',pf) == EOF )  {
		errmsgio( "fputhex", "EA116" );
		return( ERROR );
	}

  /***   Ausgabe   ***/

	if(!N)
	{	putc('0',pf);
		return(0);
	}
	k=0;
	if(isatom(N))
	{	i=28;
		while(i>=0)
		{	if ( a=((N>>i)&(15)) )  
			{	k=1;
				switch(a)
				{	case 10: fputc('A',pf);
						 break;
					case 11: fputc('B',pf);
						 break;
					case 12: fputc('C',pf);
						 break;
					case 13: fputc('D',pf);
						 break;
					case 14: fputc('E',pf);
						 break;
					case 15: fputc('F',pf);
						 break;
					default: fputsi(a,pf);
						 break;
				}
			}
			else if(k) fputc( '0', pf );
			i=i-4;
		}
	}
	else
	{	list L;
		int n,m;
		init(L,n,m);
		L=lcopy(N);
		L=linv(L);
		i=llength(L);
		z=(-1)+2*(mshom(2,i)); 	/** z=-1, falls i gerade ist 
					    z=+1, falls i ungerade ist **/		
		while(L!=_0)
		{	n=lfirst(L);
			L=lred(L);
			if(z<0) i=26;
			else i=28-(k*4);
			z=z*(-1);
			while(i>=0)
			{	if ( a=((n>>i)&(15)) )  
				{	k=1;
					switch(a)
					{	case 10: fputc('A',pf);
						 	 break;
						case 11: fputc('B',pf);
						 	 break;
						case 12: fputc('C',pf);
						 	 break;
						case 13: fputc('D',pf);
						 	 break;
						case 14: fputc('E',pf);
						 	 break;
						case 15: fputc('F',pf);
						 	 break;
						default: fputsi(a,pf);
						 	 break;
					}
				}
				else if(k) fputc( '0', pf );
				i=i-4;
			}
			if(i==(-2))
			{	m=lfirst(L);
				if(a=((n&3)<<2)|((m>>28)&3))
				{	k=1;
					switch(a)
					{	case 10: fputc('A',pf);
						 	 break;
						case 11: fputc('B',pf);
						 	 break;
						case 12: fputc('C',pf);
						 	 break;
						case 13: fputc('D',pf);
						 	 break;
						case 14: fputc('E',pf);
						 	 break;
						case 15: fputc('F',pf);
						 	 break;
						default: fputsi(a,pf);
						 	 break;
					}
				}
				else if(k) fputc( '0', pf );
			}
		}
	}
	return( 0 );
}
