/*M
.SH NAME
dipdimpolid - distributive polynomial dimension of a polynomial ideal

.SH SYNOPSIS
.nf
#include<_pol1.h>

single dipdimpolid(r, G, pS, pM)  
single r; 
list G; 
list *pS, *pM;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B G
is a Groebner basis of polynomials in r variables over an arbitrary ring.
.PP
dipdimpolid computes 
.PP
 dim := the dimension of the ideal spanned by G,
 pS  := the maximal free set of variables,
 pM  := the set of all maximal free sets of variables,
.PP
per computing the free sets of variables of the leading monomials of the polynomials within the Groebner basis G.
.PP
dipdimpolid returns dim. pS and pM can be found in *pS resp. *pM.

.SH CAUTION
The computed values are unique only for the case of using a lexicographical term order ( i.e. the global variable EVORD = 1 ).
Using an other order, the computed values are only lower bounds for the dimension and the free sets.
If G is not a Groebner basis, the computed values are also lower bounds.

M*/

/*H
        Version 1	15.03.1993	Th. Weis
   DATE dipdimpolid   : 931130
H*/

#include <_pol1.h>

static list dipdims(single,list,list,list,list);
static single usetct(single,list,list);
static single evgbit(single,list,list);
static list evdov(single,list);

single dipdimpolid(r,G,pS,pM)
single r;
list   G;
list   *pS,*pM;
{
/*
 * Fall: G == {}; r == 0  - Anfang
 */
  if ( G == _0 )  return(r);
  if ( r ==  0 )  return((-1));
/*
 * Fall: G == {}; r == 0  - Ende
 * Fall: G != {}; r != 0
 */
  {
    single dim,dlp,i;
    list   EL,ML,MP,QL,U,VL,VS;

    bind(G);
    init(EL,ML,MP,QL,U,VL,VS);
/*
 * Bestimmung der Groessen - Anfang
 */
    QL = lfirst(G);
    EL = dipevl(r,QL);
    VL = evdov(r,EL);
    VS = _0;
    if ( VL == _0 )  return((-1));
    dim = 0;
    *pS = _0;
    *pM = _0;
    U   = _0;
    {
      single b_1,b_2;

      b_1 = 1;
      b_2 = r;

      if ( b_1 <= b_2 )
         for ( i = b_1 ;; i += 1 ) {
             U = lcomp(i,U);
             if ( i >= b_2 ) break;
         }
    }
    U   = linv(U);
    *pM = dipdims(r,G,*pS,U,*pM);
    *pM = linv(*pM);
    MP  = *pM;
    while ( MP != _0 ) {
          ML  = lfirst(MP);
          MP  = lred(MP);
          dlp = llength(ML);
          if ( dlp > dim ) {
             dim = dlp;
             *pS = ML;
          }
    }
/*
 * Bestimmung der Groessen - Ende
 * Rueckgabe
 */
    return(dim);
  }
}



/*c
			dipdims( r, G, S, U, M )	(static)

	"distributive polynomial dimension" (rekursiv)
        static list dipdims(r,G,S,U,M)  single r; list G,S,U,M;
        MP = dipdims(r,G,S,U,M);
c*/

static list dipdims(r,G,S,U,M)
single r;
list   G,S,U,M;
{
  single s,t;
  list   A,ML,MP,MS,SP,UL,UP;

  bind(G,S,U,M);
  init(A,ML,MP,MS,SP,UL,UP);

  A  = _0;
  UP = U;
  MP = M;
  while ( UP != _0 ) {
        UL = lfirst(UP);
        UP = lred(UP);
        SP = list1(UL);
        SP = lcconc(S,SP);
        t  = evgbit(r,SP,G);
        if ( t == 0 )  MP = dipdims(r,G,SP,UP,MP);
  }
  MS = MP;
  s  = 0;
  while ( MS != _0 && s == 0 ) {
        ML = lfirst(MS);
        MS = lred(MS);
        s  = usetct(r,S,ML);
  }
  if ( s == 0 )  MP = lcomp(S,MP);
  return(MP);
}



/*c
			usetct( r, U, V )	(static)

        static single usetct(r,U,V)  single r; list U,V;
        t = usetct(r,U,V);
c*/

static single usetct(r,U,V)
single r;
list   U,V;
{
  list   UL,UP;

  bind(U,V);
  init(UL,UP);

  UP = U;
  while ( UP != _0 ) {
        UL = lfirst(UP);
        UP = lred(UP);
        if ( lmemb(UL,V) != 1 )  return(0);
  }
  return(1);
}



/*c
			evgbit( r, S, G )	(static)

        static single evgbit(r,S,G)  single r; list S,G;
        t = evgbit(r,S,G);
c*/

static single evgbit(r,S,G)
single r;
list   S,G;
{
  if ( G == _0 )  return(0);
  {
    single rms,s;
    list   EL,GP,PL,SP,SPP,V;

    bind(S,G);
    init(EL,GP,PL,SP,SPP,V);

    GP  = G;
    SP  = S;
    SPP = _0;
    while ( SP != _0 ) {
          s   = lfirst(SP);
          SP  = lred(SP);
          rms = r-s;
          s   = rms+1;
          SPP = lcomp(s,SPP);
    }
    SPP = linv(SPP);
    while ( GP != _0 ) {
          PL = lfirst(GP);
          GP = lred(GP);
          EL = dipevl(r,PL);
          V  = evdov(r,EL);
          s  = usetct(r,V,SPP);
          if ( s == 1 )  return(1);
    }
    return(0);
  }
}



/*c
			evdov( r, U )	(static)

        static list evdov(r,U)  single r; list U;
        V = evdov(r,U);
c*/

static list evdov(r,U)
single r;
list   U;
{
  single j;
  list   UL,US,V;

  bind(U);
  init(UL,US,V);

  V  = _0;
  US = U;
  j  = 0;
  while ( US != _0 ) {
        j  = j+1;
        UL = lfirst(US);
        US = lred(US);
        if ( UL != 0 )  V = lcomp(j,V);
  }
  V = linv(V);
  return(V);
}
