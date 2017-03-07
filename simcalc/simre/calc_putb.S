/*C
			calc_putb( N )

	"calculator integer put bit representation".
	list calc_putb(N); int N;
	erg = calc_putb( N );

	N ist eine ganze Zahl. Die Bit-Darstellung von N
	wird ausgegeben.
	Laeuft calc_putb fehlerhaft ab, so ist erg = ERROR,
	sonst ist erg=N.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1	20.02.1996	S.Schmitt
H*/
 
#include <_calc.h>

int calc_putb( N )
int N;
{	single k,i;
	bind(N);

	if(lsecond(N))
	{	mistake(309);
		return(ERROR);
	}
	if(assch) return(N);

	N=lfirst(N);

	if(!N)
	{	printf("0\n\n");
        	if( ps ) fprintf( datei, "out: 0\n\n" );
		return(list2(0,0));
	}
	k=0;
	if( ps ) fprintf( datei, "out: ");
	if(isatom(N))
	{	i=30;
		while(i--)
		{	if ( (N>>i)&1 )  
			{	k=1;
				putc( '1',stdout );
				if( ps ) fprintf( datei, "1");
			}
			else if(k)
			{	putc( '0',stdout );
				if( ps ) fprintf( datei, "0");
			}
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
					putc( '1',stdout );
					if( ps ) fprintf( datei, "1");
				}
				else if(k)
				{	putc( '0',stdout );
					if( ps ) fprintf( datei, "0");
				}
			}
		}
	}
	printf("\n\n");
	if( ps ) fprintf( datei, "\n\n");
	return(list2(N,0));
}

