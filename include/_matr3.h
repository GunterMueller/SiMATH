#ifndef __EC3__
#include <_list.h>
#include <_arith1.h>
#include <_ec1.h>
#include <_pol1.h>
#include <_matr1.h>
#include <_pol2.h>
#include <_arith2.h>
#include <_ec2.h>
#include <_matr2.h>
#include <_pol3.h>
#include <_arith3.h>
#include <_ec3.h>
#endif
#define __MATR3__

int             fgetrfr();
int             fgetrfmsp1();
int             fputrfr();
int             isrfr();
int             isrfmsp1();
int             rfrneg();
int             rfmsp1neg();
int             rfrsum();
int             rfmsp1sum();
int             rfrprod();
int             rfmsp1prod();

int             pvinsert();

int             fgetpgfs();
int             fputpgfs();
int             pgfsneg();
int             pgfssum();
int             pgfsprod();

int             fgetpnf();
int             fputpnf();
int             pnfprod();
int             pnfsum();
int             pnfneg();

int             ispgfs();

int             mapnfdet();
int             mapgfsdet();

int             fgetpgf2();
int             fputpgf2();
int             pgf2sum();
int             pgf2prod();
int             islistgf2();
int             ispgf2();
int             mapgf2det();
int             pvinsert();

#define fgetmarfr(r, V, pf)  		fgetma(pf,fgetrfr,2,r,V,0)
#define fgetmarfmsp1(p, V, pf)  	fgetma(pf,fgetrfmsp1,2,p,V,0)

#define getmarfr(r, V)  		fgetmarfr(r,V,stdin)
#define getmarfmsp1(p, V)  		fgetmarfmsp1(p,V,stdin)

#define fputmarfr(r, M, V, pf)  	fputma(M,pf,fputrfr,2,r,V,0)
#define fputmarfmsp1(p, M, V, pf)  	fputma(M,pf,fputrfr,2,1,V,0)

#define putmarfr(r, M, V)  		fputmarfr(r, M,V,stdout)
#define putmarfmsp1(p, M, V)  		fputmarfmsp1(p, M,V,stdout)

#define ismarfr(r, M)  			isma_(M,isrfr,1,r,0)
#define ismarfmsp1(p, M)  		isma_(M,isrfmsp1,1,p,0)

#define marfrneg(r, M)  		maneg(M,rfrneg,1,r,0)
#define marfmsp1neg(p, M)  		maneg(M,rfmsp1neg,1,p,0)

#define marfrsum(r,M, N)  		masum(M, N,rfrsum,1,r,0)
#define marfmsp1sum(p,M, N)  		masum(M, N,rfmsp1sum,1,p,0)

#define marfrdif(r,M, N)  		marfrsum(r,M,marfrneg(r, N))
#define marfmsp1dif(p,M, N)  		marfmsp1sum(p,M,marfmsp1neg(p, N))

#define marfrprod(r,M, N)  		maprod(M, N,rfrprod,rfrsum,1,r,0)
#define marfmsp1prod(p,M, N)  		maprod(M, N,rfmsp1prod,rfmsp1sum,1,p,0)

#define marfrcons1(r, N)  		maconsdiag(N,rtorfr(r,itor(1)))
#define marfmsp1c1(p, N)  		(MADUMMY=list2(0,1), maconsdiag(N,list2(MADUMMY,MADUMMY)))

#define marfrvecmul(r,A,x)  		mavecmul(A,x,rfrprod,rfrsum,1,r,0)
#define marfmsp1vmul(p,A,x)  		mavecmul(A,x,rfmsp1prod,rfmsp1sum,1,p,0)

#define fgetvecrfr(r,VL,pf)  		fgetvec(pf,fgetrfr,2,r,VL,0)
#define fgetvrfmsp1(p,VL,pf)  		fgetvec(pf,fgetrfmsp1,2,p,VL,0)

#define fputvecrfr(r,V,VL,pf)  		fputvec(V,pf,fputrfr,2,r,VL,0)
#define fputvrfmsp1(p,V,VL,pf)  	fputvec(V,pf,fputrfr,2,1,VL,0)

#define getvecrfr(r,VL)  		fgetvecrfr(r,VL,stdin)
#define getvecrfmsp1(p,VL)  		fgetvrfmsp1(p,VL,stdin)

#define putvecrfr(r,V,VL)  		fputvecrfr(r,V,VL,stdout)
#define putvecrfmsp1(p,V,VL)  		fputvrfmsp1(p,V,VL,stdout)

#define isvecrfr(r,V)  			isvec_(V,isrfr,1,r,0)
#define isvecrfmsp1(p,V)  		isvec_(V,isrfmsp1,1,p,0)

