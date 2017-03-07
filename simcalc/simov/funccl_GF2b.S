/*C
			funccl_GF2b( arg, d );

	"function calling of GF2bit".
	list funccl_GF2b(arg,d); char *arg; single *d;
	wert = funccl_GF2b( arg, d );
	Der zu GF2bit gehoerige Eingabestring wird bestimmt und 
        ausgewertet. Die Laenge des ausgewerteten Strings wird *d 
        zugewiesen.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      24.10.1995      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list funccl_GF2b ( arg, d )
char *arg;
int *d;

{       /*** Deklarationen und Vorbesetzungen ***/

	char arg2[MAXL];
	single e, j, z, n, m, i;
	int N;	
	list L;
	init( N, L );

	/*** Erkennung des auszuwertenden Strings und Uebergabe
	     an Kellerverwaltung ( basad ) ***/

	arg += 1;
	brackex ( arg, arg2 );
	*d = strlen( arg2 )+1;

	j = 0;
	e = strlen(arg2)-1;
	if(arg2[j]=='(')
	{	while(arg2[j]=='(')
		{	if( arg2[e]!=')')
			{	mistake(2);
	 			return( -BASIS );
			}
			j++; e--;
		}
	}

	while( arg2[j] == '0' && j<=e ) j++;
	if( j>e )  
	{
		return(0);
	}

	z = 0; n = 0; i = 0; L = _0; N = 0;
	do
	{       if( arg2[j] != '0' && arg2[j] != '1' )
		{	mistake(15);
	 		return( -BASIS );
		}
		n = 2*n + arg2[j] - '0';
		if( ++i == BLOG2 )  L = lcomp(n,L), n=i=0;
		z++;
		j++;
	}  while( j<=e );

	L = linv(L);
	while ( L!=_0 )  
        {       N = ip2prod( N,BLOG2 );
                m = lfirst( L ),  L = lred( L );
                N = isum( N,m );
        }
        if ( N!=0 )  N = ip2prod( N, i );
        N = isum( N,n );

	z--;
	if( isatom(N) )  L = list2( z, N);
	else		 N = linv(N), L = lcomp( z, N);
	return( L );
}
