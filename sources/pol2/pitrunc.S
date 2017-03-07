/*M
.SH NAME
pitrunc - polynomial over integers truncation, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pitrunc(r, S, P) 
single r;
list S;
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.            
.TP 4
.B S
= (s1,...,sr) is a list, consisting of non negative singles.
.TP 4
.B P
is a polynomial in the r variables X1,...,Xr over the integer numbers.
.PP
pitrunc returns the polynomial P1, where
.IP
P1 = P mod (X1^s1,...,Xr^sr).
 
M*/
                                    
/*H
	Version 1       16.02.1989      A.Stein
   DATE pitrunc       : 891101
H*/


#include <_pol2.h>

pol pitrunc(r,S,P)
single r;
list S;
pol P;
{
	pol P1;
	init(P1);

/* P oder r gleich 0 */

	if (!P  ||  !r) P1 = P;

/* P,r ungleich 0 */

	else {
		single f,s;
		obj a,ah;
		list S1;
		bind(S,P);

/* Initialisierungen */

		r-- ;
		S1 = lreduct(S,r);
		s = lfirst(S1);
		P = lcinv(P);

/* Erzeuge Terme */

		for( P1=_0;P!=_0 && (f=lsecond(P))<s;P=lred2(P) ) {
			ah = lfirst(P);
			a = ( !r ) ? ( ah )
				   : ( pitrunc(r,S,ah) ) ;
			if( a ) P1 = lcomp2(f,a,P1) ;
		}
		if( P1 == _0 ) P1 = 0 ;
	}

/* Ausgabe */

	return(P1);
}
