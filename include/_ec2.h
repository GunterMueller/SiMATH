# ifndef __ARITH2__
# include <_list.h>
# include <_arith1.h>
# include <_ec1.h>
# include <_pol1.h>
# include <_matr1.h>
# include <_pol2.h>
# include <_arith2.h>
# endif
# define __EC2__



/* MA_SVL ist die Groesse des Siebarrays im Manin-Algorithmus.               */

# define MA_SVL 1000000 

/* LS_STEP ist die Schrittweite beim Ausrechnen der L-Reihe von elliptischen */
/* Kurven.                                                                   */

# define LS_STEP 100 

/* LS_TOL1 ist die erste Abbruchbedingung bei der Berechnung von L-Reihen    */
/* von elliptischen Kurven.                                                  */

# define LS_TOL1  0.000001  /*   1. Abbruchsbedingung fuer L-Reihen */

/* LS_TOL2 ist die zweite Abbruchbedingung bei der Berechnung von L-Reihen   */
/* von elliptischen Kurven.                                                  */

# define LS_TOL2  0.001


#       define ecmspsnfsha(p, a4, a6)  ecmpsnfcssa(p, a4, a6, 1, 0, 0)

single *ecrclser();
single *ecrlserfds(); 
single *ecrlserhdlc();
single *ecrlserhdsc(); 
single *ecrlsers(); 
single *ecrsigns();


# define              ecqnfdmod4( E )  lsecond( lfifth( E ) )
# define            ecqnfflddisc( E )  lfirst( lfifth( E ) )

# define 		   ecqnfa1(E)  lfirst(lfirst(lfirst(E)))
# define 		   ecqnfa2(E)  lsecond(lfirst(lfirst(E)))
# define 		   ecqnfa3(E)  lthird(lfirst(lfirst(E)))
# define 		   ecqnfa4(E)  lfourth(lfirst(lfirst(E)))
# define 		   ecqnfa6(E)  lfifth(lfirst(lfirst(E)))

