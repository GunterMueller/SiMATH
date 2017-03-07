/*M
.SH NAME
gf2sum - Galois-field with characteristic 2 sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2sum( G, a, b)
obj G;
gf2el a,b;

.SH DESCRIPTION
gf2sum computes a+b in the Galois-field GF(2^m)
.TP 4
.B G
is an univariate, irreducible polynomial of degree m in the
special bit representation (see udpgf2tosb()).
G generates GF(2^m).
.TP 4
.B a,b
are elements of GF(2^m) (polynomials of degree <m in the 
special bit representation)
M*/
/*H
        Version 1        06.03.1992     A.Stein
	Version 2	 05.09.1996	E.Herrmann (bind,init)
   DATE gf2sum         : 920331.961201
H*/

#include <_arith2.h>

gf2el gf2sum(G,a,b)
obj G;
gf2el a, b;
{
        gf2el c;
        init(c); bind(G);

        if ( !a ) c = b;
        else if ( !b ) c = a;
        else {  
                single e1,e2;
                bind(a,b);

                e1 = lfirst(a); a = lred(a);
                e2 = lfirst(b); b = lred(b);
                if( e1 > e2 ) {
                        c = list1(e1);
                        e2 /= 30; e2++;
                        e1 = (e1/30) + 1 - e2;
                        while( e1-- ) {
                                c = lcomp(lfirst(a),c);
                                a = lred(a);
                        }
                        while( e2-- ) {
                                c = lcomp(lfirst(a)^lfirst(b),c);
                                a = lred(a); 
                                b = lred(b);
                        } 
                        c = linv(c);
                }
                else if( e1 < e2 ) {
                        c = list1(e2);
                        e1 /= 30; e1++;
                        e2 = (e2/30) + 1 - e1;
                        while( e2-- ) {
                                c = lcomp(lfirst(b),c);
                                b = lred(b);
                        }
                        while( e1-- ) {
                                c = lcomp(lfirst(a)^lfirst(b),c);
                                a = lred(a) ; 
                                b = lred(b);
                        }                       
                        c = linv(c);
                }
                else {
                        single h;
                        e1 = (e1/30) + 1;
                        e2 = e2 - (e2%30); 
                        c = _0;
                        while( e1-- ) {
                                c = lcomp(lfirst(a)^lfirst(b),c);
                                a = lred(a) ; 
                                b = lred(b);
                        }                               
                        c = linv(c); 

                /* Berechne den Grad der Summe */ 

                        for( ; c != _0 && !(h=lfirst(c)); c=lred(c), e2-=30 );
                        if( c == _0 ) c = 0;
                        else {   
                                for( h>>=1 ; h; h>>=1, e2++);
                                c = lcomp(e2,c);
                        } 
                } 
        }
        return(c);
};
