/*M
.SH NAME
lsrandperm - list of singles random permutation

.SH SYNOPSIS
.nf
#include<_list.h>

list lsrandperm(n)  
single n;
    
.SH DESCRIPTION
.TP 4
.B n
is an integer number, 0 < n < BASIS.
.PP
lsrand returns a list, containing the first n natural numbers in a random order.
lsrand uses the C-function "rand()".

M*/
       
/*H
	Version 1       13.04.88        R.Boeffgen
	Version 2       22.07.88        "srandperm" ersetzt:
					Ergebnis nicht mehr als Vektor.  RB
   DATE lsrandperm    : 890501
H*/


# include <_list.h>

list lsrandperm( n )
single n;
{
	single V[100], i, k, v, *p;
	list L;
   /***    Initialisierung    ***/
	for (  i=0, p=V;  i<n;  *p++ = ++i  );

   /***    Vertauschungen    ***/
	for ( p--;  i;  i--, p-- ) {
		k = rand() % i;
		v = *p,  *p = V[k],  V[k] = v;
	}

   /***    Liste aus V    ***/
	for ( L=_0;  i++ < n;  L = lcomp(*++p,L) );
   /***    Ergebnis    ***/
	return( L );
}
