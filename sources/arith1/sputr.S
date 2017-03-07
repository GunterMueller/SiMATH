/*M
.SH NAME
sputr - string put rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

char *sputr(R,str)
rat R;
char *str;

.SH DESCRIPTION
sputr() writes the rational number R to the memory location at str
and returns str.

.SH CAUTION
There is no checking whether or not the space at str is sufficient!
M*/

/*H
	Version 1       04.03.1987      R.Boeffgen
   DATE sputr         : 890501
H*/


# include <_arith1.h>

char *sputr ( R , str )
rat R;
char *str;
{
   /***    R Null    ***/
	if ( R==0 )   *str = '0',  *(str+1) = '\0';
	else  {
   /***    R ungleich Null    ***/
		int r2 = lsecond( R );
		bind( r2 );
   /***    Zaehler    ***/
		sputi( lfirst(R), str );
   /***    Nenner    ***/
		if ( r2!=1 )  {
			extern char *strcat();
			strcat( str, "/" );
			sputi( r2, str + strlen(str) );
		}
	}
	return( str );
}
