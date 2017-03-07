/*M
.SH NAME
fputi - file put integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputi(A,pf)
int A;
FILE *pf;

.SH DESCRIPTION
fputi() writes the integer A
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version 1       23.02.1987      R.Boeffgen
   DATE fputi         : 890501
H*/


# include <_arith1.h>

single fputi ( A , pf )
int A;
FILE *pf;
{
    /***    A einfach-genau    ***/
	if ( isatom(A) )  if ( fputa(A,pf)==0 )  return( 0 );
			  else {
				errmsgio( "fputi", "EA106" );
				return( ERROR );
			  }
    /***    A mehrfach-genau   ***/
	{
		single  a;
		list  L = _0;
		char  s[20], *p;
		bind2( L,A );
    /***    Umwandlung zur Basis DECBAS    ***/
		do {
			isqrem ( A,DECBAS, &A,&a );
			L = lcomp( a,L );
		}
		while ( A != 0 );
    /***     Schreiben des ersten Dezimalteils    ***/
		a = lfirst( L ),  L = lred( L );
		if ( fputa(a,pf) != 0 )  {
			errmsgio( "fputi", "EA106" );
			return( ERROR );
		}
    /***    Schreiben der restlichen Ziffern    ***/
		while ( L != _0 )  {
			a = lfirst( L ),  L = lred( L );
			a = sabs( a );
			*(p = s+BLOG10) = '\0';
			while ( p-- >s )  *p = a%10+'0',  a /= 10;
			if ( fputs(s,pf) != 0 )  {
				errmsgio( "fputi", "EA105" );
				return( ERROR );
			}
		}
    /***    Rueckmeldung    ***/
		return( 0 );
	}
}
