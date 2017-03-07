/*M
.SH NAME
fputpnf - file put polynomial over number field 
 
.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputpnf(r, F, P, V, Vnf, pf)  
single r; 
pol F, P;
list V, Vnf; 
FILE *pf; 

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P
is a polynomial in r variables over K.
.TP 4
.B V
is a list, containing the variables names used by P (s. pmakevl).
.TP 4
.B Vnf
is a list which contains one element, representing the name of a zero of F.
.TP 4
.B pf
points to an input file.      
.PP
fputpnf writes P to the file *pf, the end of P will be marked with '#'.
fputpnf returns 0 by success and ERROR else.

.SH SEE ALSO
pmakevl
                                                              
M*/
                     
/*H
	Version 1       11.04.1991      A. Stein
   DATE fputpnf       : 910715
H*/


#include <_pol3.h>

single fputpnf(r,F,P,V,Vnf,pf)
single r;
pol F,P;
list V, Vnf;
FILE *pf;
{                    
	single a=0;
	bind( P, Vnf );

	if (!P) {
		if (fputs("0 #",pf) == EOF) {a = ERROR ; errmsgio("fputpnf","P201"); }
	}
	else if (!r) {
		if ( fputnfel(F,P,Vnf,pf) == ERROR) { a = ERROR ; errmsgio("fputpnf","P201"); }
	}
	else {
		obj kf, ks;
		list L;
		bind(V);
		init( L, kf, ks );

		V = lcconc(Vnf,V);
		P = ptodip(r,P);
		for (L=_0;P!=_0;P=lred2(P)) {
			kf = lfirst(P);
			ks = lsecond(P);
			kf = nfeltoudpr(kf);
			kf = dptop(1,kf);
			L  = lcomp2(ks,kf,L);
		}
		P = linv(L);
		P = diptop(r,P);
		if ( fputpr(r+1,P,V,pf) == ERROR ) { a = ERROR ; errmsgio("fputpnf","P201"); }
        }
	return(a);
}
