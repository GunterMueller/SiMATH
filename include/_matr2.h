#ifndef __EC2__
#include <_list.h>
#include <_arith1.h>
#include <_ec1.h>
#include <_pol1.h>
#include <_matr1.h>
#include <_pol2.h>
#include <_arith2.h>
#include <_ec2.h>
#endif
#define __MATR2__

int             isgfsel();
int             isnfel();
int             isnfels();
int             fgetgfsel();
int             fputgfsel();
int             fgetnfel();
int             fputnfel();
int             fgetnfels();
int             fputnfels();

int             gfsnegf();
int             gfssumf();
int             nfsnegf();
int             nfssumf();

int             nfneg();
int             nfsum();
int             gfsprod();
int             nfprod();
int             nfsprod();

int             fgetgf2el();
int             fputgf2el();
int             gf2prod();
int             gf2sumf();
int             islistgf2();

#define maihermltne(A) 			maiherm(A, 1)
#define maihermltpe(A) 			maiherm(A, 0)
#define maiev(M) 			maievifcp(M, &MADUMMY)
#define mamsev(p, M)  			mamsevifcp(p, M, &MADUMMY)
#define mamiev(p, M)  			mamievifcp(p, M, &MADUMMY)
#define marev(M)      			marevifcp(M, &MADUMMY)

#define ismagfs(p, AL, M)  		isma_(M, isgfsel, 2, p, AL)
#define ismanf(F, M)  			isma_(M, isnfel, 1, F, 0)
#define ismanfs(F, M)  			isma_(M, isnfels, 1, F, 0)

#define isvecgfs(p, AL, A)  		(islistgfs(p, AL, A) && A!=_0)
#define isvecnf(F, V)  			isvec_(V, isnfel, 1, F, 0)
#define isvecnfs(F, V)  		isvec_(V, isnfels, 1, F, 0)

#define magfscons1(p, AL, n)  		maconsdiag(n, list2(0, 1))
#define manfcons1(F, n)  		maconsdiag(n, list3(1, 0, 1))
#define manfscons1(F, n)  		maconsdiag(n, list2(0, list2(1, 1)))

#define fgetmagfs(p, AL, V, pf) 	fgetma(pf, fgetgfsel, 3, p, AL, V)
#define getmagfs(p, AL, V)  		fgetmagfs(p, AL, V, stdin)

#define fputmagfs(p, AL, M, V, pf)  	fputma(M, pf, fputgfsel, 3, p, AL, V)
#define putmagfs(p, AL, M, V)  		fputmagfs(p, AL, M, V, stdout)

#define fgetvecgfs(p, AL, V, pf)  	fgetvec(pf, fgetgfsel, 3, p, AL, V)
#define getvecgfs(p, AL, V)  		fgetvecgfs(p, AL, V, stdin)

#define fputvecgfs(p, AL, V, VL, pf)  	fputvec(V, pf, fputgfsel, 3, p, AL, VL)
#define putvecgfs(p, AL, V, VL)  	fputvecgfs(p, AL, V, VL, stdout)

#define fgetmanf(F, VL, pf)  		fgetma(pf, fgetnfel, 2, F, VL, 0)
#define getmanf(F, VL)  		fgetmanf(F, VL, stdin)

#define fgetmanfs(F, VL, pf)  		fgetma(pf, fgetnfels, 2, F, VL, 0)
#define getmanfs(F, VL)  		fgetmanfs(F, VL, stdin)

#define fputmanf(F, M, VL, pf)  	fputma(M, pf, fputnfel, 2, F, VL)
#define putmanf(F, M, VL)  		fputmanf(F, M, VL, stdout)

#define fputmanfs(F, M, VL, pf)  	fputma(M, pf, fputnfels, 2, F, VL, 0)
#define putmanfs(F, M, VL)  		fputmanfs(F, M, VL, stdout)

#define fgetvecnf(F, VL, pf)  		fgetvec(pf, fgetnfel, 2, F, VL, 0)
#define getvecnf(F, VL)  		fgetvecnf(F, VL, stdin)

#define fgetvecnfs(F, VL, pf)  		fgetvec(pf, fgetnfels, 2, F, VL, 0)
#define getvecnfs(F, VL)  		fgetvecnfs(F, VL, stdin)

#define fputvecnf(F, V, VL, pf)  	fputvec(V, pf, fputnfel, 2, F, VL)
#define putvecnf(F, V, VL)  		fputvecnf(F, V, VL, stdout)

