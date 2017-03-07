/*M
.SH NAME
sgetl - string get list (recursive)

.SH SYNOPSIS
.nf
#include<_list.h>

list sgetl(ps)  
char **ps;
  
.SH DESCRIPTION
sgetl reads a list from the string *ps and returns it. After that, *p points to the character behind the last character read. In case of an error, sgetl returns ERROR.
 
M*/
        
/*H
	Version  1      15.06.1993    Marc Conrad
   DATE sgetl         : 931130
H*/


# include <_list.h>

list sgetl ( pf )
char **pf;
{
	list L = _0;
	obj  M;
	single c = sgetcs(pf);
	if  ( c != '(' )  goto ERR;
	c = sgetcs(pf);
	bind( L );
	do  {
		if ( c==')' )  return( linv(L) );
		else if (c == '(')  {
			unsgetc(c,pf);
			M = sgetl( pf );
			if ( M == ERROR )  goto ERR;
		}
		else if ( c=='+' || c=='-' || isdigit(c) )  {
			unsgetc(c,pf);
			M = sgeta( pf );
			if ( M == ERROR )  goto ERR;
		}
		else  goto ERR;
		L = lcomp(M,L);
		if ( (c=sgetcs(pf)) == ',' )  c = sgetcs(pf);
	}
	while ( !llength(_0) );		/* Bei "while (1)" meldet der Com- */
					/* piler des MX300 eine Warnung.   */
   /***    Fehlermeldung    ***/
  ERR:  errmsgio( "sgetl", "EA003" );
	return( ERROR );
}
