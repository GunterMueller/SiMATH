/*M
.SH NAME
ecrinit - curve over the rational numbers, initialization

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrinit(a1r, a2r, a3r, a4r, a6r)
rat a1r, a2r, a3r, a4r, a6r;

.SH DESCRIPTION
ecrinit() creates and returns the elliptic curve E/Q
defined by the equation
.PP
.TP 8
  E:
y^2 + a1 xy + a3 y = x^3 + a2 x^2 + a4 x + a6
.PP
over the field Q of rational numbers.
The curve is represented as a list L = (L1  L2  L3  L4)
where L1, L2, L3, L4 are also lists containing information on E. 
ecrinit() enters the coefficients a1r, a2r, a3r, a4r, a6r into the list L1.
The four lists represent
.PP
.TP 8
  L1
the actual model of E/Q, i.e. the model y^2 + a1 xy + a3 y = x^3 + a2 x^2 + a4 x + a6
.TP 8
  L2
the minimal model of E/Q, see also ecractoimin()
.TP 8
  L3
the quasi-minimal model of E/Q in short normal form, see also ecimintosnf()
.TP 8
  L4
the invariants of E/Q

.PP
For more detailed information about the lists L1, L2, L3, L4
see the description below.

.PP
.PP
.B "L1 = ( L11  L12  L13  L14  L15  L16  L17 )"
contains data of the actual model.
All functions dealing with these data have the prefix `ecrac'.
The sets of data in L1 are again contained in several lists

.PP
.B "L11 = ( a1r  a2r  a3r  a4r  a6r )  rat a1r, a2r, a3r, a4r, a6r;"
with the coefficients a1r, a2r, a3r, a4r, a6r of the actual model;

.PP
.B "L12 = ( b2r  b4r  b6r  b8r )  rat b2r, b4r, b6r, b8r;"
with the Tate b-values b2r, b4r, b6r, b8r of the actual model;

.PP
.B "L13 = ( c4r  c6r )  rat c4r, c6r;"
with the Tate c-values c4r, c6r of the actual model;

.PP
.B "L14 = ( Dr  FDr )  rat Dr; list FDr;"
with the discriminant Dr of the actual model
and the factorization FDr of Dr;

.PP
.B "L15 = ( TPr GTr )  list TPr, GTr;"
with the set of all torsion points TPr of the actual model
and a set GTr of generators of the torsion subgroup TPr

.PP
.B "L16 = ( BTam  BTas )  list BTam, BTas;"
with the bi-rational transformations BTam and BTas that
transform the actual model into the minimal model or the
model in short normal form, respectively.

.PP
.B "L17 = Br  list Br;"
with a set Br = ( P1 h1 ... Pr hr ) of (basis) points Pr 
with their Neron-Tate heights hr.
The points P1, ..., Pr lie on the actual model of E
and form a basis of the Mordell-Weil group of E/Q.

.PP
.B "L2 = ( L21  L22  L23  L24  L25  L26  L27 )"
contains data of the minimal model.
All functions dealing with these data have the prefix `ecimin'.
The sets of data in L2 are again contained in several lists
where

.PP
.B "L21 = ( a1m  a2m  a3m  a4m  a6m )  int a1m, a2m, a3m, a4m, a6m;"
with the coefficients a1m, a2m, a3m, a4m, a6m of the minimal model;
The lists L22, ..., L25 and L27  are defined in the same way as 
the lists L12, ..., L15 and L17 (where the terms `actual' and `rat' 
have to be replaced by the terms `minimal' and `int', respectively).

.PP
.B "L26 = ( BTma  BTms )  list BTma, BTms;"
with the bi-rational transformations BTma and BTms that
transform the minimal model into the actual model or the
model in short normal form, respectively.

.PP
.PP
.B "L3 = ( L31  L32  L33  L34  L35  L36  L37  L38 )"
contains data of the minimal model
All functions dealing with these data have the prefix `ecimin'.
The sets of data in L3 are again contained in several lists
where

.PP
.B "L31 = ( a4s  a6s )  int a4s, a6s;"
with the coefficients a4s, a6s of the minimal model;
The lists L22, ..., L25 and L27  are defined in the same way as
the lists L12, ..., L15 and L17 (where the terms `actual' and `rat' 
have to be replaced by the terms `short' and `int', respectively).

.PP
.B "L36 = ( BTsa  BTsm )  list BTsa, BTsm;"
with the bi-rational transformations BTsa and BTsm that
transform the short model into the actual or the minimal
model, respectively.

.PP    
.B "L38 = ( prec  RRs )  single prec; list RRs;"
with the list RRs= ( e1 ) or RRs= ( e1 e2 e3 )
(depending on the sign of Ds) of the real roots of the polynomial
x^3 + a4s x + a6s and the precision (FL_EPS =) prec that was used
for the computation. If there are 3 real roots they are ordered
e1 < e2 < e3.

.PP
.B "L4 = ( L41  L42  L43  L44  L45  L46 )"
contains data of the minimal model
All functions dealing with these data have the prefix `ecimin'.
The sets of data in L4 are again contained in several lists
where

.PP
.B "L41 = ( j  Fnj )  rat j, list Fnj;"
with the j-invariant j of E and the factorization Fdj

of the denominator of j;
.PP
.B "L42 = ( N  FN  Nrt  Lcp )  int N; list FN, Nrt, Lcp;"
with the conductor N of E/Q, the factorization
FN = ( p1 e1 ... pk ek ) int p1, ..., pk;
single e1, ..., ek; of N;
the list Nrt = ( p1 t1 ... pk tk ) int p1, ..., pk;
single t1, ..., tk; of Kodaira reduction types of all primes 
dividing N;
The list Lcp = ( c cp1 ... cpk ) single c, cp1, ..., cpk
of all Tamagawa numbers cpi and their product c = cp1 * ... * cpk;

.PP
.B "L43 = ( oT  ST )  single oT; list ST;"
with the order oT and the structure ST of the torsion subgroup

.PP
.B "L44 = ( C  r  Lr  R  TS  chi  l1 )  single C, r, TS; floating Lr, R, l1; pol chi;"
with the sign C of the functional equation of the Hasse-Weil
L-function L(E,s) of E/Q;
the rank r of (the Mordell-Weil group of) E/Q;
the value of the r-th derivative L^{(r)}(E,1) of the Hasse-Weil
L-function L(E,s) of E/Q at s=1;
the regulator R of E/Q;
the (conjectured) order TS of the Tate-Shafarevic group of E/Q;
the characteristic polynomial chi of the regulator matrix of E/Q;
the smallest eigenvalue l1 of the regulator matrix of E/Q;

.PP
.B "L45 = ( pw1  w1  pw2  w2  ptau  tau )  single pw1, pw2, ptau; floating w1; complex w2, tau;"
with the real period w1 of E 
(computed with precision FL_EPS = pw1);
the complex period w2 of E 
(computed with precision FL_EPS = pw2);
the quotient tau = w2 / w1 of the complex and real periods of E 
(such that Im( tau ) > 0, computed with precision FL_EPS = ptau);

.PP
.B "L46 = ( Nnth  b2'  b4'  b6'  b8' ) single Nnth; int b2', b4', b6', b8';"
where Nnth contains information for the computation of the
Neron-Tate height of a point (see documentation of eciminnetahe());
the values b2' = b2m - 12, b4' = b4m - b2m + 6,
b6' = b6m - 2b4m + b2m - 4, b8' = b8m - 3 b6m + 3 b4m - b2m + 3
are also needed for the computation of the Neron-Tate height.

.SH SEE ALSO
ecractoimin, ecimintosn
M*/

