# ifndef __ARITH1__
# include <_list.h>
# include <_arith1.h>
# endif
# define __EC1__

/* NTH_TOL ist die Floating-Darstellung von 0.1. Punkte werden im Verlauf */
/* Manin-Algorithmus auf Gleichheit ueberprueft, wenn sich ihre           */
/* Neron-Tate-Hoehen um weniger als 0.1 unterscheiden.                    */

# define NTH_TOL list6(-5,720630779,272518626,138743599,429496741,107374182)

/* Die Neron-Tate-Hoehe wird im Verlauf des Manin-Algorithmus auf NTH_EPS */
/* Dezimalstellen genau berechnet.                                        */

#define NTH_EPS 20

# define               	    putecrp(P)  fputecrp(P,stdout)
# define 	 putecrlistp(PL,modus)  fputecrlistp(PL,modus,stdout)

# define                    ecraca1(E)  lfirst(lfirst(lfirst(E)))
# define                    ecraca2(E)  lsecond(lfirst(lfirst(E)))
# define                    ecraca3(E)  lthird(lfirst(lfirst(E)))
# define                    ecraca4(E)  lfourth(lfirst(lfirst(E)))
# define                    ecraca6(E)  lfifth(lfirst(lfirst(E)))
# define                     getecrp()  fgetecrp(stdin)
# define                  ispecrpai(P)  (lthird(P) == 0 ? 1 : 0)
# define                  putecimin(E)  fputecimin(E, stdout)
# define                  putecisnf(E)  fputecisnf(E, stdout)
# define                     putecr(E)  fputecr(E, stdout)
# define                   putecrac(E)  fputecrac(E, stdout)
# define                  putecrinv(E)  fputecrinv(E, stdout)

extern double _H_BOUND;
extern single _R_C_M;
