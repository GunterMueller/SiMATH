# ifndef __POL1__
# include <_list.h>
# include <_arith1.h>
# include <_ec1.h>
# include <_pol1.h>
# endif
# define __MATR1__

# define                   matrix  int
#ifndef _IINT_H
# define                      vec  int
#endif

int fgeti();
int fgetr();
int fgetms();
int fgetmi();
int fgetpi();
int fgetpr();
int fgetpms();
int fgetpmi();

int fputi();
int fputr();
int fputms();
int fputmi();
int fputpi();
int fputpr();
int fputpms();
int fputpmi();

int isum();
int rsum();
int mssumf();
int misumf();
int pisum();
int prsum();
int pmssum();
int pmisum();

int iprod();
int rprod();
int msprod();
int miprodf();
int piprod();
int prprod();
int pmsprod();
int pmiprod();

int ineg();
int rneg();
int msnegf();
int minegf();
int pineg();
int prneg();
int pmsneg();
int pmineg();

int isint();
int israt();
int isms();
int ismi();
int ispi();
int ispr();
int ispms();
int ispmi();

int ispol();
int isdpol();

int isdpi();
int isdpr();
int isdpms();

int mapidet();
int maprdet();
int mapmsdet();
int mapmidet();

# define              fgetmai(pf)  fgetma(pf,fgeti,0,0,0,0)
# define              fgetmar(pf)  fgetma(pf,fgetr,0,0,0,0)
# define           fgetmams(m,pf)  fgetma(pf,fgetms,1,m,0,0)
# define           fgetmami(m,pf)  fgetma(pf,fgetmi,1,m,0,0)
# define         fgetmapi(r,V,pf)  fgetma(pf,fgetpi,2,r,V,0)
# define         fgetmapr(r,V,pf)  fgetma(pf,fgetpr,2,r,V,0)
# define      fgetmapms(r,m,V,pf)  fgetma(pf,fgetpms,3,r,m,V)
# define      fgetmapmi(r,m,V,pf)  fgetma(pf,fgetpmi,3,r,m,V)
  
# define                 getmai()  fgetmai(stdin)
# define                 getmar()  fgetmar(stdin)
# define               getmams(m)  fgetmams(m,stdin)
# define               getmami(m)  fgetmami(m,stdin)
# define             getmapi(r,V)  fgetmapi(r,V,stdin)
# define             getmapr(r,V)  fgetmapr(r,V,stdin)
# define          getmapms(r,m,V)  fgetmapms(r,m,V,stdin)
# define          getmapmi(r,m,V)  fgetmapmi(r,m,V,stdin)
  
# define            fputmai(M,pf)  fputma(M,pf,fputi,0,0,0,0)
# define            fputmar(M,pf)  fputma(M,pf,fputr,0,0,0,0)
# define         fputmams(m,M,pf)  fputmas(M,pf)
# define         fputmami(m,M,pf)  fputmai(M,pf)
# define       fputmapi(r,M,V,pf)  fputma(M,pf,fputpi,2,r,V,0)
# define       fputmapr(r,M,V,pf)  fputma(M,pf,fputpr,2,r,V,0)
# define    fputmapms(r,m,M,V,pf)  fputma(M,pf,fputpms,3,r,m,V)
# define    fputmapmi(r,m,M,V,pf)  fputma(M,pf,fputpmi,3,r,m,V)

# define         putmaflfx(M,v,n)  fputmaflfx(M,v,n,stdout)
# define                putmai(M)  fputmai(M,stdout)
# define                putmar(M)  fputmar(M,stdout)
# define             putmams(m,M)  fputmas(M,stdout)
# define             putmami(m,M)  fputmai(M,stdout)
# define           putmapi(r,M,V)  fputmapi(r,M,V,stdout)
# define           putmapr(r,M,V)  fputmapr(r,M,V,stdout)
# define        putmapms(r,m,M,V)  fputmapms(r,m,M,V,stdout)
# define        putmapmi(r,m,M,V)  fputmapmi(r,m,M,V,stdout)
  
