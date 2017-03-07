/*	961201	POW2[]	entfernt	*/
#ifndef SIMATH_arith1_H
#define SIMATH_arith1_H

#ifndef __LIST__
#include <_list.h>
#endif
#define __ARITH1__

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#ifndef PI
#define PI M_PI
#endif

#define         complex  int
#define        floating  int
#define             rat  int
#define             cyc  int

#define          BSMALL  (1<<HALF_WIDTH)
#define           BLOG2  FULL_WIDTH
#if BLOG2==30
#define          BLOG10  9
#define          DECBAS  1000000000
#else
#error "_arith1.h should be modified. Report this error."
#endif

#define NOTPRIME	0
#define ISAPRIME	1
#define UNKNOWN		(-1)
#define ISAPPRIME	2

#define          geti()  fgeti(stdin)
#define         getli()  fgetli(stdin)
#define         getlr()  fgetlr(stdin)
#define        getmi(M)  fgetmi(M,stdin)
#define        getms(m)  fgetms(m,stdin)
#define          getr()  fgetr(stdin)
#define         getsi()  fgetsi(stdin)
#define    putcn(a,v,n)  fputcn(a,v,n,stdout)
#define         puti(A)  fputi(A,stdout)
#define      putifel(L)  fputifel(L,stdout)
#define        putli(L)  fputli(L,stdout)
#define      putmi(M,A)  fputmi(M,A,stdout)
#define      putms(m,a)  fputms(m,a,stdout)
#define         putr(R)  fputr(R,stdout)
#define      putrd(R,n)  fputrd(R,n,stdout)
#define        putsi(n)  fputsi(n,stdout)


#define         sabs(x)  abs(x)
#define        seven(n)  (!((n) & 1))
#define       smax(a,b)  ((a)<(b) ? (b) : (a))
#define       smin(a,b)  ((a)>(b) ? (b) : (a))
#define         sodd(n)  ((n) & 1)
#define        ssign(x)  ((x)<0 ? -1 : ((x)>0))
#define        sexp(a,b) ((b)? (int)floor(pow((double)(a),(double)(b))+0.5) :1)

#define        flabs(A)  (flsign(A)<0 ? flneg(A) : (A))
/* #define      fldif(a,b)  flsum(a,flneg(b)) */
 /* a */
#define         flerr()  ( FL_STZ = ST_INDEX, setjmp( FL_JMP ) )
#define       flexpo(A)  lfirst(A)
#define       flmant(A)  ((A) ? (lred(lred(A))==_0 ? lfirst(lred(A)) : lred(A)) : 0)
#define       flsign(A)  ((A) ? ssign( lsecond(A) ) : 0)
#define       fltofl(A)  ((A) ? flcons( lred(A),flexpo(A),llength( lred(A) ) ) : 0)
#define  fltrig( F, A )  flPAFfu( F, 1, (A), 0 )
#define         getfl()  fgetfl(stdin)
#define        itofl(N)  ((N) ? ( issingle(N) ? list2(0,N) : flcons(N,0,llength(N)) ) : 0)
 /* N */
#define      putfl(b,A)  fputfl((b),(A),stdout)
#define  putflfx(A,B,C)  fputflfx(A,B,C,stdout)

#define     ccomp(a, b)  iscinball(a, b, 0)
/* #define      ccri(r, i)  ((((r)|(i)) == 0) ? 0 : list2(r, i)) */
#define        cimag(a)  ((a == 0) ? 0 : lsecond(a))
#define        creal(a)  ((a == 0) ? 0 : lfirst(a))

#define fltoc(N) ccri(N,0)
#define itoc(N) ccri(itofl(N),0) 

#define     putfactl(L)  fputfactl( L, stdout )

#define         iabs(A)  (isign(A)<0 ? ineg(A):(A))
#define     isquot(A,b)  (isqrem(A,b,&NUM,&DUM),NUM)
#define      isrem(A,b)  (isqrem(A,b,&DUM,&NUM),NUM)
#define       imax(A,B)  (icomp(A,B)<0 ? (B):(A))
#define       imin(A,B)  (icomp(A,B)<0 ? (A):(B))
#define         iodd(A)  ( !ieven( A ) )
#define      iquot(A,B)  (iqrem(A,B,&NUM,&DUM),NUM)
#define       irem(A,B)  (iqrem(A,B,&DUM,&NUM),NUM)
#define     itrunc(A,n)  (n<0 ? ip2prod(A,-n):ip2quot(A,n))

#define       getbits()  fgetbits(stdin)
#define        getoct()  fgetoct(stdin)
#define        gethex()  fgethex(stdin)

#define        putbi(A)  fputbi(A,stdout)
#define       putoct(A)  fputoct(A,stdout)
#define       puthex(A)  fputhex(A,stdout)

#define      mineg(M,A)  ( A == 0 ? 0 : idif(M,A) )
/* #define   miquot(M,A,B)  miprod(M,A,miinv(M,B)) */
 /* M,A */
/* #define    misum(M,A,B)  ((icomp((NUM = isum(A,B)),M) < 0 ) ? NUM : isum(NUM,ineg(M))) */
 /* M */
#define    msdif(m,a,b)  ((a)>=(b) ? (a)-(b) : (a)-(b)+(m))
#define     mshoms(m,A)  (DUM=mshom(m,A), DUM<=m/2?DUM:DUM-m)
#define      msneg(m,a)  ((a) ? (m)-(a) : 0)
#define   msquot(m,a,b)  msprod(m,a,msinv(m,b))
#define    mssum(m,a,b)  (((a)+(b))%(m))

#define        m4hom(a)  (issingle(a) ? ((a)&3) : (lfirst(a)&3))

#define         rabs(R)  (rsign(R)<0 ? rneg(R):(R))
#define         rden(R)  ((R)?lsecond(R):1)
/* #define       rdif(R,S)  rsum(R,rneg(S)) */
 /* R */
#define       rmax(R,S)  (rcomp(R,S)<0 ? (S):(R))
#define       rmin(R,S)  (rcomp(R,S)<0 ? (R):(S))
#define         rnum(R)  ((R)?lfirst(R):0)
/* #define      rquot(R,S)  ((R)?rprod(R,rinv(S)):0) */
 /* R */
#define        rsign(R)  ((R)?isign(lfirst(R)):0)

/*R divs R*/
#define divs( A,B ) ((((A)<0 || (B)<0) && ((A)>=0 || (B)>0) && (A)%(B)\
	 != 0) ? ((A)/(B))-1 : (A)/(B))
/*R divs R*/

/*R mods R*/
#define mods( A,B ) ((((A)<0 || (B)<0) && ((A)>=0 || (B)>0) && (A)%(B)\
	 != 0) ? ((A)%(B))+B : (A)%(B))
/*R mods R*/

/* extern single   POW2[]; */
extern single   LIST_SP[];
extern single   DIFF[];

extern int      SEMIRAND;

extern int      FL_EPS;
extern int      FL_STZ;
extern floating FL_LN2;
extern floating FL_PIE;				 
 /* FL_PIE: noch nicht implementierte Konstante fuer Pi oder Pi/4 */
/* Marc: 110497: Wird wohl auch nicht implementiert. Besser mal 
FL_LN2 bei Gelegenheit rausschmeissen und so wie flPi() realisieren... */

#endif
