/*M
.SH NAME
cdprlfcdmar - common denominator polynomial over the rationals list from common denominator matrix of rationals

.SH SYNOPSIS
.nf
#include<_pol2.h>

list cdprlfcdmar(M)  
matrix M;
    
.SH DESCRIPTION
.TP 4
.B M
is a matrix, with rows r(1),...,r(n).
.PP
For 1 <= i <= n, let P(i) be the CD-polynomial, represented by the row r(i) of M (seen as 'coefficient list', s.cdprfcl).
.PP
cdprfcdmar returns a list L, where
.IP
L = ( P(1) ... P(n)).
 
.SH SEE ALSO
cdprfcl

M*/
                 
/*H
	Version 1       15.05.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					return(linv(L)) geaendert;
   DATE cdprlfcdmar   : 891101.900101.9109__
H*/

#include<_pol2.h>

list cdprlfcdmar(M)
matrix M;
{
	list Mz,L;
	pol P;
	init(P,Mz,L);
	bind(M);

	L = _0;
	while ( M != _0 ) {
		Mz = lfirst(M);
		M = lred(M);
		P = cdprfcl(Mz);
		L = lcomp(P,L);
	}                            
	L = linv(L);
	return(L);
}