#define fputvecnfs(F, V, VL, pf)  	fputvec(V, pf, fputnfels, 2, F, VL, 0)
#define putvecnfs(F, V, VL)  		fputvecnfs(F, V, VL, stdout)

#define magfsneg(p, AL, M)  		maneg(M, gfsnegf, 2, p, AL)
#define vecgfsneg(p, AL, V)  		vecneg(V, gfsnegf, 2, p, AL)

#define manfneg(F, M)  			maneg(M, nfneg, 1, F, 0)
#define manfsneg(F, M)  		maneg(M, nfsnegf, 1, F, 0)

#define vecnfneg(F, V)  		vecneg(V, nfneg, 1, F, 0)
#define vecnfsneg(F, V)  		vecneg(V, nfsnegf, 1, F, 0)

#define magfssum(p, AL, M, N)  		masum(M, N, gfssumf, 2, p, AL)
#define vecgfssum(p, AL, U, V)  	vecsum(U, V, gfssumf, 2, p, AL)

#define magfsdif(p, AL, M, N)  		magfssum(p, AL, M, magfsneg(p, AL, N))
#define vecgfsdif(p, AL, U, V)  	vecgfssum(p, AL, U, vecgfsneg(p, AL, V))

#define manfsum(F, M, N)  		masum(M, N, nfsum, 1, F, 0)
#define manfssum(F, M, N)  		masum(M, N, nfssumf, 1, F, 0)

#define manfdif(F, M, N)  		manfsum(F, M, manfneg(F, N))
#define manfsdif(F, M, N)  		manfssum(F, M, manfsneg(F, N))

#define vecnfsum(F, U, V)  		vecsum(U, V, nfsum, 1, F, 0)
#define vecnfssum(F, U, V)  		vecsum(U, V, nfssumf, 1, F, 0)

#define vecnfdif(F, U, V)  		vecnfsum(F, U, vecnfneg(F, V))
#define vecnfsdif(F, U, V)  		vecnfssum(F, U, vecnfsneg(F, V))

#define magfsprod(p, AL, M, N)  	maprod(M, N, gfsprod, gfssumf, 2, p, AL)
#define manfprod(F, M, N)  		maprod(M, N, nfprod, nfsum, 1, F, 0)
#define manfsprod(F, M, N)  		maprod(M, N, nfsprod, nfssumf, 1, F, 0)

#define magfsvecmul(p, AL, A, x)  	mavecmul(A, x, gfsprod, gfssumf, 2, p, AL)
#define manfvecmul(F, A, x)  		mavecmul(A, x, nfprod, nfsum, 1, F, 0)
#define manfsvecmul(F, A, x)  		mavecmul(A, x, nfsprod, nfssumf, 1, F, 0)

#define getmagf2(G, VL)                 fgetma(stdin, fgetgf2el, 2, G, VL)
#define fgetmagf2(G, VL, pf)            fgetma(pf, fgetgf2el, 2, G, VL)
#define putmagf2(G, M, VL)              fputma(M, stdout, fputgf2el, 2, G, VL)
#define fputmagf2(G, M, VL, pf)         fputma(M, pf, fputgf2el, 2, G, VL) 
#define magf2sum(G, M, N)               masum(M, N, gf2sumf, 1, G)
#define magf2dif(G, M, N)               magf2sum(G, M, N)
#define magf2prod(G, M, N)              maprod(M, N, gf2prod, gf2sumf, 1, G)
#define magf2neg(G, M)                  (M)
#define isvecgf2(G, V)                  (islistgf2(G, V) && V!=_0)
#define getvecgf2(G, VL)                fgetvec(stdin, fgetgf2el, 2, G, VL)
#define fgetvecgf2(G, VL, pf)           fgetvec(pf, fgetgf2el, 2, G, VL)
#define putvecgf2(G, V, VL)             fputvec(V, stdout, fputgf2el, 2, G, VL)
#define fputvecgf2(G, V, VL, pf)        fputvec(V, pf, fpugf2el, 2, G, VL)
#define vecgf2sum(G, U, V)              vecsum(U, V, gf2sumf, 1, G)
#define vecgf2neg(G, V)                 (V)
#define vecgf2dif(G, U, V)              vecgf2sum(G, U, V)
#define magf2vecmul(G, M, V)            mavecmul(M, V, gf2prod, gf2sumf, 1, G)
#define magf2cons1(G, n)                maconsdiag(n, list2(0, 1))
