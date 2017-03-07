/*M
.SH NAME
dipevcomp - distributive polynomial exponent vector compare

.SH SYNOPSIS
.nf
#include<_pol1.h>

single dipevcomp(r, EV1, EV2)  
single r; 
list EV1, EV2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B EV1, EV2
are exponent vectors of distributive polynomials in r variables over an arbitrary ring.
.PP
dipevcomp returns 
.IP
 -1, for EV1 < EV2,
  0, for EV1 = EV2,
  1, for EV1 > EV2.
.PP
" < = > " is used with regard to the ordering of the exponent vectors, which is defined by 
.B EVORD.
.PP
Following orderings can appear:
.TP 4
- lexicographical ordering 
.B EVORD 
= 1,
default, see SIMATH manuel.
.TP 4
- graduated lexicographical ordering 
.B EVORD 
= 2, let EV1 = (e1, ...,en), EV2 = (f1, ...,fn);
.IP
EV1 > EV2 : ei = fi, for i = 1,...,j-1,
            ej > fj, and
            ej+1 +...+ en >= fj+1 +...+fn,
            or
            ej < fj, and
            ej+1 +...+ en > fj+1 +...+fn.
.IP
EV1 = EV2 : ei = fi, for i = 1, ..., n.
.IP
EV1 < EV2 : ei = fi, for i = 1,...,j-1,
            ej > fj, and 
            ej+1 +...+ en < fj+1 +...+fn,                                      
            or                                                                  
            ej < fj, and                                                        
            ej+1 +...+ en <= fj+1 +...+fn.
.TP 4
- total degree ordering
.B EVORD 
= 3, let EV1 = (e1, ...,en), EV2 = (f1, ...,fn); 
.IP
EV1 > EV2 : ei = fi, for i = 1,...,j+1,
            ej > fj, and  
            ej-1 +...+ e1 >= fj-1 +...+ f1,
            or
            ej < fj, and
            ej-1 +...+ e1 > fj-1 +...+ f1.
.IP
EV1 = EV2 : ei = fi, for i = 1, ..., n.
.IP
EV1 < EV2 : ei = fi, for i = 1,...,j+1,
            ej > fj, and 
            ej-1 +...+ e1 < fj-1 +...+ f1,
            or
            ej < fj, and
            ej-1 +...+ e1 <= fj-1 +...+ f1.
.TP 4
- lexicographical ordering with invers exponent vector
.B EVORD
= 4, let EV1 = (e1, ...,en), EV2 = (f1, ...,fn); 
.IP
(en, ...,e1) and (fn, ...,f1) will be ordered lexicographically.
           
M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipevcomp     : 930115
H*/

#include <_pol1.h>

static single dipevglc(single,list,list);
static single dipevlc(single,list,list);
static single dipevlci(single,list,list);
static single dipevtdc(single,list,list);

single dipevcomp(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  single t;

  bind(EL1,EL2);

  switch ( EVORD ) {
         case  1: t = dipevlc(r,EL1,EL2);  break;
         case  2: t = dipevglc(r,EL1,EL2); break;
         case  3: t = dipevtdc(r,EL1,EL2); break;
         case  4: t = dipevlci(r,EL1,EL2); break;
         default: t = dipevlc(r,EL1,EL2);
  }
  return(t);
}



/*c
                         dipevglc( r, EL1, EL2 )        (static)

        "distributive polynomial exponent vector graded lexicographical
         compare"
        static single dipevglc(r,EL1,EL2)  single r; list EL1,EL2;
        t = dipevglc(r,EL1,EL2);
        EL1 und EL2 sind Exponentenvektoren von Polynomen in r Variablen 
	(0 <= r < BASIS) in distributiver Darstellung.
	EL1 und EL2 haben also Laenge r.
        t=-1, wenn EL1 < EL2,
        t= 0, wenn EL1 = EL2,
        t= 1, wenn EL1 > EL2,
        wobei " <, =, > " bzgl. der graduierten lexikographischen Ordnung
        des Exponentenvektors zu verstehen sind.
c*/

static single dipevglc(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  if ( EL1 == _0 )  return(0);
  {
    single t,hel1,hhel1,hel2,hhel2;

    t = 0;
    do {
       hel1 = lfirst(EL1); EL1 = lred(EL1);
       hel2 = lfirst(EL2); EL2 = lred(EL2);
    } while ( hel1 == hel2 && EL1 != _0 );
    if ( hel1 < hel2 )  t = (-1);
    if ( hel1 > hel2 )  t = 1;
    while ( EL1 != _0 ) {
          hhel1 = lfirst(EL1);  EL1 = lred(EL1);
          hhel2 = lfirst(EL2);  EL2 = lred(EL2);
          hel1  = hel1 + hhel1;
          hel2  = hel2 + hhel2;
    }
    if ( hel1 < hel2 )  t = (-1);
    if ( hel1 > hel2 )  t = 1;
    return(t);
  }
}