# define             maiprod(M,N)  maprod(M,N,iprod,isum,0,0,0)
# define             marprod(M,N)  maprod(M,N,rprod,rsum,0,0,0)
# define          mamsprod(m,M,N)  maprod(M,N,msprod,mssumf,1,m,0)
# define          mamiprod(m,M,N)  maprod(M,N,miprodf,misumf,1,m,0)
# define          mapiprod(r,M,N)  maprod(M,N,piprod,pisum,1,r,0)
# define          maprprod(r,M,N)  maprod(M,N,prprod,prsum,1,r,0)
# define       mapmsprod(r,m,M,N)  maprod(M,N,pmsprod,pmssum,2,r,m)
# define       mapmiprod(r,m,M,N)  maprod(M,N,pmiprod,pmisum,2,r,m)

# define              maisum(M,N)  masum(M,N,isum,0,0,0)
# define              marsum(M,N)  masum(M,N,rsum,0,0,0)
# define           mamssum(m,M,N)  masum(M,N,mssumf,1,m,0)
# define           mamisum(m,M,N)  masum(M,N,misumf,1,m,0)
# define           mapisum(r,M,N)  masum(M,N,pisum,1,r,0)
# define           maprsum(r,M,N)  masum(M,N,prsum,1,r,0)
# define        mapmssum(r,m,M,N)  masum(M,N,pmssum,2,r,m)
# define        mapmisum(r,m,M,N)  masum(M,N,pmisum,2,r,m)

# define                maineg(M)  maneg(M,ineg,0,0,0)
# define                marneg(M)  maneg(M,rneg,0,0,0)
# define             mamsneg(m,M)  maneg(M,msnegf,1,m,0)
# define             mamineg(m,M)  maneg(M,minegf,1,m,0)
# define             mapineg(r,M)  maneg(M,pineg,1,r,0)
# define             maprneg(r,M)  maneg(M,prneg,1,r,0)
# define          mapmsneg(r,m,M)  maneg(M,pmsneg,2,r,m)
# define          mapmineg(r,m,M)  maneg(M,pmineg,2,r,m)

# define           maivecmul(A,x)  mavecmul(A,x,iprod,isum,0,0,0)
# define           marvecmul(A,x)  mavecmul(A,x,rprod,rsum,0,0,0)
# define        mamsvecmul(m,A,x)  mavecmul(A,x,msprod,mssumf,1,m,0)
# define        mamivecmul(m,A,x)  mavecmul(A,x,miprodf,misumf,1,m,0)
# define        mapivecmul(r,A,x)  mavecmul(A,x,piprod,pisum,1,r,0)
# define        maprvecmul(r,A,x)  mavecmul(A,x,prprod,prsum,1,r,0)
# define     mapmsvecmul(r,m,A,x)  mavecmul(A,x,pmsprod,pmssum,2,r,m)
# define     mapmivecmul(r,m,A,x)  mavecmul(A,x,pmiprod,pmisum,2,r,m)
  
# define       maichpol(M)  machpol(M,mapidet,-1,1,1,0)
# define       marchpol(M)  machpol(M,maprdet,list2(-1,1),1,1,0)
# define    mamschpol(m,M)  machpol(M,mapmsdet,m-1,2,1,m)
# define    mamichpol(m,M)  machpol(M,mapmidet,idif(m,1),2,1,m)
# define    mapichpol(r,M)  machpol(M,mapidet,pvinsert(0,-1,r),1,r+1,0)
# define    maprchpol(r,M)  machpol(M,maprdet,pvinsert(0,list2(-1,1),r),1,r+1,0)
# define mapmschpol(r,m,M)  machpol(M,mapmsdet,pvinsert(0,m-1,r),2,r+1,m)
# define mapmichpol(r,m,M)  machpol(M,mapmidet,pvinsert(0,idif(m,1),r),2,r+1,m)

# define              maidif(M,N)  maisum(M,maineg(N))
# define              mardif(M,N)  marsum(M,marneg(N))
# define           mamsdif(m,M,N)  mamssum(m,M,mamsneg(m,N))
# define           mamidif(m,M,N)  mamisum(m,M,mamineg(m,N))
# define           mapidif(r,M,N)  mapisum(r,M,mapineg(r,N))
# define           maprdif(r,M,N)  maprsum(r,M,maprneg(r,N))
# define        mapmsdif(r,m,M,N)  mapmssum(r,m,M,mapmsneg(r,m,N))
# define        mapmidif(r,m,M,N)  mapmisum(r,m,M,mapmineg(r,m,N))

