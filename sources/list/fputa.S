/*M
.SH NAME
fputa - file put atom

.SH SYNOPSIS
.nf
#include<_list.h>

single fputa(a, pf)  
atom a; 
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
fputa writes the atom a to the file *pf and returns 0 by success and ERROR else.

M*/
      
/*H
	Version 1       23.02.1987      R.Boeffgen
	Version 2       07.09.1987      Typ-Test entfernt.  RB
   DATE fputa         : 890501
H*/


# include <_list.h>

single fputa ( a , pf )
atom a;
FILE *pf;
{
	single i;
	char *c;
	static char xstr[14];
   /***    Atom zu String umwandeln    ***/
	sprintf( xstr, "%d", a );
   /***    String ausgeben    ***/
	if ( fputs(xstr,pf)==EOF )  {
		errmsgio( "fputa", "EA105" );
		return( ERROR );
	}
	return( 0 );
}
