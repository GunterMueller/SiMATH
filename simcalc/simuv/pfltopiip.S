/*C
			pfltopiip(r,P,ps)

	"polynomial over floating point numbers to polynomial over 
         integers, if possible".
	pol pfltopiip(r,P,ps) single r; pol P; single *ps;
	P1 = pfltopiip(r,P,ps);

	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber floating 
	points.
	P1 = P, und zwar als Polynom ueber den ganzezn Zahlen, falls die
		Basis-Koeffizienten von P schon in Z liegen; in diesem 
		Fall ist *ps gleich 1;
		sonst ist P1 Polynom ueber den floating points
		und *ps gleich 0.
	Die include-Datei <_arith3.h> wird benoetigt.
C*/
/*H
	Version  1      02.03.1995      S.Schmitt/U.Schneiders
H*/

#include<_arith3.h>

pol pfltopiip(r,P,ps)
single r;
pol P;
single *ps;
{
	single e;
	floating A;
	list E;
	pol P1, PS;
	bind(P);
	init(A,E,P1,PS);

	*ps = 1;
	if ( P == 0 ) P1 = P;
	else if (!r) 
        { 	 e = lfirst( P );
	         if( e >= 0 )
		 {   	P1 = lred( P );
			while( e-- )  P1 = lcomp( 0,P1 );
			if( llength( P1 ) == 1 ) P1 = lfirst( P1 );
		 }
		 else {P1 = P; *ps = 0;}
	}
	else 
	{	PS = ptodip(r,P);
		P1 = _0;
		while ((*ps) && PS != _0) 
		{	A = lfirst(PS);
			E = lsecond(PS);
			PS = lred2(PS);
        	 	e = lfirst( A );
	         	if( e >= 0 )
		 	{   	A = lred( A );
				while( e-- )  A = lcomp( 0,A );
				if( llength( A ) == 1 ) A = lfirst( A );
				P1 = lcomp2(E,A,P1);	
		 	}
			else *ps = 0;
		}
		if (*ps) 
		{       P1 = linv(P1);
			P1 = diptop(r,P1);
		}
		else P1 = P;
	}

	return(P1);
}