# define               manrcol(M)  llength(lfirst(M))
# define               manrrow(M)  llength(M)
# define              isnullma(M)  ismaeqel(M,0)
  
# define                 ismai(M)  isma_(M,isint,0,0,0)
# define                 ismar(M)  isma_(M,israt,0,0,0)
# define              ismams(m,M)  isma_(M,isms,1,m,0)
# define              ismami(m,M)  isma_(M,ismi,1,m,0)
# define              ismapi(r,M)  isma_(M,ispi,1,r,0)
# define              ismapr(r,M)  isma_(M,ispr,1,r,0)
# define           ismapms(r,m,M)  isma_(M,ispms,2,r,m)
# define           ismapmi(r,m,M)  isma_(M,ispmi,2,r,m)

# define            ismap( r, M )  isma_( M, ispol, 1, r, 0 )
# define           ismadp( r, M )  isma_( M, isdpol, 1, r, 0 )

# define          ismadpi( r, M )  isma_( M, isdpi, 1, r, 0 )
# define          ismadpr( r, M )  isma_( M, isdpr, 1, r, 0 )
# define      ismadpms( r, m, M )  isma_( M, isdpms, 2, r, m )

# define      masetel(M,m,n,el)  lsfirst(lreduct(lfirst(lreduct(M,m-1)),n-1),el)
# define         maselel(M,m,n)  lfirst(lreduct(lfirst(lreduct(M,m-1)),n-1))
   
# define              maicons1(n)  maconsdiag(n,1)
# define              marcons1(n)  maconsdiag(n,list2(1,1))
# define           mamscons1(m,n)  maconsdiag(n,1)
# define           mamicons1(m,n)  maconsdiag(n,1)
# define           mapicons1(r,n)  maconsdiag(n,pvinsert(0,1,r))
# define           maprcons1(r,n)  maconsdiag(n,pvinsert(0,list2(1,1),r))
# define        mapmscons1(r,m,n)  maconsdiag(n,pvinsert(0,1,r))
# define        mapmicons1(r,m,n)  maconsdiag(n,pvinsert(0,1,r))

# define                 isvec(V)  ( islist(V) && V!=_0 )
# define                isveci(V)  isvec_(V,isint,0,0,0)
# define                isvecr(V)  isvec_(V,israt,0,0,0)
# define             isvecms(m,A)  ( islistms(m,A) && A!=_0 )
# define             isvecpi(r,V)  isvec_(V,ispi,1,r,0)
# define             isvecpr(r,V)  isvec_(V,ispr,1,r,0)
# define          isvecpms(r,m,V)  isvec_(V,ispms,2,r,m)

# define           isvecp( r, V )  isvec_( V, ispol, 1, r, 0 )
# define          isvecdp( r, V )  isvec_( V, isdpol, 1, r, 0 )

# define         isvecdpi( r, V )  isvec_( V, isdpi, 1, r, 0 )
# define         isvecdpr( r, V )  isvec_( V, isdpr, 1, r, 0 )
# define     isvecdpms( r, m, V )  isvec_( V, isdpms, 2, r, m )

# define             fgetveci(pf)  fgetvec(pf,fgeti,0,0,0,0)
# define             fgetvecr(pf)  fgetvec(pf,fgetr,0,0,0,0)
# define          fgetvecms(m,pf)  fgetvec(pf,fgetms,1,m,0,0)
# define          fgetvecmi(m,pf)  fgetvec(pf,fgetmi,1,m,0,0)
# define       fgetvecpi(r,VL,pf)  fgetvec(pf,fgetpi,2,r,VL,0)
# define       fgetvecpr(r,VL,pf)  fgetvec(pf,fgetpr,2,r,VL,0)
# define    fgetvecpms(r,m,VL,pf)  fgetvec(pf,fgetpms,3,r,m,VL)
# define    fgetvecpmi(r,m,VL,pf)  fgetvec(pf,fgetpmi,3,r,m,VL)

# define                getveci()  fgetveci(stdin)
# define                getvecr()  fgetvecr(stdin)
# define              getvecms(m)  fgetvecms(m,stdin)
# define              getvecmi(m)  fgetvecmi(m,stdin)
# define           getvecpi(r,VL)  fgetvecpi(r,VL,stdin)
# define           getvecpr(r,VL)  fgetvecpr(r,VL,stdin)
# define        getvecpms(r,m,VL)  fgetvecpms(r,m,VL,stdin)
# define        getvecpmi(r,m,VL)  fgetvecpmi(r,m,VL,stdin)

