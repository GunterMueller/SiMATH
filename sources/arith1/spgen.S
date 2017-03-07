/*M
.SH NAME
spgen - single prime generator

.SH SYNOPSIS
.nf
#include<_arith1.h>

list spgen(a,b)
single a,b;

.SH DESCRIPTION
spgen() returns the list L = (p1,...,pr) with p1<...<pr of all prime numbers pi with a <= p < a+2*b for a,b >0 and a+2*b <BASIS. On an error L=error will be
returned.

.SH CAUTION
A character-array of length b+1 will be allocated.
M*/
/*H
	Version 1       09.04.1987              Pascale Serf
	Version 2       09.11.1987              calloc --> malloc   PS
   DATE spgen         : 890501.8910__
H*/


# include <_arith1.h>

list spgen(a,b)
single a,b;
{
	single m1,m2,h,i,d,s,q,p,r;
	char *A;
	list L;

	init(L);

	/*    Speicherplatz fuer A reservieren    */
	if ( (A = (char*)malloc((b+1)*sizeof(char))) == NULL ) {
		fprintf(stderr,"Fehler in spgen: ");
		fprintf(stderr,"nicht genuegend Speicherplatz vorhanden \n");
		return(ERROR);
	}

	/*    Initialisierungen    */
	m1 = a + seven(a);
	h = 2*b - 2;
	m2 = m1 + h;
	for ( i=1 ; i<=b ; i++ ) A[i] = 't';

	/*    echte Vielfache von d fuer d=3, d=6n+1 und d=6n-1 mit
	      d*d<=m2 werden gestrichen    */
	d = 3;
	s = 0;
	while ( (q = m2/d) >= d ) {
		r = m1 % d;
		if ( r+h >= d || r == 0 ) {
			if ( r == 0 ) i = 1;
			else if ( seven(r) ) i = d - r/2 + 1;
			     else i = (d - r)/2 + 1;
			if ( m1 <= d ) i = i + d;
			while ( i <= b ) {
				A[i] = 'f';
				i = i + d;
			}
		}
		if ( s == 1 ) { d = d+4; s = 2; }
		else if ( s == 2 ) { d = d+2; s = 1; }
		     else { d = 5; s = 2; }
	}

	/*    Zusammenbauen der Primzahlliste    */
	L = _0;
	p = m2;
	i = b;
	do {
		if ( A[i] == 't' ) L = lcomp(p,L);
		p = p - 2;
		i = i - 1;
	}
	while ( i > 0 );
	if ( a == 1 ) lsfirst(L,2);
	if ( a == 2 ) L = lcomp(2,L);

	/*    Freigeben des allokierten Speicherplatzes    */
	free(A);

	return(L);

}
