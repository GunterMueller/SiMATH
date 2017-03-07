/*M
.SH NAME
msexp - modular single exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

single msexp(m,a,n)
single m,a,n;

.SH DESCRIPTION
msexp() returns a ^ n for n >=0, m >0 and a in Z/mZ.
M*/
/*H
	Version 1       23.2.1987               Pascale Serf
   DATE msexp         : 890501
H*/


# include <_arith1.h>

single msexp(m,a,n)
single m,a,n;
{
	single b,c,n1;

	    /***    Spezialfall : Ergebnis 0    ***/
	if ( m==1 || ( a==0 && n>0 ) ) return(0);
	    /***    allgemeiner Fall, d.h. Ergebnis != 0    ***/
        if( n<0 ){
	        errmsgio("msexp", "A105");
		return(ERROR);
	}
	b = 1;
	c = a;
	n1 = n;
	while ( n1 != 0 ) {
		if ( sodd(n1) ) b = msprod(m,b,c);
		c = msprod(m,c,c);
		n1 = n1 / 2;
	}
	return(b);
}