/*H
	Version 1	18.09.1991	Michael Pfeifer
	Version 2	10.09.1992	Produkt ueber alle cp-Werte 
                                        hinzugefuegt.  Fall 'D = 0' 
					abgefangen.  Josef Gebel.
	Version 3	17.12.1992	Voellig neu geschrieben (wegen 
					neuem Konzept). Von 'ec2 nach 
					'ec1.  JG.
	Version 4	30.09.1993	Differenz zwischen Weil- und 
					Neron-Tate-Hoehe fuer kurzes 
					Modell eingefuegt.  JG.
	Version 5	21.02.1994	komplexe Periode w2 sowie 
                                        Quotient tau = +/- w1/w2 
                                        eingefuegt JG.
	Version 6	13.05.1995	Charakteristisches Polynom und
                                        kleinster Eigenwert der 
                                        Regulatormatrix eingefuehrt. JG
        Version 7       03.12.1996      list L3 has been modified due to
                                        changes concerning the computations
                                        of the periods of E and elliptic
                                        logarithms: L3 now conatains 8 instead
                                        of 7 lists. JG.
   DATE ecrinit       : 920331.921130.930531.931130.951201.970101
H*/	

#include <_ec1.h>

list           ecrinit( a1r, a2r, a3r, a4r, a6r )
rat             a1r, a2r, a3r, a4r, a6r;
{
    list            L, L1, L2, L3, L4;
    
    bind( a1r, a2r, a3r, a4r, a6r );
    
    init( L, L1, L2, L3, L4 );
    
    L2 = list5( a1r, a2r, a3r, a4r, a6r );
    L1 = lcomp( L2, list6( _0, _0, _0, _0, _0, _0 ) );
    L2 = lcomp( _0, list6( _0, _0, _0, _0, _0, _0 ) );
    L3 = lcomp2( _0, _0, list6( _0, _0, _0, _0, _0, _0 ) );
    L4 = list6( _0, _0, _0, _0, _0, _0 );

    L = list4( L1, L2, L3, L4 );

    return( L );
}   
