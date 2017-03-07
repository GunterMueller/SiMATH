/*M
.SH NAME
ecqnfinit - elliptic curve over quadratic number field, initialization

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfinit( D, a1, a2, a3, a4, a6 )
int D;  
nfel a1, a2, a3, a4, a6;
 
.SH DESCRIPTION
.TP 4
.B D 
is a square free integer number, D != 0 or 1.  
.PP
Let K = Q(D^(1/2)) be a quadratic number field.
.TP 4
.B a1, a2, a3, a4, a6
are elements of K and the coefficients of an elliptic curve, say E, in Weierstrass normal form over K.
.PP
ecqnfinit creates and returns a list, say L, consisting of five other lists, L1, ..., L5.
.PP
ecqnfinit writes the values a1, a2, a3, a4, a6 to L11 (s. below) and initialize all other lists as empty lists.
.PP
These lists will contain all important data (when computed) of the curve E. Thereby ecqnfinit persues the following concept:
.PP
The data of the actual model can be found in L1. Functions using or changing data of L1 begin with the prefix 
.B ecqnfac 
for  
.BR e lliptic
.BR c urve
over
.BR q uadratic
.BR n umber
.BR f ield,
.BR a ctual
.BR c urve.
.PP
The data of the minimal model can be found in L2, whereat ecqnfinit distinguishs between two cases:
.PP
Case 1. There exists a global minimal model of E in K. Then L2 contains the data of the global minimal model of E, which is of restricted typ, i.e. the coefficients a1, a2, a3, a4, a6 are integers in K and the coefficients of a global minimal model of E/K, where
.PP
 a1, a3 in {0, 1},                 for 2 ramified or split 
                                   in K,
 a1, a3 in {a+b*omega; a,b = 0,1}, for 2 inertial in K,
.PP
 a2 in {-1, 0, 1}                  for 3 ramified or split 
                                   in K,
 a2 in {a+b*omega; a,b = -1,0,1},  for 3 inertial in K,
.PP
with omega = 
.PP
 D^(1/2),       for D = 2, 3  mod 4,
 (1+D^(1/2))/2, for D = 1 mod 4.
.PP
Case 2: There does not exist a global minimal model of E in K. Then L2 contains lists 
.PP
 ( P_i pi_i z_i LP_i )
 list P_i, LP_i; nfel pi_i, single z_i;, where
.PP
 P_i  is a primideal (s. qnfidprod) in K over a prime 
      number p. With regard to P_i, E/K has  bad 
      reduction.
 pi_i is a locally uniformizing parameter of p,
 z_i  specifies the law of decomposition of p,
 LP_i contains the data of the minimal model of restricted 
      typ of E with regard to P_i.
.PP
Functions using or changing data of L2 begin with the prefix
.B ecqnfmin
for
.BR e lliptic
.BR c urve
over
.BR q uadratic
.BR n umber
.BR f ield,
.BR min imal 
model. 
.PP                    
The data of a model in short Weierstrass normal form (sWnf) can be found in L3. If E/K has a global minimal model, one of the following models will be chosen:
.PP
 1.) The minimal model is in sWnf, then the coefficients 
     a4 and a6 of L21 (s. below) will be chosen.
 2.) The minimal model is not in sWnf, then the model 
     Y^2 = X^3 - 27*c4*X - 54*c6
     with coefficients c4, c6 of L23 (s. below) will be 
     chosen.
.PP
If E/K has not a global minimal model, the first local minimal model in the list L2 will be used instead. The coefficients will be determined analogous to the global case.
.PP
Functions using or changing data of L3 begin with the prefix
.B ecqnfsnf
for
.BR e lliptic
.BR c urve
over
.BR q uadratic
.BR n umber
.BR f ield,
.BR s hort
.BR n ormal
.BR f orm.
.PP
The invariants of E/K, not depending on the model of the curve, can be found in L4.
.PP
Functions using or changing data of L4 begin with the prefix
.B ecqnfinv
for
.BR e lliptic
.BR c urve
over
.BR q uadratic
.BR n umber
.BR f ield,
.BR inv ariants.
.PP
The data of the quadratic number field K can be found in L5.

.SH THE LISTS IN DETAIL
L1 has the form ( L11 L12 L13 L14 L15 L16 L17 ), where
.TP 4
.B L11
= (a1a a2a a3a a4a a6a) nfel a1a, a2a, a3a, a4a, a6a;
.TP 4
.B L12
= (b2a b4a b6a b8a)     nfel b2a, b4a, b6a, b8a; 
.TP 4
.B L13
= (c4a c6a)             nfel c4a, c6a; 
.TP 4
. B L14
= (Da FDa NDa FNDa)     nfel Da; list FDa, FNDa; 
                        rat NDa;
.TP 4
. B L15
= (TPa GTa)             list TPa, GT;
.TP 4
. B L16
= (BTam BTas)           list BTam, BTas;
.TP 4
. B L17
= Ba                    list Ba; 
.PP
with
.TP 5
.B a1a, a2a, a3a, a4a, a6a 
are the coefficients of the actual model of the curve E/K,
.TP 5 
.B b2a, b4a, b6a, b8a, c4a, c6a
are the Tate values of the actual model,
.TP 5
.B Da
is the discriminant of the actual model,
.TP 4
.B FDa
 = (1),  for Da being an unit, or
 = (P1 f1 pi1 z1 ..) list Pi; single fi,zi; nfel pii;,
 the factorization of Da into prime ideals,
.TP 5
.B NDa
is the norm of Da,
.TP 5
.B FNDa 
= (p1 e1 p2 e2 ...) int pi; single ei;
is the factorization of NDa,
.TP 5
.B TPa 
is a list, containing all torsion points of the actual model of the curve E/K,
.TP 5
.B GTa
= (T) or (T1 T2), is a list, containing the generators of the torsion group of the actual model,
.TP 5
.B BTam 
= (r_am s_am t_am u_am) nfel r_am, s_am, t_am, u_am;  
is the birationaly tranformation of the actual model into the minimal model, 
.TP 5
.B BTas
as BTam, but into the short normal form.
.TP 5
.B Br
= (Pr_1 ... Pr_r) list Pr_1, ..., Pr_r;
is a basis of the Mordell-Weil group of the actual model of the curve E/K, whereat r denotes the rank of the curve.
.PP
If a global minimal model of E/K exists,  
L2 has the form   ( L21 L22 L23 L24 L25 L26 L27 ), where
.TP 4
.B L21 
= (a1m a2m a3m a4m a6m) nfel a1m, a2m, a3m, a4m, a6m;
.TP 4
.B L22 
= (b2m b4m b6m b8m)     nfel b2m, b4m, b6m, b8m;
.TP 4
.B L23 
= (c4m c6m)             nfel c4m, c6m;
.TP 4
.B L24 
= (Dm FDm)              nfel Dm; list FDm;
.TP 4
.B L25 
= (TPm GTm)             list TPm, GTm;
.TP 4
.B L26 
= (BTmr BTms)           list BTmr, BTms;
.TP 4
.B L27 
= Bm                    list Bm;
.PP
analogous to the lists L11 - L17 ( with regard to the minimal model of the curve E/K).
.PP
If no global minimal model exists, L2 contains lists in the form (P pi z LP) (s. above), where the lists LP are analogous to the list L1 (with regard to the local minimal model over the prime ideal P ).
.PP
L3 has the form ( L31 L32 L33 L34 L35 L36 L37 ), where
.TP 4
.B L31
= (a4s a6s)         nfel a4s, a6s;
.TP 4
.B L32
= (b2s b4s b6s b8s) nfel b2s, b4s, b6s, b8s;
.TP 4
.B L33
= (c4s c6s)         nfel c4s, c6s;
.TP 4
.B L34
= (Ds FDs)          nfel Ds; list FDs;
.TP 4
.B L35
= (TPs GTs)         list TPs, GTs;
.TP 4
.B L36
= (BTsr BTsm)       list BTsr, BTsm;
.TP 4
.B L37
= Bs                list Bs;    
.PP
where
.TP 4
.B a4s, a6s
are the coefficients of a model of E/K in short Weierstrass normal form (s. above)
.PP
The lists L32 ... L37 are analogous to the lists L12 ... L37 (with regard to the model in short Weierstrass normal form).
.PP                
L4 has the form ( L41 L42 L43 L44 L45 ), where
.TP 4
.B L41
= (j Fnj)           nfel j; list Fnj;
.TP 4
.B L42
= (N FN NN Nrt Lcp) list N, FN, Nrt, Lcp; int NN;
.TP 4
.B L43
= (oT ST)           single oT; list ST;
.TP 4
.B L44
= (C r Lr R TS)     single C, r, TS; floating Lr, R;
.TP 4
.B L45
= ( w )             floating w;
.PP
with
.TP 4
.B j
is the j-invariant of E/K,
.TP 4
.B Fnj
= (P1 e1 ... Pk ek) is the factorization of the 
  j-invariant into primideals,
.TP 4
.B N
is the conductor of E/K (an ideal),
.TP 4
.B FN
= (1), for N being an unit,
  (P1 f1 pi1 z1 ...) list Pi; single fi,zi; nfel pii; 
  is the factorization of N into primideals,
.TP 4
.B NN
is the norm of the conductor,
.TP 4
.B Nrt
= (P1 t1 ... Pn tn) contains all primideals, E/K has bad reduction for, together with the reduction typ according to Kodaira,
.TP 4
.B Lcp
= (c cP1 ... cPn)  single c, cP1, ..., cPn; where
the cPi are the cp-values with regard to Pi, and c is the product over all cp-values with P | N,  
.TP 4
.B oT
is the order of the torsion group of E/K,
.TP 4
.B ST
= (oT) or (oT/2 2) is a list, specifing the structure of the torsion group,
.TP 4
.B C
is the sign of the functional equation of the L-series of E/K,
.TP 4
.B r 
is the rank of the elliptic curve E/K, 
.TP 4
.B TS
is the order of the Tate-Shafarevic group III,
.TP 4
.B Lr
is the value of the r-th derivation of the L-series L(E, s) of E/K at s = 1, where r denotes the rank of E/K,
.TP 4
.B R 
is the regulator of E/K,
.TP 4
.B w 
is the reall period omega.
.PP                
L5 has the form ( D d4 )  int D; single d4; , where
.PP
.TP 4
.B D
is the discriminant of the quadratic number field K, and
.TP 4
.B d4 
 = 1, for D = 1 mod 4,
 = 0, else.  
.PP                
.SH SEE ALSO 
qnfidprod

M*/
       
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2	29.11.1995      Listenstruktur modifiziert. JG
   DATE ecqnfinit     : 931130.951201
H*/

#include<_ec2.h>

list ecqnfinit( D, a1, a2, a3, a4, a6 ) 
int D;
nfel a1, a2, a3, a4, a6;
{
    list E, L1, L2, L3, L4, L5;

    init( E, L1, L2, L3, L4, L5 );

    bind( D, a1, a2, a3, a4, a6 );

    L5 = list5( a1, a2, a3, a4, a6 );
    L1 = list6( _0, _0, _0, _0, _0, _0 );
    L1 = lcomp( L5, L1 );
    L2 = _0;
    L3 = _0;
    L4 = list6( _0, _0, _0, _0, _0, _0 );

    if( mshom( 4, D ) == 1 )
    {
        L5 = list2( D, 1 );
    }
    else
    {
        L5 = list2( D, 0 );
    }

    E = list5( L1, L2, L3, L4, L5 );

    return( E );
}
