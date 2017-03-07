/*C
			calc_putoct( N )

	"calculator integer put octal representation".
	list calc_putoct(N); int N;
	erg = calc_putoct( N );

	N ist eine ganze Zahl. Die Oktal-Darstellung von N
	wird ausgegeben.
	Laeuft calc_putoct fehlerhaft ab, so ist erg = ERROR,
	sonst ist erg=N.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1	20.02.1996	S.Schmitt
H*/
 
#include <_calc.h>

int calc_putoct( N )
int N;
{	single k,i,a;
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
        if( ps ) fprintf( datei, "out: " );
	if(isatom(N))
	{	i=27;
		while(i>=0)
		{	if ( a=((N>>i)&7) )  
			{	k=1;
				puti(a);
				if(ps) fputi(a, datei);
			}
			else if(k) 
			{	putc( '0',stdout );
                		if( ps ) fprintf( datei, "0" );
			}
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
					puti( a );
					if(ps) fputi(a, datei);
				}
				else if(k) 
				{	putc( '0',stdout );
                			if( ps ) fprintf( datei, "0" );
				}
				i=i-3;
			}
		}
	}

	printf("\n\n");
        if( ps ) fprintf( datei, "\n\n" );
	return(list2(N,0));
}

