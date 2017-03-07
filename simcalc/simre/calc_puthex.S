/*C
			calc_puthex( N )

	"calculator integer put hexadecimal representation".
	list calc_puthex(N); int N;
	erg = calc_puthex( N );

	N ist eine ganze Zahl. Die Hexadezimal-Darstellung von N
	wird ausgegeben.
	Laeuft calc_puthex fehlerhaft ab, so ist erg = ERROR,
	sonst ist erg=N.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1	20.02.1996	S.Schmitt
H*/
 
#include <_calc.h>

int calc_puthex( N )
int N;
{	single k,i,a,z;
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
        if( ps ) fprintf( datei, "out:" );
	if(isatom(N))
	{	i=28;
		while(i>=0)
		{	if ( a=((N>>i)&(15)) )  
			{	k=1;
				switch(a)
				{	case 10: putc('A',stdout);
						 if(ps) fprintf(datei, "A");
						 break;
					case 11: putc('B',stdout);
						 if(ps) fprintf(datei, "B");
						 break;
					case 12: putc('C',stdout);
						 if(ps) fprintf(datei, "C");
						 break;
					case 13: putc('D',stdout);
						 if(ps) fprintf(datei, "D");
						 break;
					case 14: putc('E',stdout);
						 if(ps) fprintf(datei, "E");
						 break;
					case 15: putc('F',stdout);
						 if(ps) fprintf(datei, "F");
						 break;
					default: puti(a);
						 if(ps) fputi(a, datei);
						 break;
				}
			}
			else if(k) 
			{	putc( '0',stdout );
				if(ps) fprintf(datei, "0");
			}
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
			z=(-z);
			while(i>=0)
			{	if ( a=((n>>i)&(15)) )  
				{	k=1;
					switch(a)
					{   case 10: putc('A',stdout);
					 	     if(ps) fprintf(datei, "A");
					 	     break;
					    case 11: putc('B',stdout);
						     if(ps) fprintf(datei, "B");
						     break;
					    case 12: putc('C',stdout);
						     if(ps) fprintf(datei, "C");
						     break;
					    case 13: putc('D',stdout);
						     if(ps) fprintf(datei, "D");
						     break;
					    case 14: putc('E',stdout);
						     if(ps) fprintf(datei, "E");
						     break;
					    case 15: putc('F',stdout);
						     if(ps) fprintf(datei, "F");
						     break;
					    default: puti(a);
						     if(ps) fputi(a, datei);
						     break;
					}
				}
				else if(k) 
				{	putc( '0',stdout );
					if(ps) fprintf(datei, "0");
				}
				i=i-4;
			}
			if(i==(-2))
			{	m=lfirst(L);
				if(a=((n&3)<<2)|((m>>28)&3))
				{	k=1;
					switch(a)
					{   case 10: putc('A',stdout);
						     if(ps) fprintf(datei, "A");
					 	     break;
					    case 11: putc('B',stdout);
						     if(ps) fprintf(datei, "B");
					 	     break;
					    case 12: putc('C',stdout);
						     if(ps) fprintf(datei, "C");
					 	     break;
					    case 13: putc('D',stdout);
						     if(ps) fprintf(datei, "D");
					 	     break;
					    case 14: putc('E',stdout);
						     if(ps) fprintf(datei, "E");
					 	     break;
					    case 15: putc('F',stdout);
						     if(ps) fprintf(datei, "F");
					 	     break;
					    default: puti(a);
						     if(ps) fputi(a, datei);
					 	     break;
					}
				}
				else if(k) 
				{	putc( '0',stdout );
					if(ps) fprintf(datei, "0");
				}
			}
		}
	}
	printf("\n\n");
	if(ps) fprintf(datei, "\n\n");
	return(list2(N,0));
}

