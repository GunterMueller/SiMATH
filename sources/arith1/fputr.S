/*M
.SH NAME
fputr - file put rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputr(R,pf)
rat R;
FILE *pf;

.SH DESCRIPTION
fputr() writes the rational number R
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version 1       23.02.1987      R.Boeffgen
   DATE fputr         : 890501
H*/


# include <_arith1.h>

single fputr ( R , pf )
rat R;
FILE *pf;
{
   /***    R Null    ***/
	if ( R==0 )     if ( fputc('0',pf) != EOF )  return( 0 );
			else {
				errmsgio( "fputr", "EA104" );
				return( ERROR );
			}
   /***    R ungleich Null    ***/
	{
		int r2 = lsecond( R );
		bind( r2 );
   /***    Zaehler    ***/
		if ( fputi( lfirst(R), pf ) )  {
			errmsgio( "fputr", "EA107" );
			return( ERROR );
		}
   /***    Nenner    ***/
		if ( r2!=1 )  {
			fputc( '/',pf );
			if ( fputi(r2,pf) )  {
				errmsgio( "fputr", "EA107" );
				return( ERROR );
			}
		}
   /***    Rueckmeldung    ***/
		return( 0 );
	}
}
