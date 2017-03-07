#ifndef __MATR2__
#include <_list.h>
#include <_arith1.h>
#include <_ec1.h>
#include <_pol1.h>
#include <_matr1.h>
#include <_pol2.h>
#include <_arith2.h>
#include <_ec2.h>
#include <_matr2.h>
#endif
#define __POL3__

#define        putpgfs(r, p, AL, P, V, Vgfs)  fputpgfs(r, p, AL, P, V, Vgfs, stdout)
#define           getpgfs(r, p, AL, V, Vgfs)  fgetpgfs(r, p, AL, V, Vgfs, stdin)

#define           pgfsquot(r, p, AL, P1, P2)  pgfsqrem(r, p, AL, P1, P2, &POLDUMMY)
#define            pgfsrem(r, p, AL, P1, P2)  (pgfsqrem(r, p, AL, P1, P2, &POLDUMMY), POLDUMMY)

#define               pgf2quot(r, G, P1, P2)  pgf2qrem(r, G, P1, P2, &POLDUMMY)
#define                pgf2rem(r, G, P1, P2)  (pgf2qrem(r, G, P1, P2, &POLDUMMY), POLDUMMY)
#define                pgf2dif(r, G, P1, P2)  (pgf2sum(r, G, P1, P2))
#define                     pgf2neg(r, G, P)  (P)

#define                pnfquot(r, F, P1, P2)  pnfqrem(r, F, P1, P2, &POLDUMMY)
#define                 pnfrem(r, F, P1, P2)  (pnfqrem(r, F, P1, P2, &POLDUMMY), POLDUMMY)

#define                 getpnf(r, F, V, Vnf)  fgetpnf(r, F, V, Vnf, stdin)
#define              putpnf(r, F, P, V, Vnf)  fputpnf(r, F, P, V, Vnf, stdout)

#define                      getppf(r, p, V)  fgetppf(r, p, V, stdin)
#define                   putppf(r, p, P, V)  fputppf(r, p, P, V, stdout)

#define               getpgf2(r, G, V, Vgf2)  fgetpgf2(r, G, V, Vgf2, stdin)
#define            putpgf2(r, G, P, V, Vgf2)  fputpgf2(r, G, P, V, Vgf2, stdout)

#define       getdipgfsl(r, p, AL, VL, Vgfs)  fgetdipgfsl(r, p, AL, VL, Vgfs, stdin)
#define   putdipgfsl(r, p, AL, PL, VL, Vgfs)  fputdipgfsl(r, p, AL, PL, VL, Vgfs, stdout)

#define             getdipnfl(r, F, VL, Vnf)  fgetdipnfl(r, F, VL, Vnf, stdin)
#define         putdipnfl(r, F, PL, VL, Vnf)  fputdipnfl(r, F, PL, VL, Vnf, stdout)

#define           upgf2nbquot(G, MT, P1, P2)  upgf2nbqrem(G, MT, P1, P2, &POLDUMMY)