#define vecrfrneg(r,V)  		vecneg(V,rfrneg,1,r,0)
#define vecrfmsp1neg(p,V)  		vecneg(V,rfmsp1neg,1,p,0)

#define vecrfrsum(r,U,V)  		vecsum(U,V,rfrsum,1,r,0)
#define vecrfmsp1sum(p,U,V)  		vecsum(U,V,rfmsp1sum,1,p,0)

#define vecrfrdif(r,U,V)  		vecrfrsum(r,U,vecrfrneg(r,V))
#define vecrfmsp1dif(p,U,V)  		vecrfmsp1sum(p,U,vecrfmsp1neg(p,V))

#define magfschpol(p, AL, M)  		machpolspec(M, mapgfsdet, list2(0, p-1), 3, 1, p, AL, 0, 0)
#define mapgfschpol(r, p, AL, M)  	machpolspec(M, mapgfsdet, pvinsert(0, list2(0,p-1), r), 3, r+1, p, AL, 0, 0)
#define manfchpol(F, M)  		machpolspec(M, mapnfdet, list3(1, 0, -1), 2, 1, F, 0, 0, 0)
#define mapnfchpol(r, F, M)  		machpolspec(M, mapnfdet, pvinsert(0, list3(1, 0, -1), r), 2, r+1, F, 0, 0, 0)

#define	ismapgfs(r, p, AL, M)  		ismaspec_(M, ispgfs, 3, r, p, AL, 0, 0)
#define	isvecpgfs(r, p, AL, V)  	isvecspec_(V, ispgfs, 3, r, p, AL, 0, 0)

#define	mapgfscons1(r, p, AL, n)  	maconsdiag(n, pvinsert(0, 1, r+1))
#define	mapnfcons1(r, F, n)  		maconsdiag(n, pvinsert(0, list3(1, 0, 1), r))

#define fgetmapgfs(r, p, AL, V, Vgfs, pf) fgetmaspec(pf, fgetpgfs, 5, r, p, AL, V, Vgfs, 0, 0, 0)
#define getmapgfs(r, p, AL, V, Vgfs)  	fgetmapgfs(r, p, AL, V, Vgfs, stdin)
#define fgetmapnf(r, F, V, Vnf, pf)  	fgetmaspec(pf, fgetpnf, 4, r, F, V, Vnf, 0, 0, 0, 0)
#define getmapnf(r, F, V, Vnf)  	fgetmapnf(r, F, V, Vnf, stdin)

#define fputmapgfs(r, p, AL, M, V, Vgfs, pf) fputmaspec(M, pf, fputpgfs, 5, r, p, AL, V, Vgfs, 0, 0, 0)
#define putmapgfs(r, p, AL, M, V, Vgfs) fputmapgfs(r, p, AL, M, V, Vgfs, stdout)
#define fputmapnf(r, F, M, V, Vnf, pf)  fputmaspec(M, pf, fputpnf, 4, r, F, V, Vnf, 0, 0, 0, 0)
#define putmapnf(r, F, M, V, Vnf)  	fputmapnf(r, F, M, V, Vnf, stdout)

#define fgetvpgfs(r, p, AL, V, Vgfs, pf) fgetvecspec(pf, fgetpgfs, 5, r, p, AL, V, Vgfs, 0, 0, 0)
#define getvpgfs(r, p, AL, V, Vgfs)  	fgetvpgfs(r, p, AL, V, Vgfs, stdin)
#define fgetvecpnf(r, F, VL, VLnf, pf) 	fgetvecspec(pf, fgetpnf, 4, r, F, VL, VLnf, 0, 0, 0, 0)
#define getvecpnf(r, F, VL, VLnf)  	fgetvecpnf(r, F, VL, VLnf, stdin)

#define fputvpgfs(r, p, AL, W, V, Vgfs, pf) fputvecspec(W, pf, fputpgfs, 5, r, p, AL, V, Vgfs, 0, 0, 0)
#define putvpgfs(r, p, AL, W, V, Vgfs)  fputvpgfs(r, p, AL, W, V, Vgfs, stdout)
#define fputvecpnf(r, F, W, VL, VLnf, pf)  fputvecspec(W, pf, fputpnf, 4, r, F, VL, VLnf, 0, 0, 0, 0)
#define putvecpnf(r, F, W, VL, VLnf)  	fputvecpnf(r, F, W, VL, VLnf, stdout)

#define mapgfsneg(r, p, AL, M)  	manegspec(M, pgfsneg, 3, r, p, AL, 0, 0)
#define vecpgfsneg(r, p, AL, V)  	vecnegspec(V, pgfsneg, 3, r, p, AL, 0, 0)
#define	mapnfneg(r, F, M)  		manegspec(M, pnfneg, 2, r, F, 0, 0, 0)
#define	vecpnfneg(r, F, U)  		vecnegspec(U, pnfneg, 2, r, F, 0, 0, 0)

