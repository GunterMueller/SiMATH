/*M
.SH NAME  
pirescspec - polynomial over the integers resultant, Collins algorithm special
                                                                      
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol pirescspec(r, P1, P2, n) 
single r, n; 
pol P1, P2;                                                                                
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the integer numbers.
.PP
pirescoll returns either 
.PP
the resultant (say P3) of P1 and P2 with regard to the main variable, so P3 is a polynomial in r-1 variables over the integer numbers,
.PP
or 0, if the prime number list LIST_GSP does not contain enough prime numbers to compute the resultant.
.PP
In order to compute the resultant, pirescspec uses, if necessary, the Collins algorithm for resultants of polynomials over the integer numbers.
.PP                                                                             
The value of n determines the algorithm used to compute the resultant of P1 and 
P2 over Z/mZ as follows:                                                        
.IP                                                               
 n = 1: computation of the determinant of the                                   
        Sylvester matrix (s. psylvester),                                       
 n = 2: Collins algorithm (s. pmsrescoll).                                      
.PP                                                                             
For r = 1, pirescoll uses the Collins algorithm (independent of n ).            
                                                                                
.SH SEE ALSO                                                                    
 psylvester                                                                     
 pmsrescoll                                                                     
 literature: G.E. Collins, The Calculation of Multivariate                      
             Polynomial Resultants,                                             
             Journal ACM, No. 4,18 (Oct. 1971), 515-532.                        
                                                             
M*/                                                                             

/*H
	Version 1       05.09.1989      J.Schmitt
   DATE pirescspec    : 891101
H*/


#include <_pol2.h>

static pol pirescspecs(single,pol,pol,single);

pol pirescspec(r,P1,P2,n)
single r;
pol P1, P2;
single n;
{
	single e1, e2;
	pol H, P3, k1, k2;
	bind(P1,P2);
	init(H,P3,k1,k2);

/* Sonderfaelle und Minimierung des Problems */

	if (!P1  ||  !P2) P3 = 0;
	else if (!lfirst(P1)  &&  !lfirst(P2)) P3 = pvinsert(0,1,r-1);
	else if (!lfirst(P1)) P3 = piexp(r-1,lsecond(P1),lfirst(P2));
	else if (!lfirst(P2)) P3 = piexp(r-1,lsecond(P2),lfirst(P1));
	else {
            H = P1;
	    while (H != _0) {
		e1 = lfirst(H);
		H = lred(H);
		k1 = lfirst(H);
		H = lred(H);
	    }
	    H = P2;
	    while (H != _0) {
		e2 = lfirst(H);
		H = lred(H);
		k2 = lfirst(H);
		H = lred(H);
	    }
	    if (e1  &&  e2) P3 = 0;
	    else if (e1) {
		P1 = ppmvquot(r,P1,e1);
		H = piexp(r-1,k2,e1);
		if (!lfirst(P1)) P3 = piexp(r-1,lsecond(P1),lfirst(P2));
		else P3 = pirescspecs(r,P1,P2,n);
		P3 = piprod(r-1,P3,H);
	    }
	    else if (e2) {
		P2 = ppmvquot(r,P2,e2);
		H = piexp(r-1,k1,e2);
		if (sodd(e2)  &&  sodd(lfirst(P1))) H = pineg(r-1,H);
		if (!lfirst(P2)) P3 = piexp(r-1,lsecond(P2),lfirst(P1));
		else P3 = pirescspecs(r,P1,P2,n);
		P3 = piprod(r-1,P3,H);
	    }
	    else P3 = pirescspecs(r,P1,P2,n);
	}

/* Ausgabe */

	return(P3);
}





/*c
	Subroutine zur Berechnung der Resultante
c*/
/*H
	Version 1       05.09.1989      J.Schmitt
   DATE pirescspecs   : 891101
H*/


static pol pirescspecs(r,P1,P2,n)
single r;
pol P1, P2;
single n;
{
    single e1, e2, i, m, q, rs, *Pl;
    int A1, A2, S, Q;
    pol P3, P1S, P2S, P3S;
    bind(P1,P2);
    init(A1,A2,S,Q,P3,P1S,P2S,P3S);

/* Berechnung der Koeffizienten-Schranke */

    A1 = pimaxnorm(r,P1);
    A2 = pimaxnorm(r,P2);
    e1 = lfirst(P1);
    e2 = lfirst(P2);
    A1 = iexp(A1,e2);
    A2 = iexp(A2,e1);
    S = ifactl(e1+e2);
    S = iprod(A1,S);
    S = iprod(A2,S);

/* Initialisierung */

    rs = r-1;
    Q = 1;
    P3 = 0;
    Pl = LIST_GSP;

/* Schleife */

    while (icomp(Q,S) < 0) {
	if (*Pl) {
            m = *Pl;
            Pl++;
	}
	else return(0);
	P1S = pitopms(r,P1,m);
	if (pdegree(r,P1S) == e1) {
 	 P2S = pitopms(r,P2,m);
	 if (pdegree(r,P2S) == e2) {
	  if (rs)
	    switch (n) {
	    case 1: P3S = psylvester(r,P1S,P2S);
	            P3S = mapmsdet(rs,m,P3S);
		    break;
            case 2: if ((P3S=pmsrescoll(r,m,P1S,P2S)) == ERROR-1) continue;           	
	            break;
	    default: break;
            }
	  else P3S = upmsres(m,P1S,P2S);
          q = mshom(m,Q);
          q = msinv(m,q);
          P3 = picra(rs,P3,P3S,Q,m,q);
          Q = isprod(Q,m);
	 }
        }
    }

/* Ausgabe */

    return(P3);
}
