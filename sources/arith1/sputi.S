/*M
.SH NAME
sputi - string put integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

char *sputi(A,str)
int A;
char *str;

.SH DESCRIPTION
sputi() writes the integer A to the memory location at str
and returns str.

.SH CAUTION
There is no checking whether or not the space at str is sufficient!
M*/
/*H
	Version 1       26.02.1987      R.Boeffgen
	Version 2       14.08.1991      Dekl. "char *sprintf();" entfernt.  PS
   DATE sputi         : 890501.910915
H*/


# include <_arith1.h>

char *sputi ( A , str )
int A;
char *str;
{
	char *strcat();
   /***    A einfach-genau    ***/
	if ( isatom(A) )  return( sputa(A,str) );
   /***    A mehrfach-genau   ***/
	{
		single  a;
		list  L = _0;
		char  s[20], *p;
		bind2( L, A );
   /***    Umwandlung zur Basis DECBAS    ***/
		do {
			isqrem ( A,DECBAS, &A,&a );
			L = lcomp( a,L );
		}
		while ( A != 0 );
   /***    Schreiben des ersten Dezimalteils    ***/
		a = lfirst( L ),  L = lred( L );
		sputa( a, str );
   /***    Schreiben der restlichen Ziffern    ***/
		while ( L != _0 )  {
			a = lfirst( L ),  L = lred( L );
			a = sabs( a );
			*(p = s+BLOG10) = '\0';
			while ( p-- >s )  *p = a%10+'0',  a /= 10;
			strcat( str, s );
		}
		return( str );
	}
}