#define mapgfssum(r, p, AL, M, N)  	masumspec(M, N, pgfssum, 3, r, p, AL, 0, 0)
#define vecpgfssum(r, p, AL, U, V)  	vecsumspec(U, V, pgfssum, 3, r, p, AL, 0, 0)
#define	mapnfsum(r, F, M, N)  		masumspec(M, N, pnfsum, 2, r, F, 0, 0, 0)
#define	vecpnfsum(r, F, U, V)  		vecsumspec(U, V, pnfsum, 2, r, F, 0, 0, 0)

#define mapgfsdif(r, p, AL, M, N)  	mapgfssum(r, p, AL, M, mapgfsneg(r, p, AL, N))
#define	vecpgfsdif(r, p, AL, U, V)  	vecpgfssum(r, p, AL, U, vecpgfsneg(r, p, AL, V))
#define	mapnfdif(r, F, M, N)  		mapnfsum(r, F, M, mapnfneg(r, F, N))
#define	vecpnfdif(r, F, U, V)  		vecpnfsum(r, F, U, vecpnfneg(r, F, V))

#define mapgfsprod(r, p, AL, M, N)  	maprodspec(M, N, pgfsprod, pgfssum, 3, r, p, AL, 0, 0)
#define	mapnfprod(r, F, M, N)  		maprodspec(M, N, pnfprod, pnfsum, 2, r, F, 0, 0, 0)
#define mapgfsvmul(r, p, AL, A, x)  	mavmulspec(A, x, pgfsprod, pgfssum, 3, r, p, AL, 0, 0)
#define	mapnfvecmul(r, F, A, x)  	mavmulspec(A, x, pnfprod, pnfsum, 2, r, F, 0, 0, 0)

#define ismapgf2(r, G, M)               ismaspec_(M, ispgf2, 2, r, G, 0, 0,0)

#define getmapgf2(r, G, VL, Vgf2)       fgetmapgf2(r, G, VL, Vgf2, stdin)
#define fgetmapgf2(r, G, VL, Vgf2, pf)  fgetmaspec(pf, fgetpgf2, 4, r, G, VL, Vgf2, 0, 0, 0, 0)

#define putmapgf2(r, M, G, VL, Vgf2)    fputmapgf2(r, M, G, VL, Vgf2, stdout)
#define fputmapgf2(r, M, G, VL, Vgf2, pf) fputmaspec(M, pf, fputpgf2, 4, r, G, VL, Vgf2, 0, 0, 0, 0)
#define mapgf2sum(r, G, M, N)           masumspec(M, N, pgf2sum, 2, r, G, 0, 0)
#define mapgf2dif(r, G, M, N)           mapgf2sum(r, G, M, N)
#define mapgf2prod(r, G, M, N)          maprodspec(M, N, pgf2prod, pgf2sum, 2, r, G, 0, 0, 0)
#define mapgf2neg(r, G, M)              (M)
#define isvecpgf2(r, G, V)              isvecspec_(V, ispgf2, 2, r, G, 0, 0, 0)
#define getvpgf2(r, G, VL, Vgf2)        fgetvecspec(stdin, fgetpgf2, 4, r, G, VL, Vgf2, 0, 0, 0)
#define fgetvpgf2(r, G, VL, Vgf2, pf)   fgetvecspec(pf, fgetpgf2, 4, r, G, VL, Vgf2, 0, 0, 0, 0)
#define putvpgf2(r, G, V, VL, Vgf2)     fputvpgf2(r, G, V, VL, Vgf2, stdout)
#define fputvpgf2(r, G, V, VL, Vgf2, pf) fputvecspec(V, pf, fputpgf2, 4, r, G, VL, Vgf2, 0, 0, 0, 0)
#define vecpgf2sum(r, G, U, V)          vecsumspec(U, V, pgf2sum, 2, r, G, 0, 0, 0)
#define vecpgf2neg(r, G, V)             (V)
#define vecpgf2dif(r, G, U, V)          vecpgf2sum(r, G, U, V)
#define mapgf2vmul(r, G, M, V)          mavmulspec(M, V, pgf2prod, pgf2sum, 2, r, G, 0, 0, 0)
#define mapgf2cons1(r,G, n)             maconsdiag(n, pvinsert(0, 1, r+1))
#define magf2chpol(G, M)                machpolspec(M, mapgf2det, list2(0, 1), 2, 1, G, 0, 0, 0)
#define mapgf2chpol(r, G, M)            machpolspec(M, mapgf2det, pvinsert(0, list2(0, 1), r), 2, r+1, G, 0, 0, 0)
