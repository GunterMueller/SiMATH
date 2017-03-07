/*C
			qnftonf( a1, t1 )

	"quadratic number field to number field"
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	obj qnftonf( a1, t1 );  obj a1; single t1;
	X = qnftonf( a1, t1 );

	a1 ist ein Objekt mit Kennung t1 = 24, -9, -10 ueber 
	einem quadratischen Zahlkoerper, der durch ein Polynom
	der Form x^2-D mit D ganz und quadratfrei gegeben ist.
	X ist a1 umgewandelt als Objekt ueber dem quadratischen 
	Zahlkoerper, der durch das Polynom Ax^2+Bx+C gegeben ist mit
	a^2-4b = D*k^2, k natuerliche Zahl, a=B/A, b=C/A.
	Laeuft qnftonf fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      1.7.1996      S.Schmitt
H*/

#include <_calc.h>

obj qnftonf( a1, t1 )
obj a1;
single t1;
{
	obj k, a,b,m;
	init(k, a, b, m);
	bind( a1 );

	if(!nfsch) return(ERROR);
	k=lfirst(varlist[nfsch].varwert);
	if(lfirst(k)!=2) return(ERROR);

	if(llength(ecqnfsch)!=3) return(a1);

	/** Die Uebergabeparameter fuer nfeltoqnfel:
	    Das Polynom ist AX^2+BX+C. **/

	a=lsecond(ecqnfsch);
	k=lthird(ecqnfsch);

	switch( t1 )
	{	case 24:a1=qnfeltonfel(a1, a,k);
			break;
		case (-9): a1=lfirst(a1);
			   a1=lfirst(a1);
			   m=lfourth(a1);
			   b=lfifth(a1);
			   m=qnfeltonfel(m,a,k);
			   b=qnfeltonfel(b,a,k);
			   a1=list2(m,b);
			   break;
		case (-10): b=_0;
			    a1=lfirst(a1);
			    a1=lfirst(a1);
			    while(a1!=_0)
			    {	m=lfirst(a1);
				a1=lred(a1);
				m=qnfeltonfel(m,a,k);
				b=lcomp(m,b);
			    }
			    a1=linv(b);
			    break;
				
		default:
		        break;
	}
	
	return( a1 );
}
