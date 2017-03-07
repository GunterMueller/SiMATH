/*M
.SH NAME
ispmiunit - is polynomial over modular integers unit ?

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispmiunit(r, m, P)  
single r; 
int m; 
pol P;
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B m 
is an integer number, m > 0.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
.PP
ispmiunit returns 
.TP 4
1,
if P is an unit in the polynomial ring in r variables over Z/mZ.
.TP 4
0,
else.

M*/

/*H                                                                         
	Version 1 	13.08.91	J.Schmitt
   DATE ispmiunit     : 910915
H*/                                                                         
                                                                            
# include <_pol1.h>                                                         
                                                                            
single ispmiunit(r,m,P)                                                     
single r;
int m;                                                                 
pol P;                                                                      
{                                                                           

/***    Fuer f(x1,..,xr) aus (Z/mZ)[x1,...,xr] mit Koeffizienten     ***/
/***    a(i1,...,ir) gilt folgende Aequivalenz:                      ***/
/***    f ist Einheit in (Z/mZ)[x1,...,xr]        <==>               ***/
/***    1)     a(0,...,0) ist Einheit in Z/mZ                        ***/
/***    2)     M | a(i1,...,ir) fuer alle (i1,...,ir)!=(0,...,0).    ***/
/***    Dabei ist M gleich dem quadratfreien Kern von m,	     ***/ 
/***    d.h. M ist gleich dem Produkt aller Primteiler von m.        ***/

                                                                            
	if ( !P ) return(0);                                                    
	else {

		pol P1;
		list L;
		int M;

		bind(m,P);
		init(P1,L,M);


/* Test, ob absolutes Glied Einheit in Z/mZ ist */

		P1 = ptbc(r,P);
		if ( igcd(P1,m) != 1 ) return(0);


/* Bestimmung des quadratfreien Kerns M von m */

		L = ifact(m);
		M = 1;
		while ( L != _0 ) {
			P1 = lfirst(L);
			M = iprod(P1,M);                    
			L = lred(L);
			while ( L != _0 && !icomp(P1,lfirst(L)) ) 
				L = lred(L);
		}
		if ( !icomp(M,m) ) { 
			if ( lred2(P) != _0 ) return(0);
			else return(1);
		}


/* Ueberpruefen der Basiskoeffizienten auf obige Eigenschaft */

		while ( P != _0 ) {
			P1 = plbc(r,P);
			if ( mihom(M,P1) ) return(0);
			P  = lred2(P);
		}
		return(1);
	}
}
