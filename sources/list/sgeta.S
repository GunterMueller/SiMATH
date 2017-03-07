/*M
.SH NAME
sgeta - string get atom

.SH SYNOPSIS
.nf
#include<_list.h>

atom sgeta( ps )  
char **ps;
 
.SH DESCRIPTION
sgeta reads an atom from the string *ps and returns it. After that, *p points to the character behind the last character read.
In case of an error, sgeta returns ERROR.

M*/
       
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE sgeta         : 931130
H*/


# include <_list.h>

atom sgeta ( pf )
char **pf;
{
	obj a;
	single  s = 1, c;
    /***    erstes signifikantes Zeichen    ***/
	if ( (c = sgetcs(pf)) == '\0' )  {
		errmsgio( "sgeta", "EA302" );
		return( ERROR );
	}
    /***    Vorzeichen    ***/
	if ( c == '+' || c == '-' )  {
		s = (c=='+') ? 1 : -1;
		c = sgetcs( pf );
	}
    /***    erste Ziffer    ***/
	if ( !isdigit(c) )  {
		errmsgio( "sgeta", "EA001" );
		return( ERROR );
	}
    /***    weitere Ziffern    ***/
	for ( a = 0 ; isdigit(c) ; c = sgetc(pf) )  {
		a = 10 * a + c - '0';
		if ( a >= BASIS )  {
			errmsgio( "sgeta", "EA001" );
			return( ERROR );
		}
	}
    /***    Endergebnis    ***/
	a *= s;
	unsgetc( c,pf );
	return( a );
}
