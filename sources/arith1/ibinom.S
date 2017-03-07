/*M
.SH NAME
ibinom - integer binomial coefficient

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ibinom(n,k)
int n,k;

.SH DESCRIPTION
ibinom() returns the binomial coefficient n over k,
i.e. the number of unordered subsets with k elements taken
from a set of n elements.
.PP
.TP 4
.B n
is a non-negative integer
.TP 4
.B k
is a non-negative integer, k <= n
M*/
/*H
	Version 1       26.08.1988      Christine Hollinger
	Version 2       15.09.1989      A.Stein. Vollkommen neue Version.
	Version 3       04.01.1991      A.Stein Fehler im Trivialfall behoben,
					Var.dekl. erst im else-Fall.
   DATE ibinom        : 890501.89110.910301.9107__.9311__
H*/


#include <_arith1.h>

int ibinom( n,k )
int n,k;
{
	int B,i,j,m;
	init( B,i,j,m );
	bind( n,k );

/*** Bei unkorrekter Eingabe: Fehlermeldung  ***/

	if( icomp(n,k) < 0 || icomp(n,0) < 0 || icomp(k,0) < 0 ) {
	/*** This clause should be rewritten with errmsgio. ***/
		fprintf( stderr, "\n Eingabe ueberpruefen!!!! \n");
		return(ERROR);
	}

/*** B(n,k) == B(n,n-k) ***/
	m = idif(n,k);
	if( icomp(k,m) < 0 ) m = k;

/*** triviale Faelle: B(n,n) == B(n,0) == B(0,0) == 1   ***/

	if( !icomp(m,0) )    B = 1;

/*** Sonst: B(n,k) == (n/1)*[(n-1)/2]*.....*[(n-k+1)/k]   ***/

	else {
	        B=n;
		j=idif(n,1);
		for( i=2 ; icomp(i,m)<=0 ; i=isum(i,1) ) {
			B = iprod(B,j);
			B = iquot(B,i);
			j = idif(j,1);
		}
	}

/***    Ausgabe         ***/

	return(B);

}
