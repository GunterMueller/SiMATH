/*M
.SH NAME
llconc - list of lists concatenation

.SH SYNOPSIS
.nf
#include<_list.h>

list llconc(L)  
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list of lists, say L = (L_1, ..., L_n).
.PP
llconc returns the concatenation of the L_i's. The L_i's will be changed.
 
M*/
     
/*H
	Version 1	28.06.1993	Th. Weis
   DATE llconc        : 931130
H*/

#include <_list.h>

list llconc(L)
list L;
{
/*
 * Fall: L == _0  - Anfang
 */
  if ( L == _0 )  return(_0);
/*
 * Fall: L == _0  - Ende
 * Deklaration, Binden & Initialisieren - Anfang
 */
  {
    list L1,Li,LiI,LI,LII;

    bind(L);
    init(L1,Li,LiI,LI,LII);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
    Li = L;
/*
 * Vorbesetzen - Ende
 * Teillisten aneinanderhaengen - Anfang
 */
    do {
       L1 = lfirst(Li);
       Li = lred(Li);
    } while ( !( L1 != _0 || Li == _0 ) );
    LI = L1;
    while ( Li != _0 ) {
          LII = lfirst(Li);
          Li  = lred(Li);
          if ( LII != _0 ) {
             LiI = llast(LI);
                   lsred(LiI,LII);
             LI  = LII;
          }
    }
/*
 * Teillisten aneinanderhaengen - Ende
 * Rueckgabe
 */
    return(L1);
  }
}
