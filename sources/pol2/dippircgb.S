/*M
.SH NAME
dippircgb - distributive polynomial over polynomials over integers reduced comprehensive Groebner basis

.SH SYNOPSIS
.nf
#include<_pol2.h>

list dippircgb(r1, r2, VL1, VL2, PL, CONDS, OPL, pGS, pi, pf)
single r1, r2; 
list VL1, VL2, PL, CONDS, OPL, *pGS;   

.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B PL
is a list of distributive polynomials in r1 variables over a ring of polynomials in r2 variables over the integer numbers.  
.TP 4
.B VL1
is a list, consisting of the r1 variables names used by the polynomials in PL.
.TP 4
.B VL2
is a list, consisting of the r2 variables names used by the ring of polynomials
over the integer numbers.
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n),
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero           
 (i even).
.PP
(s. EXAMPLES)
.TP 4
.B OPL
is a list of length 3, every element (say e1,e2,e3) has value 0 or 1.
.RS
.TP 4
.B e1
turns the factorization of the coefficient polynomials on (e1=1) or off(e1=0).
.TP 4
.B e2
determines the algorithm used to normalize the polynomials.
.IP
e2 = 0: 'Top reduction' will be used, i.e. only
        the leading monomials (with regard to
        the term order) unequal to zero will be
        eliminated.
.IP
e2 = 1: the 'common' algorithm to compute Groebner
        basis will be used.
.TP 4
.B e3                
determines the output of intermediary results (results e3 = 1, no results e3 =0).
The intermediary results, if desired, will be written to the output file *pf.
.RE
.TP 4
.B pf
points on an open input file *pf (s. section OPL)
.PP
dippircgb computes a reduced Groebner system, say GS, i.e. by means of CONDS, which will be improved while dippicgb runs, dippicgb computes for every pair of coefficient lists (s. section CONDS) a Groebner basis. Thereby, a kind of tree arises, with a pair of coefficient lists and the appendant Groebner basis in every edge.  
.PP
dippircgb writes the number of edges to *pi, GS to *pGS and returns the union of the computed Groebner basis (without the pairs of coefficient lists).   

.SH EXAMPLES
Example for CONDS
.PP
Let VL2 = (a b c d), then CONDS can looks as follows:
.IP
 {{a^2-d# c+d#}{a#}{}{a^4-b*a^3+c*d}},
 i.e. a^2-d==0, c+d==0, a!=0, a^4-b*a^3+c*d!=0;
 or
 {{a^2-d# c+d#}{a#}},
 i.e. a^2-d==0, c+d==0, a!=0;
 or
 {{}{b^2-d^3+c# a# c#}},
 i.e. b^2-d^3+c!=0, a!=0, c!=0;
 or
 {{b# c# a^5-d^4+d^3+d#}{}},
 i.e. b==0, c==0, a^5-d^4+d^3+d==0.

.SH SEE ALSO
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)                           
                                                                         
M*/
    
/*H
	Version 1	21.04.1993	Th. Weis
	Version 2	28.06.1993	lcopy eingefuegt.  TW
   DATE dippircgb     : 930531.931130
H*/


#include <_pol2.h>

list dippircgb(r1,r2,VL1,VL2,PL,CONDS,OPL,pGS,pi,pf)
single r1,r2;
list   VL1,VL2,PL,CONDS,OPL;
list   *pGS;
single *pi;
FILE   *pf;
{
/*
 * Fall: PL == {}  - Anfang
 */
  if ( PL == _0 )  return(_0);
/*
 * Fall: PL == {}  - Ende
 * Fall: PL != {}
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single fac,out,red;
    list   PP,CGB,CGBL,COND;

    bind(VL1,VL2,PL,CONDS,OPL);
    init(PP,CGB,CGBL,COND);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Berechnungen vorbereiten - Anfang
 */
    PP    = lcopy(PL);
    PP    = diplpm(r1,PP);
    PP    = linv(PP);
    COND  = cgbcc(r1,r2,CONDS);
    fac   = lfirst(OPL);
    red   = lsecond(OPL);
    out   = lthird(OPL);
/*
 * Berechnungen vorbereiten - Ende
 * reduziertes Groebnersystem und
 * reduzierte umfassende Groebnerbasis berechnen - Anfang
 */
    *pGS = cgbigbsys(r1,r2,VL1,VL2,PP,CONDS,fac,red,out,pf);
    *pGS = cgbigsred(r1,r2,*pGS,fac);  /* <-- Reduzierung */
           cgbmkcgb(r1,r2,*pGS,&CGB,pi);
    CGBL = cgbiglobred(r1,r2,COND,CGB,fac);
/*
 * reduziertes Groebnersystem und
 * reduzierte umfassende Groebnerbasis berechnen - Ende
 * Rueckgabe
 */
    return(CGBL);
  }
}
