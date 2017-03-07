#ifndef __EC1__
#include <_list.h>
#include <_arith1.h>
#include <_ec1.h>
#endif
#ifndef __POL1__
#define __POL1__

#define                     pol  int

#define         piquot(r,P1,P2)  piqrem(r,P1,P2,&POLDUMMY)
#define          pirem(r,P1,P2)  (piqrem(r,P1,P2,&POLDUMMY),POLDUMMY)

#define      pmiquot(r,M,P1,P2)  pmiqrem(r,M,P1,P2,&POLDUMMY)
#define       pmirem(r,M,P1,P2)  (pmiqrem(r,M,P1,P2,&POLDUMMY),POLDUMMY)
#define      pmsquot(r,m,P1,P2)  pmsqrem(r,m,P1,P2,&POLDUMMY)
#define       pmsrem(r,m,P1,P2)  (pmsqrem(r,m,P1,P2,&POLDUMMY),POLDUMMY)

#define         prquot(r,P1,P2)  prqrem(r,P1,P2,&POLDUMMY)
#define          prrem(r,P1,P2)  (prqrem(r,P1,P2,&POLDUMMY),POLDUMMY)

#define      udpmiquot(m,P1,P2)  udpmiqrem(m,P1,P2,&POLDUMMY)
#define      udpmsquot(m,P1,P2)  udpmsqrem(m,P1,P2,&POLDUMMY)

#define            pdegree(r,P)  ((P) == 0? 0 : lfirst(P))
#define                plc(r,P)  ((P) == 0? 0 : lsecond(P))
#define               pred(r,P)  ((P) == 0? 0 : (lred2(P) == _0? 0 : lred2(P)))

#define              getpi(r,V)  fgetpi(r,V,stdin)
#define           getpmi(r,m,V)  fgetpmi(r,m,V,stdin)
#define           getpms(r,m,V)  fgetpms(r,m,V,stdin)
#define              getpr(r,V)  fgetpr(r,V,stdin)
#define                 getvl()  fgetvl(stdin)

#define            putpi(r,P,V)  fputpi(r,P,V,stdout)
#define         putpmi(r,m,P,V)  fputpmi(r,m,P,V,stdout)
#define         putpms(r,m,P,V)  fputpms(r,m,P,V,stdout)
#define            putpr(r,P,V)  fputpr(r,P,V,stdout)

#define          getdipil(r,VL)  fgetdipil(r,VL,stdin)
#define      getdipmipl(r,p,VL)  fgetdipmipl(r,p,VL,stdin)
#define      getdipmspl(r,p,VL)  fgetdipmspl(r,p,VL,stdin)
#define          getdiprl(r,VL)  fgetdiprl(r,VL,stdin)

#define putdipdim(r,dim,S,M,VL)  fputdipdim(r,dim,S,M,VL,stdout)
#define       putdipil(r,PL,VL)  fputdipil(r,PL,VL,stdout)
#define   putdipmipl(r,p,PL,VL)  fputdipmipl(r,p,PL,VL,stdout)
#define   putdipmspl(r,p,PL,VL)  fputdipmspl(r,p,PL,VL,stdout)
#define       putdiprl(r,PL,VL)  fputdiprl(r,PL,VL,stdout)

#define         dipfmo(r,BC,EV)  list2(BC,EV)
#define             diplbc(r,P)  ((P) == 0? 0 : lfirst(P))

#define             itopi(r, A)  pvinsert(0, A, r)

#define udpirf(P, sort, pROOTS)   udprf(1, P, sort, pROOTS)
#define udprrf(P, sort, pROOTS)   udprf(2, P, sort, pROOTS)
#define udpflrf(P, sort, pROOTS)  udprf(0, P, sort, pROOTS)

extern single   LIST_GSP[];
extern obj      POLDUMMY;
extern int      EVORD, GBRHO;
extern single   ITERMAX;

#define                   BETA1  536870911	/* = 2^29-1 */
#endif