/*c
                         dipevlc( r, EL1, EL2 )        (static)

        "distributive polynomial exponent vector lexicographical compare"
        static single dipevlc(r,EL1,EL2)  single r; list EL1,EL2;
        t = dipevlc(r,EL1,EL2);
        EL1 und EL2 sind Exponentenvektoren von Polynomen in r Variablen 
	(0 <= r < BASIS) in distributiver Darstellung.
	EL1 und EL2 haben also Laenge r.
        t=-1, wenn EL1 < EL2,
        t= 0, wenn EL1 = EL2,
        t= 1, wenn EL1 > EL2,
        wobei " <, =, > " bzgl. der lexikographischen Ordnung des
        Exponentenvektors zu verstehen sind.
c*/

static single dipevlc(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  single t;

  t    = 0;
  while ( EL1 != _0 ) {
        if ( lfirst(EL1) < lfirst(EL2) ) {
           t = (-1);
           break;
        }
        if ( lfirst(EL1) > lfirst(EL2) ) {
           t = 1;
           break;
        }
        EL1 = lred(EL1);
        EL2 = lred(EL2);
  }
  return(t);
}



/*c
                         dipevlci( r, EL1, EL2 )        (static)

        "distributive polynomial exponent vector lexicographical compare
         inverse exponent vector"
        static single dipevlci(r,EL1,EL2)  single r; list EL1,EL2;
        t = dipevlci(r,EL1,EL2);
        EL1 und EL2 sind Exponentenvektoren von Polynomen in r Variablen 
	(0 <= r < BASIS) in distributiver Darstellung.
	EL1 und EL2 haben also Laenge r.
        t=-1, wenn EL1 < EL2,
        t= 0, wenn EL1 = EL2,
        t= 1, wenn EL1 > EL2,
        wobei " <, =, > " bzgl. der lexikographischen Ordnung des umge-
        kehrten Exponentenvektors zu verstehen sind.
c*/

static single dipevlci(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  single t;
  list    HEL1,HEL2;

  bind(EL1,EL2);
  init(HEL1,HEL2);

  HEL1 = lcinv(EL1);
  HEL2 = lcinv(EL2);
  t    = dipevlc(r,HEL1,HEL2);
  return(t);
}



/*c
                         dipevtdc( r, EL1, EL2 )        (static)

        "distributive polynomial exponent vector total degree compare"
        static single dipevtdc(r,EL1,EL2)  single r; list EL1,EL2;
        t = dipevtdc(r,EL1,EL2);
        EL1 und EL2 sind Exponentenvektoren von Polynomen in r Variablen 
	(0 <= r < BASIS) in distributiver Darstellung.
	EL1 und EL2 haben also Laenge r.
        t=-1, wenn EL1 < EL2,
        t= 0, wenn EL1 = EL2,
        t= 1, wenn EL1 > EL2,
        wobei " <, =, > " bzgl. der Ordnung nach dem Totalgrad des
        Exponentenvektors zu verstehen sind (Buchbergers Ordnung nach
        dem Totalgrad).
c*/

static single dipevtdc(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  if ( EL1 == _0 )  return(0);
  {
    single t,hel1,hhel1,hel2,hhel2;
    list   HEL1,HEL2;

    bind(EL1,EL2);
    init(HEL1,HEL2);

    t    = 0;
    HEL1 = lcinv(EL1);
    HEL2 = lcinv(EL2);
    do {
       hel1 = lfirst(HEL1);  HEL1 = lred(HEL1);
       hel2 = lfirst(HEL2);  HEL2 = lred(HEL2);
    } while ( hel1 == hel2 && HEL1 != _0 );
    if ( hel1 < hel2 )  t = (-1);
    if ( hel1 > hel2 )  t = 1;
    while ( HEL1 != _0 ) {
          hhel1 = lfirst(HEL1);  HEL1 = lred(HEL1);
          hhel2 = lfirst(HEL2);  HEL2 = lred(HEL2);
          hel1  = hel1 + hhel1;
          hel2  = hel2 + hhel2;
    }
    if ( hel1 < hel2 )  t = (-1);
    if ( hel1 > hel2 )  t = 1;
    return(t);
  }
}
