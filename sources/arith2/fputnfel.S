/*M
.SH NAME
fputnfel - file put number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputnfel(F, a, V, pf)  
pol F; 
nfel a; 
list V; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K.
.TP 4
.B a
is an element of K (s. below).
.TP 4
.B V
is a list of variables, V contains one element.
.TP 4
.B pf
points on an output file.  
.PP                        
fputnfel writes a as a polynomial over Q to the output file *pf. The polynomial uses the variable which is named in V.
fputnfel returns 0 by success and ERROR else.
                       
.SH NOTES
The output of a number field element to a file is also given by fputonfel.
.PP
a is represented by a list 
.IP
(HNa s a_s ... a_0), where
.TP 4
a_0 ... a_s 
are the coefficients of an univariate polynomial of degree s over Z in dense representation, say A.
.TP 4
HNa 
is a positive integer number, so that
gcd(HNa,a_s,...,a_0) = 1.
.PP
Then, a is equal to 
.IP
1/HNa * A.
.PP
(For a = 0, a is represented by 0).
 
.SH SEE ALSO
 fputonfel

M*/
               
/*H
	Version 1       14.03.1989      Christine Hollinger
	Version 2       24.02.1989      0 Koeffizient.  CH
	Version 3       24.10.1990      a = 0: fprintf(pf,"0\n") ->
                                               fprintf(pf,"0 #");
					fprintf(pf,"\n") --> fprintf(pf," #") );
					Placebo F.  CH
	Version 4       31.01.1991      fputc(c,pf) durch while-Schleife
					ersetzt.  TW
        Version 5       22.09.1992      Abfragen z<0 bzw. >0 durch
					isign(z)<0 bzw. >0 ersetzt.  TW
	Version 6	22.01.1993	voellig neu.  PS
	Version 7	25.01.1993      "MACRO"-Eintrag aus der Dokumentation
					entfernt. MP
   DATE fputnfel      : 890601.900315.901120.910915.921130.930115
H*/


# include <_arith2.h>

single fputnfel(F,a,V,pf)
pol F;
nfel a;
list V;
FILE *pf;
{
	/* Funktion statt Macro, da es in fputmanf   */
	/* und fputvecnf als Funktion benoetigt wird */

	return( fputpr(1,dptop(1,nfeltoudpr(a)),V,pf) );
}
