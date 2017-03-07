#ifndef __POL2__
#include <_list.h>
#include <_arith1.h>
#include <_ec1.h>
#include <_pol1.h>
#include <_matr1.h>
#include <_pol2.h>
#endif
#define __ARITH2__

#define gfel                		int
#define nfel  				int
#define pfel  				int

#define gfsdif(p, AL, a, b)  		pmsdif(1, p, a, b)
#define gfsneg(p, AL, a)  		pmsneg(1, p, a)
#define gfssum(p, AL, a, b)  		pmssum(1, p, a, b)

#define nfsdif(F, a, b)  		prdif(1, a, b)
#define nfsneg(F, a)  			prneg(1, a)
#define nfssum(F, a, b)  		prsum(1, a, b)

#define getgfsel(p, AL, V)  		fgetgfsel(p, AL, V, stdin)
#define getnfels(F, V)  		fgetnfels(F, V, stdin)
#define getnfel(F, V)  			fgetnfel(F, V, stdin)

#define putgfsel(p, AL, a, V)  		fputgfsel(p, AL, a, V, stdout)
#define putnfels(F, a, V)  		fputnfels(F, a, V, stdout)
#define putnfel(F, a, V)  		fputnfel(F, a, V, stdout)
#define putonfel(F, a, V)  		fputonfel(F, a, V, stdout)

#define itonf(A)  			((A) == 0? 0 : list3(1, 0, A))

#define pfdif(p, a, b)  		pfsum(p, a, pfneg(p, b))
#define pfaval(p, a)  			lsecond(a)
#define pfquot(p, a, b)  		((a) ? pfprod(p, a, pfinv(p, b)) : 0)
#define putpfel(p, a)  			fputpfel(p, a, stdout)
#define utspfel(p, a)  			fputspfel(p, a, stdout)
#define getpfel(p)  			fgetpfel(p, stdin)
#define getspfel(p)  			fgetspfel(p, stdin)

#define getgf2el(G, V)  		fgetgf2el(G, V, stdin)
#define gf2dif(G, a, b)  		gf2sum(G, a, b)
#define gf2neg(G, a)  			(a)
#define isgf2el(G, a)  			((!a || isudpm2sb(a) && lfirst(a)<lfirst(G)) ? (1) : (0))
#define putgf2el(G, a, V)  		fputgf2el(G, a, V, stdout)

#define gf2eltogfsel(G, a)  		dptop(1, gf2eltoudpm2(G, a))

#define getgf2elb(G)  			fgetgf2elb(G, stdin)
#define putgf2elb(a)  			fputgf2elb(a, stdout)

#define sbtoudpm2(a)  			gf2eltoudpm2(POLDUMMY, a)

#define getqnfel(D)  			fgetqnfel(D, stdin)
#define iqnfdif(D, a, b)  		qnfisum(D, qnfneg(D, b), a)
#define isqnfint(D, a)  		((!a || !lsecond(a) && (lfirst(a) == 1)) ? 1 : 0)
#define isqnfone(D, a)  		((!lsecond(a) && (lfirst(a) == 1) && (lthird(a) == 1)) ? 1 : 0)
#define isqnfrat(D, a)  		((!a || !lsecond(a)) ? 1 : 0)
#define itoqnf(D, a)  			(a ? list3(1, 0, a) : 0)
#define putqnfel(D, a)  		fputqnfel(D, a, stdout)
#define putqnffel(D, L)  		fputqnffel(D, L, stdout)
#define putqnfid(D, A)  		fputqnfid(D, A, stdout)
#define qnfdif(D, a, b)  		qnfsum(D, a, qnfneg(D, b))
#define qnfidif(D, a, b)  		qnfisum(D, a, ineg(b))
#define qnfidone(D)  			((m4hom(D) == 1) ? list4(1, 2, 1, 2) : list4(1, 1, 0, 1))
#define qnfquot(D, a, b)  		(b ? qnfprod(D, a, qnfinv(D, b)) : ERROR)
#define qnfrdif(D, a, b)  		qnfrsum(D, a, rneg(b))
#define qnfrquot(D, a, b)  		(b ? qnfrprod(D, a, rinv(b)) : ERROR)
#define rqnfdif(D, a, b)  		qnfrsum(D, qnfneg(D, b), a)
#define rtoqnf(D, A)  			(A ? list3(lsecond(A), 0, lfirst(A)) : 0)

#define  gf2nbquot(G, MT, a, b)  	gf2nbprod(G, MT, a, gf2nbinv(G, MT, b))

