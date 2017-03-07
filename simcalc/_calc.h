#include <_pol4.h>

#include <signal.h>
#include <stdlib.h>

#ifdef HAVE_SM_EXT
#define ___CASI
#endif

#define putcomp(a,n) 		fputcomp( a, n, stdout )
#define putcompfx(a,vk,nk) 	fputcompfx( a, vk, nk, stdout )
#define putpc(r,P,V) 		fputpc( r, P, V, stdout )
#define putpfl(r,P,V) 		fputpfl( r, P, V, stdout )

#undef 	putpi
#define putpi(r,P,V) 		fputpi(r,P,V,stdout)

#undef 	putpr
#define putpr(r,P,V) 		fputpr(r,P,V,stdout)

#undef 	putnfel
#define putnfel(F,a,V) 		fputnfel(F,a,V,stdout)
	
#undef 	putqnfid
#define putqnfid(D,A) 		fputqnfidsp(D,A,stdout)

#undef 	putpnf 
#define putpnf(r,F,P,V,Vnf) 	fputpnf( r, F, P, V, Vnf, stdout )

#undef 	putpm 
#define putpm(r,P,V) 		fputpm(r,P,V,stdout)

#undef 	putgfsel
#define putgfsel(a,V) 		fputgfsel(a,V,stdout)

#undef 	putgf2el
#define putgf2el(G,a,V) 	fputgf2el(G,a,V,stdout)

#undef 	putpgfs
#define putpgfs(r,P,V,Vgfs) 	fputpgfs( r, P, V, Vgfs, stdout )

#undef 	putpgf2
#define putpgf2(r,G,P,V,Vgfs) 	fputpgf2( r, G, P, V, Vgfs, stdout )

#define strcat2( s,a,b ) ( *s='\0', strcat(strcat(s,a),b) )
#define  strcat3( s,a,b,c )  strcat( strcat2( s,a,b ), c )
#define  strcat4( s,a,b,c,d )  strcat( strcat( strcat2( s,a,b ), c ), d )

/* now defined in _arith1.h
#define itoc(N) (N ? ( issingle(N) ? list2(list2(0,N),0) : list2(flcons(N,0,llength(N)),0) ) : 0)
#define fltoc(N) (N ? list2(N,0) : 0)
*/

extern single SS_MESS;

# define gf2elred(a,Gm)  udpm2togf2el(Gm,gf2etudpm2(a)) 
# define gfselred(p,a,Gm) pmsrem(1,p,pitopms(1,a,p),Gm)

# ifdef ___LARGE_SYSTEM
#define MAXLV 50000
#define MAXL 100000
# else
#define MAXLV 5000
#define MAXL 10000
# endif 

#define  NUM_FUNC 225
#define  VARLISTLENGTH 525
extern struct var{
	char *varname;
	single typ;
	obj varwert;
} varlist[VARLISTLENGTH], localvar[VARLISTLENGTH];

# define USER_FUNC 50

# ifdef ___SMALL_SYSTEM
# define AVLENGTH 200
# else
# define AVLENGTH 500
# endif

extern char *funstr[USER_FUNC];

extern obj AV[AVLENGTH];
extern char AVNAME[3];

char *ctime();

time_t time();
FILE *fopen();

extern FILE *datei, *fpt[10];
extern char *comm,*dhelp, *datn, *fname[10];
extern single ps, hps, tdiff, tabs, statsch, owsch, owalt, fz; 
extern single DIGITS, OUTPUTDIG, MX, MXNUM, MXUSER, DEPTH;
extern single SIEMENS, RANKCM;
extern floating HEIGHTBOUND;
extern list ecqnfsch;
extern single ecsch, modsch, ssch, pzsch, nfsch, gfsch; 
extern single gfchar, nfon, avsch;
extern single fosch, schleife, breaksch;
extern single assch,prfehl;
extern list VNF, VGF;
extern single anzloc, funktion;

