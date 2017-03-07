/*M
.SH NAME
isimupms - is irreducible, monic, univariate polynomial over modular singles ?

.SH SYNOPSIS
.nf
#include<_pol2.h>

single isimupms(p, P)  
single p; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P
is an univariate and monic polynomial over Z/pZ of degree >= 1.
.PP
isimupms returns 1 if P is irreducible and 0 else.
 
M*/
                         
/*H
        Version 1       15.08.1987      Pascale Serf
        Version 2       14.04.1988      Typueberpruefungen entfallen. PS
        Version 3       06.11.1995      Einbau von isimupm2. Marc Conrad
        Version 4       11.07.1997      squarefree test corrected. AS
H*/


# include <_pol2.h>

single isimupms( p, A )
single p;
pol A;
{
        single n,a,i,j;
        list Q,Q1,P,B1,L;
        bind(A);
        init(Q,Q1,P,B1,L);

/*     special case: p = 2    */

        if( p == 2 ) return ( isimupm2( A ) );

/*     special case: A not squarefree    */

        P = pmsderiv( 1, p, A );
        P = upmsgcd( p, A, P );
        if ( lfirst(P) ) return(0);

/*     special case: deg(A) == 1    */

        if ( ( n = lfirst(A) ) == 1 ) return( 1 );

/*     general case: deg(A) >= 2    */


        /*    construction of the matrix Q - I    */
        Q = upmsbqp(p,A);
        Q = macup(n,Q);
        Q1 = Q;
        for ( i=0 ; i<=n-1 ; i++ ) {
                P = lfirst(Q1);
                for ( j=1 ; j<=i ; j++ ) P = lred(P);
                a = lfirst(P);
                a = msdif(p,a,1);
                lsfirst(P,a);
                Q1 = lred(Q1);
        }

        Q=matransp(Q);
        B1 = mamsnsb(p,Q);
        a = ( llength(B1) == 1 ) ? ( 1 ) : ( 0 );

        return(a);
}

