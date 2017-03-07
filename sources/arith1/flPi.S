/*M
.SH NAME
flPi - floating point Pi

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flPi();

.SH DESCRIPTION
flPi() returns floating point representation of 
the constant Pi = 3.1415...
The relative error is
.PP
  | ( Pi - f ) / Pi | < 1/2 * (2^30)^( 1 - FL_EPS )
M*/
/*H    
	Version 1       25.02.1992	Marc Conrad
	Version 2	11.12.1992	beschleunigt mit Iteration 
					von Ramanujan.  GL
	Version 3	25.08.1993	Beschleunigung durch PAF.  MC
   DATE flPi          : 920331.930115.931130
H*/

#include<_PAFarith.h>          

#define pic(A) { pi = lcomp( (A), pi ); lpi++; if ( --i == 0 ) goto fertig; }

static floating pi;
static single lpi;
void Fpi();
floating flPi()
{

	    globinit(&pi);
	if (pi == 0)
		lpi = 0;

	if (FL_EPS == lpi);
	else if (FL_EPS < lpi) {
		return (fltofl(pi));
	} else if (FL_EPS <= 35) {
		single i;

		i = FL_EPS;
		pi = _0;
		lpi = 0;
		pic(3)
			pic(152033954)
			pic(140128397)
			pic(206333480)
			pic(771977331)
			pic(287900238)
			pic(35822067)
			pic(121643195)
			pic(983100494)
			pic(455233866)
			pic(35545997)
			pic(5103353)
			pic(342282036)
			pic(977476400)
			pic(180525948)
			pic(636568436)
			pic(1065670069)
			pic(760332869)
			pic(958491997)
			pic(640018412)
			pic(466694411)
			pic(698759149)
			pic(448987095)
			pic(191840363)
			pic(532134113)
			pic(737893001)
			pic(669608871)
			pic(843126724)
			pic(746559780)
			pic(677794284)
			pic(957796208)
			pic(537381770)
			pic(93256726)
			pic(416958518)
			pic(118846694)
fertig:		pi = lcomp(1 - lpi, pi);
	} else {

		pi = flPAFfu(Fpi, 0, 0, 0);
	}           
/*          

alten Version auskommentiert (falls sich Schwierigkeiten mit der PAF-Arithmetik 
ergeben, z.B. bei Portierung, ist dies hier zu verwenden). 

else {

	Fuer FL_EPS >= 36 benutzt man eine quadratisch konvergente
	Iteration fuer 1/pi von S.Ramanujan. 


		int i;
		floating a, an, y, y2, _1, n, z;

		init(a, an, y, y2, _1, n, z);

		i = 0;

		FL_EPS++;

		_1 = itofl(1);

		an = flsquot(_1, 2);
		y = flsqrt(an);	

		do {
			a = an;

			y2 = flprod(y, y);

			y2 = fldif(_1, y2);
			y2 = flsqrt(y2);

			z = fldif(_1, y2);
			n = flsum(_1, y2);
			y = flquot(z, n);
			y2 = flsum(_1, y);
			y2 = flprod(y2, y2);
			y2 = flprod(y2, a);

			n = iexp(2, ++i);
			n = itofl(n);
			n = flprod(n, y);

			an = fldif(y2, n);
		}
		while (flcomp(a, an) != 0);

		pi = flquot(_1, an);

		FL_EPS--;

		pi = fltofl(pi);
		lpi = FL_EPS;
	}      
*/

	return (pi);
}
