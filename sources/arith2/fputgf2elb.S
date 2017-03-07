/*M
.SH NAME
fputgf2elb - put Galois-field with characteristic 2 element, bit

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputgf2elb(a, pf)  
gf2el a; 
FILE *pf; 


.SH DESCRIPTION
fputgf2elb() writes the coefficients of the polynomial a 
as a sequence of zeroes and ones to the output file *pf
and returns 0 or ERROR in case an error occurs.
.PP
.TP 4
.B a
is an element of GF(2^n), represented as an
univariate polynomial over Z/2Z of degree <n in
special bit notation.
M*/
/*H
	Version 1       28.11.1995	S.Schmitt
   DATE fputgf2elb    : 951201
H*/

# include <_arith2.h>

single fputgf2elb(a,pf)
gf2el a;
FILE *pf;
{
	single k;
	bind(a);

 /***    erstes Leerzeichen kontrolliert ausgeben    ***/

        if ( fputc(' ',pf) == EOF )  {
                errmsgio( "fputgf2elb", "EA104" );
                return( ERROR );
        }

 /***    Ausgabe des Elements	***/

	a=sbtoudpm2(a);
	a=lred(a);
	while(a!=_0)
	{	k=lfirst(a);
		a=lred(a);
		if(k==1) fputc( '1', pf);
		else if(!k) fputc( '0', pf);
	}
	return(0);
}