# define           fputveci(V,pf)  fputvec(V,pf,fputi,0,0,0,0)
# define           fputvecr(V,pf)  fputvec(V,pf,fputr,0,0,0,0)
# define        fputvecms(m,V,pf)  fputvec(V,pf,fputms,1,m,0,0)
# define        fputvecmi(m,V,pf)  fputvec(V,pf,fputmi,1,m,0,0)
# define     fputvecpi(r,V,VL,pf)  fputvec(V,pf,fputpi,2,r,VL,0)
# define     fputvecpr(r,V,VL,pf)  fputvec(V,pf,fputpr,2,r,VL,0)
# define  fputvecpms(r,m,V,VL,pf)  fputvec(V,pf,fputpms,3,r,m,VL)
# define  fputvecpmi(r,m,V,VL,pf)  fputvec(V,pf,fputpmi,3,r,m,VL)

# define               putveci(V)  fputveci(V,stdout)
# define               putvecr(V)  fputvecr(V,stdout)
# define            putvecms(m,V)  fputvecms(m,V,stdout)
# define            putvecmi(m,V)  fputvecmi(m,V,stdout)
# define         putvecpi(r,V,VL)  fputvecpi(r,V,VL,stdout)
# define         putvecpr(r,V,VL)  fputvecpr(r,V,VL,stdout)
# define      putvecpms(r,m,V,VL)  fputvecpms(r,m,V,VL,stdout)
# define      putvecpmi(r,m,V,VL)  fputvecpmi(r,m,V,VL,stdout)

# define             veclength(V)  llength(V)

# define             vecisum(U,V)  vecsum(U,V,isum,0,0,0)
# define             vecrsum(U,V)  vecsum(U,V,rsum,0,0,0)
# define          vecmssum(m,U,V)  vecsum(U,V,mssumf,1,m,0)
# define          vecmisum(m,U,V)  vecsum(U,V,misumf,1,m,0)
# define          vecpisum(r,U,V)  vecsum(U,V,pisum,1,r,0)
# define          vecprsum(r,U,V)  vecsum(U,V,prsum,1,r,0)
# define       vecpmssum(r,m,U,V)  vecsum(U,V,pmssum,2,r,m)
# define       vecpmisum(r,m,U,V)  vecsum(U,V,pmisum,2,r,m)

# define               vecineg(V)  vecneg(V,ineg,0,0,0)
# define               vecrneg(V)  vecneg(V,rneg,0,0,0)
# define            vecmsneg(m,V)  vecneg(V,msnegf,1,m,0)
# define            vecmineg(m,V)  vecneg(V,minegf,1,m,0)
# define            vecpineg(r,V)  vecneg(V,pineg,1,r,0)
# define            vecprneg(r,V)  vecneg(V,prneg,1,r,0)
# define         vecpmsneg(r,m,V)  vecneg(V,pmsneg,2,r,m)
# define         vecpmineg(r,m,V)  vecneg(V,pmineg,2,r,m)

# define             vecidif(U,V)  vecisum(U,vecineg(V))
# define             vecrdif(U,V)  vecrsum(U,vecrneg(V))
# define          vecmsdif(m,U,V)  vecmssum(m,U,vecmsneg(m,V))
# define          vecmidif(m,U,V)  vecmisum(m,U,vecmineg(m,V))
# define          vecpidif(r,U,V)  vecpisum(r,U,vecpineg(r,V))
# define          vecprdif(r,U,V)  vecprsum(r,U,vecprneg(r,V))
# define       vecpmsdif(r,m,U,V)  vecpmssum(r,m,U,vecpmsneg(r,m,V))
# define       vecpmidif(r,m,U,V)  vecpmisum(r,m,U,vecpmineg(r,m,V))

# define	 madelsrc(pM,I,J)  (madelsr(pM,I),madelsc(pM,J))

# define             mamsnsb(p,A)  (mamsssle(p,A,_0,&MANUMMY,&MADUMMY),MADUMMY)


extern obj MADUMMY, MANUMMY;
