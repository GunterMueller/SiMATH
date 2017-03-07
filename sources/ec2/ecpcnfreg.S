/*M
.SH NAME 
ecpcnfreg - elliptic curve over pure cubic number field regulator

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnfreg(D, a1, a2, a3, a4, a6, L)
int    D;
nfel   a1, a2, a3, a4, a6; 
list   L;

.SH DESCRIPTION
ecpcnfreg() returns the regulator of a given set of r points P1,...,Pr on a
n elliptic curve E over a pure cubic number field K = Q(D^(1/3)).

.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a_i
are the Weierstrass coefficients of E, where E is an elliptic curve in minimal Weierstrass equation.
.TP 4
.B L
is a list containing r points Pi = ( xi, yi, zi ) on E(K), L = ( P1 ... Pr ).   
M*/
/*H
        Version 1       20.02.1998      Andreas Heiser
   DATE ecpcnfreg    :  
H*/

#include<_ec2.h>

floating ecpcnfreg(D,a1,a2,a3,a4,a6,L)

int     D;
nfel    a1,a2,a3,a4,a6;
list    L;
{       pol             P;
        list            H,P1,P2;
        floating        reg,h1,h2,h3;
        matrix          M;
        single          i,j,n;
        nfel            x1,y1,x2,y2,h;

        init(H,P,P1,P2,M,i,j,n,reg,h,h1,h2,h3,x1,y1,x2,y2);
        bind(D,a1,a2,a3,a4,a6,L);

        P=list5(3,1,0,0,-D);
        h=list3(1,0,1);
        
        n=llength(L);
        M=maconszero(n,n);M=maitomafl(M);
        H=L;
        for(i=1;i<=n;i++)
        {       P1=lfirst(H);
                h1=ecpcnfnetahe(D,a1,a2,a3,a4,a6,P1);
                h1=masetel(M,i,i,h1);
                H=lred(H);
        }
        for(i=1;i<=n;i++)
        {       H=L;
                h1=maselel(M,i,i);
                P1=lfirst(H);
                H=lred(H);
                for(j=i+1;j<=n;j++)
                {       h2=maselel(M,j,j);
                        h2=flsum(h1,h2);
                        P2=lfirst(H);;
                        P2=ecnfsum(P,a1,a2,a3,a4,a6,P1,P2);
                        h3=ecpcnfnetahe(D,a1,a2,a3,a4,a6,P2);
                        h2=fldif(h3,h2);h2=flquot(h2,itofl(2));
                        h2=masetel(M,i,j,h2);
                        h2=masetel(M,j,i,h2);
                        H=lred(H);
                }
                L=lred(L);
        }
        reg=mafldet(M);
        return(reg);
}

