/*C
			ireads( str )

	"integer read from string".
	int ireads(str); char *str;
	A = ireads( str );

	Der Zahlenstring str wird zu der integer-Zahl A umgewandelt.
	Laeuft ireads fehlerhaft ab, so ist A = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher
H*/
/*cS
	ireads ruft auf: isprod, isum, lcomp, linv, sexp

		 Macros: isdigit, lfirst, lred
Sc*/

# include <_calc.h>

int ireads ( zk )                   /* unsafe L */
char *zk;
{
	/***    Null    ***/
	while ( *zk=='0' )  zk += 1;
	if ( *zk=='\0' ) return( 0 );
	/***    nicht Null    ***/
	{       single  a=0, b, i=0;
		int   A=0;
		obj hilf;
		list  L=_0;
		init( hilf );
	    /***    Liste von Theta-Zahlen    ***/
		do {    a = 10*a + *zk-'0';
			if ( ++i == BLOG10 )
			{
				L = lcomp( a,L ),  a=i=0;
			}
		}
		while ( isdigit( *(++zk) ) );
	    /***    Basis Beta    ***/
		L = linv( L );
		bind( L );
		while ( L!=_0 )  {
			A = isprod( A,DECBAS );
			b = lfirst( L ),  L = lred( L );
			A = isum( A,b );
		}
		if ( A!=0 )
		{       hilf = sexp( 10, i );
			A = isprod( A, hilf );
		}
		A = isum( A,a );
		return( A );
	}
}
