/*M
.SH NAME
picevalp - polynomial over integers choice of evaluation points

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol picevalp( r, P, pA )  
single r; 
pol P; 
list *pA;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in the r variables X1,...Xr over the integer numbers.
P is square-free with regard to it's main variable Xr.
.PP
picevalp computes the list A = (s(1) ... s(r-1)), consisting of the singles s(i), which are minimal with regard to the reverse lexicographical order (0<1<-1<2<-2<...), so that
.PP
deg(P(X1,...,Xr) = deg(P(s(1),...,s(r-1),Xr) with regard to X.
.PP
picevalp returns the univariate and square-free polynomial P1, where
.IP
P1 = P(s(1),...,s(r-1),X).
.PP
picevalp writes the list A to *pA.
            
M*/
             
/*H
	Version 1       13.08.1989      A.Stein
   DATE picevalp      : 891101.9203__
H*/


#include <_pol2.h>

pol picevalp( r, P, sA )
single r;
pol P;
list *sA;
{
	single e,s;
	obj a;
	list S;
	pol P1,P1h,Pa,GCD;
	bind(P);
	init(a,P1,Pa,S);
	r--;

/* Ausfuehren der for-Schleife bis das Polynom univariat, d.h. r==0. */

	for(S=_0; r>0 ;r--,S=lcomp(s,S),P=P1 ) {

/* Vorbereitungen zur Auswahl von s(i), angefangen bei s(r-1). */

		s = 0 ;
		e = lfirst(P);
		a = lsecond(P);
		P = lred2(P);
		for ( ; ; ) {

/* Auswerten von a und P an der Stelle s. */

			Pa = pieval(r,a,s);
			if( Pa ) {
				P1 = ( P != _0 ) ? ( pievalsv(r+1,P,r,s) )
						 : ( 0 ) ;
				if ( !P1 ) P1 = _0 ;
				P1 = lcomp2(e,Pa,P1);
				P1h = pideriv(r,P1);
				GCD = pigcdcf(r,P1,P1h,&P1h,&P1h);
				if( !pdegree(r,GCD) ) break;
/* Bei Erfolg Verlassen der while(1)-Schleife. */

			}
/* Weitersuchen fuer s(i) mit neuem s. */
			s = ( s>0 ) ? ( -s ) : ( 1-s ) ;

		}

/* Reduktion und naechste Koordinate betrachten. */
	}

/* Ausgabe */

	*sA = S;
	return(P);
}
