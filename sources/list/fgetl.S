/*M
.SH NAME
fgetl - file get list (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

list fgetl(pf)  
FILE *pf;
    
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
fgetl reads a list from the file *pf and returns it. In case of an error, fgetl returns ERROR.   

M*/
      
/*H
	Version  1      04.03.1987      R.Boeffgen
	Version  2	02.04.1992	"while (1)"->"while (!llength(_0))".  PS
   DATE fgetl         : 890501.920331
H*/


# include <_list.h>

list fgetl ( pf )
FILE *pf;
{
	list L = _0;
	obj  M;
	single c = fgetcs(pf);
	if  ( c != '(' )  goto ERR;
	c = fgetcs(pf);
	bind( L );
	do  {
		if ( c==')' )  return( linv(L) );
		else if (c == '(')  {
			ungetc(c,pf);
			M = fgetl( pf );
			if ( M == ERROR )  goto ERR;
		}
		else if ( c=='+' || c=='-' || isdigit(c) )  {
			ungetc(c,pf);
			M = fgeta( pf );
			if ( M == ERROR )  goto ERR;
		}
		else  goto ERR;
		L = lcomp(M,L);
		if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
	}
	while ( !llength(_0) );		/* Bei "while (1)" meldet der Com- */
					/* piler des MX300 eine Warnung.   */
   /***    Fehlermeldung    ***/
  ERR:  errmsgio( "fgetl", "EA003" );
	return( ERROR );
}
