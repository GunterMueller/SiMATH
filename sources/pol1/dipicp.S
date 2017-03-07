/*M
.SH NAME
dipicp - distributive polynomial over integers content and primitive part
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
int dipicp(r, P, pPP)  
single r; 
pol P,*pPP;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.     
.TP 4                                                                           
.B P                                                                            
is a distributive polynomial in r variables over the integer numbers.        
.PP
dipicp computes the content C and the primitive part PP of the polynomial P.
The leading base coefficient of PP is positive.
.PP
dipicp returns C, PP can be found in *pPP.
                                                                 
M*/                                                                             

/*H
	Version 1	21.07.1992	Th. Weis
   DATE dipicp        : 930115
H*/

#include <_pol1.h>

static pol dipibcquot(single,pol,int);

int dipicp(r,P,pPP)
single r;
pol    P,*pPP;
{
/*
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 )  {
     *pPP = P;
     return(0);
  }
/*
 * Fall: P = 0  - Ende
 * allgemeiner Fall - Anfang
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    single s;
    int    C,BC,BC1;
    list    EL;

    bind(P);
    init(C,BC,BC1);
    init(EL);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * ggT berechnen - Anfang
 */
    *pPP = dipmoad(r,P,&BC,&EL);
    s    = isign(BC);
    if ( s < 0 )  BC = ineg(BC);
    while ( *pPP != _0 && BC != 1 ) {
          *pPP = dipmoad(r,*pPP,&BC1,&EL);
          BC   = igcd(BC,BC1);
    }
/*
 * ggT berechnen - Ende
 * Dividieren - Anfang
 */
    C    = BC;
    *pPP = P;
    if ( BC == 1 ) {
       if ( s < 0 ) {
          C    = -BC;
          *pPP = dipineg(r,P);
       }
    }
    else {
         if ( s < 0 )  C = ineg(BC);
         *pPP = dipibcquot(r,P,C);
    }
/*
 * Dividieren - Ende
 * allgemeiner Fall - Ende
 * Rueckgabe
 */
    return(C);
  }
}



/*c
                         dipibcquot( r, P, A )        (static)

        "distributive polynomial over integers, base coefficient quotient"
        Quellbibliothek: srclib.pol1
        Include-Datei:   _pol1.h
        static pol dipibcquot(r,P,A)  single r; pol P; int A;
        P1C = dipibcquot(r,P,A);
        Dabei muss gelten:
              - 0 <= r < BASIS.
              - P ist ein Polynom in r Variablen ueber Z in distributiver
                Darstellung, dessen Koeffizienten alle durch A teilbar
                sind.
              - A ist ungleich 0.
        P1 = P/A.
c*/

static pol dipibcquot(r,P,A)
single r;
pol    P;
int    A;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol PP,P1;
  int BC,C,CR;
  list EV;

  bind(P,A);
  init(PP,P1,BC,C,CR,EV);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Fall: P = 0  - Anfang
 */
  if ( P == 0 ) return(0);
/*
 * Fall: P = 0  - Ende
 * Fall: P != 0  - Anfang
 * Vorbesetzen - Anfang
 */
  P1 = _0;
  PP = P;
/*
 * Vorbesetzen - Ende
 * Dividieren - Anfang
 */
  do {
     PP = dipmoad(r,PP,&BC,&EV);
          iqrem(BC,A,&C,&CR);
     P1 = lcomp2(EV,C,P1);
     /* EV und C vertauscht, da spaeter 
        linv(P1) gemacht wird */
  } while ( PP != _0 );
  P1 = linv(P1);
/*
 * Dividieren - Ende
 * Rueckgabe
 */
  return(P1);
}
