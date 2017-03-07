# ifndef __POL2__
# include <_list.h>
# include <_arith1.h>
# include <_ec1.h>
# include <_pol1.h>
# include <_matr1.h>
# endif
# define __POL2__

# define		   gf2el  int

# define         piprimpart(r,P)  (picontpp(r,P,&POLDUMMY),POLDUMMY)

# define        getdippicd(r1, r2, VL1, VL2, fac)  fgetdippicd(r1,r2,VL1,VL2,fac,stdin)
# define              getdippil(r1, r2, VL1, VL2)  fgetdippil(r1,r2,VL1,VL2,stdin)

# define    putdippigbs(r1, r2, GS, VL1, VL2, cs)  fputdippigbs(r1,r2,GS,VL1,VL2,cs,stdout)
# define          putdippil(r1, r2, PL, VL1, VL2)  fputdippil(r1,r2,PL,VL1,VL2,stdout)
# define        putdippicgb(r1,r2,CGBL,i,VL1,VL2)  fputdippicgb(r1,r2,CGBL,i,VL1,VL2,stdout)
# define          putdippidim(r1,r2,DIML,VL1,VL2)  fputdippidim(r1,r2,DIML,VL1,VL2,stdout)
# define putdippigt(r1,r2,C,PP,CGB0,CGB1,VL1,VL2)  fputdippigt(r1,r2,C,PP,CGB0,CGB1,VL1,VL2,stdout)
# define          putdippipim(r1,r2,NOUT,VL1,VL2)  fputdippipim(r1,r2,NOUT,VL1,VL2,stdout)
# define          putdippiqff(r1,r2,QFFL,VL1,VL2)  fputdippiqff(r1,r2,QFFL,VL1,VL2,stdout)
